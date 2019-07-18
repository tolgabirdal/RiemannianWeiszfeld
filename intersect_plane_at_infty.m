function [L] = intersect_plane_at_infty(alpha)

pi_inf = [0 0 0 1]';
L = alpha*pi_inf' - pi_inf*alpha';

end