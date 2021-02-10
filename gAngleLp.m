% Implements the main result (sec. 2.1) of :
% 
function [theta] = gAngleLp(x, y, p)

div = norm(x,p).*norm(y,p);
theta = gLp(y, x, p)./div;

end