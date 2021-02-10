function [U, c] = plane_to_subspace(normal, point)

U = normal_to_subspace(normal);
U = U(:,2:end);
c = point;

end