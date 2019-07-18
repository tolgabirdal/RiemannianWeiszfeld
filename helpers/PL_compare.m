function [distances] = PL_compare(L1s, L2s)

nL = length(L1s);
distances = zeros(nL, 1);
for i=1:nL
    L1 = L1s(:,i);
    L2 = L2s(:,i);
    v1 = L1(4:6);
    v2 = L2(4:6);
    
    v1 = v1./norm(v1);
    v2 = v2./norm(v2);

    distances(i) = 1-abs(dot(v1,v2));
end


end