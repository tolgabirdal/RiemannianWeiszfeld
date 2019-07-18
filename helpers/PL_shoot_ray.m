function [L] = PL_shoot_ray(K, C, p)
% PL_shoot_ray Plucker ray from optical center through pixel.
%   L is a Plucker line passing over pixel p and the
%   optical center give by C, in a pin-Hole camera of intrinsic vector K.

L = [C; K\p];

end