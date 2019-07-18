function [L, reprjErrors] = PL_triangulate_weiszfeld(points2d, Ps, mode)
% Ps are the point projection matrices
% points2d do not need to correspond, they just need to be on the lines

numViews = length(Ps);
numLines = uint32(length(points2d{1})./2);

[L, reprjErrors, Pls] = PL_triangulate(points2d, Ps, mode);

w = ones(numViews,1);

% perturb L:
L = L+0.1*rand(size(L));
for i=1:size(L,2)
    L(:,i) = PL_correct(L(:,i));
end

iterations = 20;
q = 2;
for l=1:numLines
    Lcur = L(l, :);
    for i=1:iterations
        Mis = cell(numViews, 1);
        Cis = cell(numViews, 1);        
        
        for k=1:numViews
            curPoints = points2d{k};
            Pi = Pls{k};
            
            x = curPoints(:, 2*l-1);
            y = curPoints(:, 2*l);
            
            l2d = Pi*Lcur;
            l2d = l2d./norm(l2d(1:2));
            n2d = l2d(1:2);
            C = [0 -n2d(2)./n2d(3)]; % an arbitrary point
            
            A = eye(2) - n2d*n2d';
            M = I-A;
            
            px = AffSub_Proj(M, C, x);
            py = AffSub_Proj(M, C, y);
            
            
        end
        
        [x] = AffSub_solveNormal(w, Mis, Cis);
        
        % now project onto pluecker vectors
        Lcur = PL_correct(Lcur);
        
        L = [L Lcur];
    end
    
end

end
