function [p] = PL_intersect(L1, L2)
% Intersect L1 and L2 intersect and return the point closest to L2
u1 = L1(1:3);
v1 = L1(1:3);
u2 = L2(1:3);
v2 = L2(4:6);

p0 = PL_closest_point_to_origin(L1);
e = cross(u1,u2)/dot(u1,v2);
v  = v1./norm(v1);

% solve the system e = p0 + t*u for variable t:
t = v'*(e - p0);

end