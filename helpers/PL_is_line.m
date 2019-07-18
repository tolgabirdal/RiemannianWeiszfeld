function result = PL_is_line(L)
% PL_is_line Check if L is a plucker line.
result = (abs(abs(PL_angle(L))-pi/2) < eps);
end