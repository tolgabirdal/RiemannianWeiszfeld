function [U, W] = PL_to_orthonormal(L)
% converts plucker line to orthonormal representation where
% U \in SO(3) and W \in SO(2)

a = L(1:3);
b = L(4:6);

na = norm(a);
nb = norm(b);

anrm = a./na;
bnrm = b./nb;

P1 = zeros(3,2);
P1(1,1) = na;
P1(2,2) = nb;
C = [anrm bnrm cross(anrm, bnrm)] * P1;

[U, S] = qr(C); % U \in SO(3)

% form the W \in SO(2)
sigma = diag(S);
W = [sigma(1) -sigma(2); sigma2 sigma1]./norm(sigma);

%omega = [sigma R2q(U)];

end