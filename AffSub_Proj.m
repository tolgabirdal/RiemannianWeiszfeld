% projection onto the affine subspace:
% project x onto the affine subspace determined by A and C
function [X] = AffSub_Proj(A, C, X)

X = C + A*(X-C);

end