function [U] = normal_to_subspace(normal)

A = randn(3);
A(:,1) = normal;
[U, ~] = qr(A);
U(:,1) = normal;

end