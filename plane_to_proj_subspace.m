function [M, C] = plane_to_proj_subspace(plane)

plane = plane./norm(plane(1:3));
[A] = plane_to_matrix(plane);
Ldual = intersect_plane_at_infty(a);

M = Ldual*A;
C = zeros(4,1);

end
