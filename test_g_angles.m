
v1 = [1 0 0];
v2 = [0 1 0];
u = [0.5 0.5 0];
% u = [1 0 0];

[V, c] = plane_to_subspace([1,0,0]',[0,0,0]');
% u = [-1,-1,0];
u = u./norm(u,2);

rad2deg(acos(g_cos_distance_1d_2d(u, V(:,1), V(:,2), 1.1)))