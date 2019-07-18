function [p1, p2] = PL_closest_points_on_lines(L1, L2)
% L1, L2 : pluecker lines in 3D 
% p1, p2 : 2 points on L1, L2 such that \|p1-p2\| is minimal

[ea1, ea2] = PL_endpoints(L1, -1, 1);
[eb1, eb2] = PL_endpoints(L2, -1, 1);

[p1, p2] = closest_points_on_lines(ea1, ea2, eb1, eb2);

end