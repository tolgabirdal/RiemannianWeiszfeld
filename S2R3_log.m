% map the point Y on a manifold onto the tangent space of X
function [Y] = S2R3_log(X, Y)

Y(1:3) = S2_log(X, Y);
Y(4:6) = Y(4:6)-X(4:6);

end
