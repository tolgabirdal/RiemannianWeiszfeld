function [x] = AffSub_solveNormal(w, Ais, Cis)

numSubspace = length(Ais);

A = zeros(size(Ais{1}));
b = zeros(size(Cis{1}));
I = eye(size(A));
for i=1:numSubspace
    Mi = (I-Ais{i});
    A = A + w(i)*Mi;
    b = b + w(i)*Mi*Cis{i};
end

x = A\b;

end