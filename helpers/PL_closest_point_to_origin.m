
% for each pluecker line return the closest point to the origin
function [x] = PL_closest_point_to_origin(L)

x = [];
for i = 1:size(L,2)
    a = L(1:3,i);
    b = L(4:6,i);
    p = cross(b, a) / dot(b, b);
    x = [x p];
end

end