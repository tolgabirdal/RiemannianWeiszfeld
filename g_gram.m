function [G] = g_gram(S,p)

numSubspaces = size(S, 2);
G = zeros(numSubspaces, numSubspaces);
for i=1:numSubspaces
    for j=1:numSubspaces
        G(i,j) = gLp(S(:,i), S(:,j),p);
    end
end

end