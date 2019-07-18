% map the point Y on a manifold onto the tangent space of X
function [Y] = S2_log(X, Y)

dYX = Y - X;
P = S2_proj(dYX);
Y = P .* norm (dYX)./norm (P);

end
