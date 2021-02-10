% computes the g-functional for an lp space 1<=p<=inf
function [s] = gLp(x, y, p)

n = length(x);
nrmxp2 = norm(x, p).^(2-p);
s = 0;
for i=1:n
    s = s + abs(x(i)).^(p-1) .* sign(x(i)) .* y(i);
end

s = nrmxp2.*s;

end