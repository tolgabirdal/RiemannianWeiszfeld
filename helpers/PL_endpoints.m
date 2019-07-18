function [e1,e2] = PL_endpoints(L,s1,s2)
% Plucker line and abscissas to endpoints conversion.
%   [e1,e2] are the two endpoints of the Plucker line L at abscissas s1 and s2.

v = L(4:6);
vn = v./norm(v);
p0 = PL_closest_point_to_origin(L);
e1 = p0 + s1*vn;
e2 = p0 + s2*vn;

return