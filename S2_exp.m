% v is a non-zero tangent vector at x
% v does not have to be unit, its norm encodes the length
function [x] = S2_exp(x, v, t)

vn = norm(v);
if (vn>eps)
    vnt = vn.*t;
    x = cos(vnt).*x + sin(vnt).*v./vn;
end
end
