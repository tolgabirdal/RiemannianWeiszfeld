
% line in 2d:
n2 = randn(2,1);
n2 = n2./norm(n2);
p2 = randn(2,1);

d = -dot(n2,p2);
l = [n2;d];

A = eye(2) - n2*n2';
C = p2;

M = eye(2) - A;

neg = p2-n2;
pos = p2+n2;
figure, plot([neg(1) pos(1)], [neg(2) pos(2)]);
hold on, plot(p2(1), p2(2), 'bo');

x = rand(2,1);
prj = AffSub_Proj(M, C, x);
hold on, plot(x(1), x(2), 'bo');
hold on, plot(prj(1), prj(2), 'bo');


% plane 
a = rand(4,1);
a = a./norm(a(1:3));
[A] = plane_to_matrix(a);

% point on plane
x = [-a(4)./a(1) 0 0 1]';
y = [0 -a(4)./a(2) 0 1]';
Lxy = PL_create([x y]);

[xl, yl] = PL_endpoints(Lxy, -1, 1);
xl = [xl ; 1];
yl = [yl ; 1];
Lmat = xl*yl' - yl*xl';
Lxy = PL_to_vector(Lmat)

p2 = rand(3,1);
p1 = rand(3,1);
l = p2 - p1;
l = l./norm(l);
p1 = [p1; 1];
p2 = [p2; 1];
LmatP = p1*p2' - p2*p1';
Lp = PL_to_vector(LmatP);



%L = PL_create([p1 p2; 1 1],0);
%L = PL_normalize(L, 0);

Ldual = intersect_plane_at_infty(a);

