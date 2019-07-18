function [ R, t ] = PL_estimate_pose( L, x_c , normalizeHartley)
%DLT_PLUCKER_LINES Camera pose estimation from line correspondences using
% the method follows the paper: Pribyl, B., Zemcík, P. and Cadík, M.: Camera Pose
% Estimation from Lines using Plücker Coordinates, BMVC 2015,
% http://dx.doi.org/10.5244/C.29.45
%
%   X_W - 4x(2N) matrix of 3D line endpoints [X; Y; Z; W]
%   x_c - 3x(2N) matrix of 2D line endpoints [x; y; w]

if(~exist('normalizeHartley', 'var'))
    normalizeHartley = 1;
end

nLines = size(L,2);

if (nLines < 9)
    error(['At least 9 lines have to be supplied.']);
end

%% Construct 2D line equations from projected endpoints
l_c = cross(x_c(:, 1:2:end), x_c(:, 2:2:end));

%% Prenormalization of 3D lines
if (normalizeHartley)
    % Normalize each 3D line s.t. norm(V)=sqrt(3)
    [L_W, DS, T_prenorm] = normalize_lines_3D(L);
    
    %% Pre-normalization of 2D lines - treat them as 2D points
    
    % "Translation": "translate" lines so that their centroid is at the Origin
    ind = ~(l_c(3,:)==0);
    t_prenorm = mean([l_c(1,ind) ./ l_c(3,ind); l_c(2,ind) ./ l_c(3,ind)], 2);
    dt = [eye(2) -t_prenorm; 0 0 1];
    l_c_t = dt * l_c;
    
    % "Scaling": "scale" lines anisotropically
    s_prenorm = 1 ./ mean(abs([l_c_t(1,ind) ./ l_c_t(3,ind); l_c_t(2,ind) ./ l_c_t(3,ind)]), 2);
    ds = diag([s_prenorm;  1]);
    
    % Combine "translation" and "scaling"
    dsm = ds * dt;
    
    % Apply all prenormalizing transformations at once
    l_c = dsm * l_c;
else
    L_W = L;
    T_prenorm = [0 0 0]';
end

nLines = size(L_W, 2);

%% Construct the measurement matrix
M1 = kron( ...
    [1 1 1 1 1 1], ...
    [ ...
    l_c(3,:)'    zeros(nLines,1)   -l_c(1,:)'; ...
    zeros(nLines,1)  l_c(3,:)'     -l_c(2,:)'  ...
    ] ...
    );
M2 = kron([L_W L_W]', [1 1 1]);
M  = M1 .* M2;

%% Linear estimation of the line projection matrix
if (size(M,1) < size(M,2))
    [~, ~, V] = svd(M);
else
    [~, ~, V] = svd(M, 'econ');
end

% Form a 3x6 estimate of the line projection matrix from the last right singular vector
P_e = reshape( V(:,end), 3, 6 );

if (normalizeHartley)
    %% Post-transformation reverting the prenormalizing transformations
    P_e = dsm \ P_e;  % revert "translation" and "scaling" of 2D lines
    
    % post-transformation un-doing the pre-normalizing transformations of 3D lines
    P_e = P_e * DS; % revert scaling of 3D lines
    % translation of 3D lines is reverted _after_ camera position is estimated (better accuracy)
end

%% Extract parameters from the line projection matrix
[R, t] = pose_from_LPM(P_e);
t = t-T_prenorm;

return;
end
