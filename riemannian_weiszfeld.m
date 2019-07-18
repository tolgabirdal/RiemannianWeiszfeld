
function [X] = riemannian_weiszfeld(X0, AffineSpaces, q, stepSize, maxUpdate, maxIterations, expMap, logMap)

epsAngle = 0.0000001;
maxUpdate = max(maxUpdate, epsAngle);
update = 10* maxUpdate;

i=0;
numSubSpaces = size(X0, 2);
dim = size(X0, 1);
X = X0;

while (update > maxUpdate && i <= maxIterations)
        
    wiSum = 0;    
    Y = zeros(dim, 1);
    for k = 1:numSubSpaces
        Si = AffineSpaces{k};
        Ai = Si(:, 1:end-1);
        Ci = Si(:, end);
        PSi = AffSub_Proj(Ai, Ci, X);
        
        wi = AffSub_dist(Ai, Ci, PSi, q-2);
        Yi = logMap(PSi); 
        Y = Y + wi .* Yi;
        wiSum = wiSum + wi;
    end
    
    if (wiSum > eps)
        Y = Y./wiSum;
        update = norm(Y);
        if (update>eps)
            X = expMap(Y, X, stepSize);
        end
    end
    
    i = i+1;
    
end

end