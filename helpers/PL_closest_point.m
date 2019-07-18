function [ x ] = PL_closest_point( L, lambda )

if (~exist('lambda', 'var'))
    lambda = 2;
end

numLines = size(L,2);

x = [];
for i =1:numLines
    L0 = L(:,i);
    [e1,e2] = PL_endpoints(L0, -lambda, lambda);
    %hold on, line([e1(1) e2(1)], [e1(2) e2(2)], [e1(3) e2(3)], 'LineWidth', 0.1, 'Color', 'red');
    
    x = [x [e1; 1], [e2; 1]];
end

%% Normalize the homogeneous coordinates of endpoints
for i = 1:4
    x(i,:) = x(i,:) ./ x(end,:);
end

%% Algorithm
e = x(1:3, 2:2:end) - x(1:3, 1:2:end);
e = normc(e); % orthonormal base of the subspace, i.e. the unit direction vector of current line
A = repmat(e(:), 1, 3) .* kron(e', ones(3, 1));
M = repmat(eye(3), numLines, 1) - A;
C = x(1:3, 1:2:end);

% I won't use weights for the moment, maybe later for incorporating confidence
% M = sqrt(kron(w, ones(3  , 3))) .* M; 
% c = sqrt(kron(w, ones(3, 1))) .* dot(M, kron(C', ones(3, 1)), 2);
c = dot(M, kron(C', ones(3, 1)), 2);

% compute the closest point
x = (M'*M) \ (M' * c);

end