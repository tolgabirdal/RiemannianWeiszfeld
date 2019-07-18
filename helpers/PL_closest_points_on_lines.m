function [p1, p2] = PL_closest_points_on_lines(L1, L2)
% L1, L2 : pluecker lines in 3D 
% p1, p2 : 2 points on L1, L2 such that \|p1-p2\| is minimal

[ea1, ea2] = PL_endpoints(L1, -1, 1);
[eb1, eb2] = PL_endpoints(L2, -1, 1);

da = ea2 - ea1;
da = da./norm(da);

db = eb2 - eb1;
db = db./norm(db);

da2 = dot(da,da);
db2 = dot(db,db);
dab = dot(da,db);
alpha1 = dot(da, eb1-ea1);
alpha2 = dot(db, eb1-ea1);

A = [da2 -dab; dab -db2];
b = [alpha1; alpha2];

x = A\b;

p1 = ea1+x(1)*da;
p2 = eb1+x(2)*db;

end