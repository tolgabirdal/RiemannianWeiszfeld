function L = PL_create_planes(plane1, plane2)
% Create Plucker line from two planes of the form [a b c d] ax+by+cz+d=0.
% L is a Plucker vector that represents the line formed by the intersection \
% of two planes.

pi1 = plane1(:); pi2 = plane2(:);
u = cross(pi1(1:3), pi2(1:3));
v = pi2(4)*pi1(1:3) - pi1(4)*pi2(1:3);

L = [u; v];

end