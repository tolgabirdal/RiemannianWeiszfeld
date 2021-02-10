function [U, c] = three_points_to_subspace(p1, p2, p3)

[normal, point] = plane_thru_3_points(p1, p2, p3);
[U, c] = plane_to_subspace(normal, point);

end