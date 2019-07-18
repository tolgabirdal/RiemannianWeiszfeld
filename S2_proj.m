% project y onto the tangent space of x
function [Y] = S2_proj(X, Y)

Y = Y - (X'*Y)*X;

end
