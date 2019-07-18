
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
C = cell(nPlanes, 1);
for i=1:nPlanes
    p1 = P1(:, i);
    p2 = P2(:, i);
    p3 = P3(:, i);
    [plane, pavg] = plane_thru_3_points(p1, p2, p3);
    n = plane(1:3);
    
    L(:, i) = plane;
    
    x0 = x0 + pavg;
    
    Ai = eye(dim) - n*n';
    Ci = pavg;
    A{i} = Ai;
    C{i} = Ci;
        
    hold on, plot_triangle(p1, p2, p3, 'r');
end

x0 = x0./nPlanes;
hold on, plot3(x0(1), x0(2), x0(3), 'b+');
x0 = [-1.5; 1.5; 1.5];
projFunc = @(x)(x);
q = 1.0;
iterations = 30;

w = ones(nPlanes, 1);
xNormal = AffSub_solveNormal(w, A, C);
hold on, plot3(xNormal(1), xNormal(2), xNormal(3), 'ko');

disp ('euclidean:');
err = 0;
numValid = 0;
for trials = 1:1000
    Ak = A; Ck = C;
    Ak{1} = Ak{1}+1.75*randn(dim);
    Ck{1} = Ck{1}+1.75*randn(dim, 1);
    Ak{5} = Ak{5}+1.75*randn(dim);
    Ck{5} = Ck{5}+1.75*randn(dim, 1);
    %[X] = AffSub_Lq_weiszfeld(Ak, Ck, x0, q, iterations, projFunc);
    X = AffSub_solveNormal(w, Ak, Ck);
    if (norm(X)<300)
        hold on, plot3(X(1), X(2), X(3), 'ro');
        err = err + norm(X-xNormal);
        numValid = numValid+1;
    end
end
err./numValid
numValid

disp ('q-norm:');
err = 0;
numValid = 0;
for trials = 1:1000
    Ak = A; Ck = C;
    Ak{1} = Ak{1}+1.75*randn(dim);
    Ck{1} = Ck{1}+1.75*randn(dim, 1);
    Ak{5} = Ak{5}+1.75*randn(dim);
    Ck{5} = Ck{5}+1.75*randn(dim, 1);
    [X] = AffSub_Lq_weiszfeld(Ak, Ck, x0, q, iterations, projFunc);
    if (norm(X)<300)
        hold on, plot3(X(1), X(2), X(3), 'go');
        err = err + norm(X-xNormal);
        numValid = numValid+1;
    end
end
err./numValid
numValid
extent = 3;
axis([-extent extent -extent extent -extent extent]);
