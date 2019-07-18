function [plane, pavg] = plane_thru_3_points(p1, p2, p3)
p12 = p1 - p2;
p13 = p1 - p3;
n = cross(p12, p13);
n = n./ norm(n);
pavg = (p1+p2+p3)./3;
d = -dot(n, pavg);
plane = [n; d];
end