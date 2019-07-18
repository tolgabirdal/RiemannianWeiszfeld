function [X] = Lq_weiszfeld222(A, C, X0, q, iterations, projFunc)
% Ps are the point projection matrices
% points2d do not need to correspond, they just need to be on the lines

X = X0;
numPoints = size(X, 2);
numSubspaces = length(A);

for l=1:numPoints
    Xcur = X(l, :);
    w = ones(numViews,1);
    i=0;
    while (i< iterations)
        Xnew = zeros(size(Xcur));
        for k=1:numSubspaces
            Ak = A{k};
            Ck = C{k};
            Xproj = AffSub_Proj(Ak, Ck, Xcur);
            wk = norm(Xcur - Xproj, q);
            Xnew = Xnew + wk*Xproj;
            w(k) = wk;
        end
        
        wNorm = sum(w);
        Xnew = Xnew ./ wNorm;        
        
        % now project onto plausible solutions
        Xnew = projFunc(Xnew);
        
        Xcur = Xnew;
        i = i+1;
    end
    X(l, :) = Xcur;
end

end
