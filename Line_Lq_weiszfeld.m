function [X] = Line_Lq_weiszfeld(A, L0, q, iterations, projFunc)
% Ps are the point projection matrices
% points2d do not need to correspond, they just need to be on the lines

L = L0;
numLines = size(L, 2);
numSubspaces = length(A);

for l=1:numLines
    Lcur = L(:, l);
    %hold on, plot(Xcur(1), Xcur(2), 'ro');
    w = ones(numSubspaces,1);
    i=0;
    while (i< iterations)
        Lnew = zeros(size(Lcur));
        for k=1:numSubspaces
            Ak = A{k};
            Lproj = Ak*Lcur;
            wk = norm(Xproj).^(q-2);
            Lnew = Lnew + wk*Lproj;
            w(k) = wk;
        end
        
        wNorm = sum(w);
        Lnew = Lnew ./ wNorm;        
        
        % now project onto plausible solutions
        Lnew = projFunc(Lnew);
        Xcur = Lnew;
        %hold on, plot(Xcur(1), Xcur(2), 'ro');
        %drawnow;
        %pause(0.1);
        i = i+1;
    end
    L(:, l) = Lcur;
end

end
