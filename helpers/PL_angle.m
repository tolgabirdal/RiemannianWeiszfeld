function a = PL_angle(L)

% Angle between Plucker vectors.
%   PL_angle(L) gives the angle between the two Plucker sub-vectors u
%   and v. The plucker line L is a 6-vector L = [u;v] with two 3-vectors u
%   and v. These vectors should be orthogonal in order for the vector L to
%   be a line.

n = L(1:3);
v = L(4:6);

a = atan(norm(cross(v,n))/dot(v,n));

end