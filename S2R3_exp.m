% v is a non-zero tangent vector at x
% v does not have to be unit, its norm encodes the length
function [x6d] = S2R3_exp(v6d, x6d, t)

v = v6d(1:3);
vn = norm(v);
if (vn>eps)
    vnt = vn.*t;
    x6d(1:3) = cos(vnt).*x + sin(vnt).*v./vn;
end

x6d(4:6) = x6d + t.*v6d;

end
