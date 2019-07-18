function [L, reprjErrors, Pls] = PL_triangulate(points2d, Ps, mode)
% Ps are the point projection matrices
% points2d do not need to correspond, they just need to be on the lines

numViews = length(Ps);

% convert to line projection mats
Pls = cell(numViews, 1);
for i=1:numViews
    Pls{i} = PL_PM_to_PPM(Ps{i});
end

% count how many lines we have
numLines = uint32(length(points2d{1})./2);

if (mode=='BS') % bartoli sturm
    L = [];
    for l=1:numLines
        A = zeros(2*numViews, 6);
        for i=1:numViews
            curPoints = points2d{i};
            Pi = Pls{i};
            
            x = curPoints(:, 2*l-1);
            A(2*i-1, :) = x'*Pi;
            y = curPoints(:, 2*l);
            A(2*i, :) = y'*Pi;
        end
        
        % singular vector associated to the smallest singular value
        [~, S, V] = svd(A);
        [~,minSV] = min(diag(S));
        Lcur = V(:,minSV);
        
        % now project onto pluecker vectors
        Lcur = PL_correct(Lcur);
        
        L = [L Lcur];
    end
else
    % not implemented yet
    L = [];
    for l=1:numLines
        A = zeros(6, 6);
        for i=1:numViews
            curPoints = points2d{i};
            Pi = Pls{i};
            
            x = curPoints(:, 2*l-1);
            y = curPoints(:, 2*l);
            Ai = x*x'+y*y';
            A = A + Pi'*Ai*Pi;
        end
        
        % singular vector associated to the smallest singular value
        [~, S, V] = svd(A);
        [~,minSV] = min(diag(S));
        Lcur = V(:,minSV);
        
        % now project onto pluecker vectors
        Lcur = PL_correct(Lcur);
        Lcur = PL_normalize(Lcur,1);
        
        L = [L Lcur];
    end
end

reprjErrors = compute_line_repj_errors(L, Pls, points2d);

end
