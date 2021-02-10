
dim = 3;
nPlanes = 32;
% P1 = randn(2, nPlanes);
% P2 = randn(2, nPlanes);
P1 = [1 0 0; -1 0 0; 1 0 0; -1 0 0; 1 0 0; -1 0 0; 1 0 0; -1 0 0]';
P2 = [0 1 0; 0 1 0; 0 -1 0; 0 -1 0; 0 1 0; 0 1 0; 0 -1 0; 0 -1 0]';
P3 = [0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 -1; 0 0 -1; 0 0 -1; 0 0 -1]';
nPlanes = size(P1, 2);
L = zeros(dim+1, nPlanes);
x0 = zeros(3,1);

figure;
A = cell(nPlanes, 1);
Us = cell(nPlanes, 1);
M = cell(nPlanes, 1);
C = cell(nPlanes, 1);
ns = cell(nPlanes, 1);
for i=1:nPlanes
    p1 = P1(:, i);
    p2 = P2(:, i);
    p3 = P3(:, i);
    [plane, pavg] = plane_thru_3_points(p1, p2, p3);
    n = plane(1:3);
    
    [U, c] = plane_to_subspace(n, pavg);
        
    L(:, i) = plane;
    
    x0 = x0 + pavg;
    
    Mi = eye(dim) - n*n';
    Ai = n*n';
    Ci = pavg;
    
    ns{i} = n;
    M{i} = Mi;
    A{i} = Ai;
    C{i} = Ci;
    Us{i} = U;
    
    hold on, plot_triangle(p1, p2, p3, 'r');
end

x0 = x0./nPlanes;
hold on, plot3(x0(1), x0(2), x0(3), 'b+');
x0 = [-1.5; 1.5; 1.5];
projFunc = @(x)(x);
q = 2.0;
iterations = 200;

x0 = randn(3,1);
x0 = x0./norm(x0);
u = x0;

figure;
for i=1:3:9
    V = Us{i};
    n = ns{i};    
    %hold on, quiver3(0,0,0,n(1),n(2),n(3));
    hold on, plotp(V(:,1),V(:,2),'b');
end
hold on, quiver3(0,0,0,u(1),u(2),u(3),'LineWidth',3);

i=0;

while (i< iterations)
    Xnew = zeros(3, 1);
    w = zeros(nPlanes,1);
    %figure, 
    for k=1:3:9
        V = Us{k};
        
        
        %hold on, quiver3(0,0,0,u(1),u(2),u(3),'LineWidth',3);
        %ug = g_ortho_compl(u, V, q);
        % ug = g_ortho_proj(u, V, q);
        ug = (V*inv(V'*V)*V')*u;
        %hold on, quiver3(0,0,0,ug(1),ug(2),ug(3),'LineWidth',3);
        %ug = u - u_s; % g-orthogonal complement of u
        %dq = norm(ug, q) ./ norm(u, q);
        %d2 = norm(ug) ./ norm(u);
        %w_k = dq./d2;
        ug=ug./norm(ug);
        w_k = norm(u-ug).^(q-2);
        
        % wk = g_cos_distance_1d_2d(u, V(:,1), V(:,2), q)./g_cos_distance_1d_2d(u, V(:,1), V(:,2), 2);
        
        Xnew = Xnew + w_k*ug;
        w(k) = w_k;
    end
    
    %wNorm = sum(w); 
    wNorm = norm(Xnew);
    Xnew = Xnew ./ wNorm;
    
    u = Xnew;
    %hold on, plot(Xcur(1), Xcur(2), 'go');
    hold on, quiver3(0,0,0,u(1),u(2),u(3),'LineWidth',3);
    drawnow;
    %pause(0.1);
    u'
    i = i+1;
end
