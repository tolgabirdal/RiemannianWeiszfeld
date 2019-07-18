% orthogonal q-disatnce from X to the affine subspace
function [d] = AffSub_dist(A, C, X, q)

M = eye(size(A))-A;
d = norm (M*(X-C), q);

end