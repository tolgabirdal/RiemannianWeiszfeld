function [L_normalized, DSM, T_prenorm] = PL_normalize_hartley(L)
% hartley normalization on Plucker lines

numLines = size(L,2);

% Normalize each 3D line s.t. norm(V)=sqrt(3)
for i = 1:numLines
    V = L(4:6,i);
    L(:,i) = sqrt(3) * L(:,i) ./ norm(V);
end

% Translation: translate 3D lines s.t. the closest point to them is the Origin
T_prenorm = closestPointToPlueckerLines(L);
DT = [eye(3) skewSymMat(-T_prenorm); zeros(3) eye(3)]; % line displacement matrix
L_T = DT * L;

% Anisotropic scaling: scale 3D lines s.t. their U and V parts have the same
% average magnitude
U_abs_mean = mean(     abs( L_T(1:3, :) ), 2);
V_abs_mean = mean(mean(abs( L_T(4:6, :) ) ) );
S_prenorm = V_abs_mean ./ U_abs_mean;
DS  = [diag(S_prenorm) zeros(3); zeros(3) eye(3)]; % line scaling matrix

% Combine translation and scaling
DSM = DS * DT; % line similarity matrix

L_normalized = DSM * L;

end