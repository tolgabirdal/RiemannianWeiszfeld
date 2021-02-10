close all

addpath('./helpers');

[SynthData] = gen_synth_data_cube();

l2d = SynthData.endPoints2d;
K = SynthData.K;
Rs = SynthData.Rs;
ts = SynthData.ts;
close all; figure;
noiseAmount = 0.5;
numTestViews = 3;
planes = zeros(4, numTestViews);
As = cell(numTestViews, 1);
for cam=1:numTestViews
    p1 = ts{cam}; % + noiseAmount*(rand(3,1)-0.5);
    p2 = 5*Rs{cam}'*(inv(K)*l2d{cam}(:,1))+ts{cam} + noiseAmount*(rand(3,1)-0.5);
    p3 = 5*Rs{cam}'*(inv(K)*l2d{cam}(:,2))+ts{cam} + noiseAmount*(rand(3,1)-0.5);
    
    [plane, pavg] = plane_thru_3_points(p1, p2, p3);
    A = plane_to_matrix(plane, 0);
    As{cam} = A;
    planes(:,cam) = plane;
    
    plotCam.Orientation = Rs{cam};
    plotCam.Location = ts{cam};
    hold on, plotCamera(plotCam,'Size',0.1);
    hold on, plot_triangle(p1, p2, p3, 'r');
end
axis equal;

LsNoise = PL_triangulate({SynthData.endPoints2d{1:3}}, {SynthData.Ps{1:3}}, 'BS');
PL_draw(LsNoise(:,1), 1, 0, [0,0,1]);

%return ;


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
M = cell(nPlanes, 1);
C = cell(nPlanes, 1);
for i=1:nPlanes
    p1 = P1(:, i);
    p2 = P2(:, i);
    p3 = P3(:, i);
    [plane, pavg] = plane_thru_3_points(p1, p2, p3);
    n = plane(1:3);
    
    L(:, i) = plane;
    
    x0 = x0 + pavg;
    
    Mi = eye(dim) - n*n';
    Ai = n*n';
    Ci = pavg;
    
    M{i} = Mi;
    A{i} = Ai;
    C{i} = Ci;
        
    hold on, plot_triangle(p1, p2, p3, 'r');
end

x0 = x0./nPlanes;
hold on, plot3(x0(1), x0(2), x0(3), 'b+');
x0 = [-1.5; 1.5; 1.5];
projFunc = @(x)(x);
q = 1.0;
iterations = 200;

w = ones(nPlanes, 1);
xNormal = AffSub_solveNormal(w, M, C);
hold on, plot3(xNormal(1), xNormal(2), xNormal(3), 'ko');

%return;
randScale = 0.25;

disp ('euclidean:');
err = 0;
numValid = 0;
for trials = 1:1000
    Ak = A; Ck = C; Mk = M;
    Ak{1} = Ak{1}+randScale*randn(dim);
    Ck{1} = Ck{1}+randScale*randn(dim, 1);
    Ak{5} = Ak{5}+randScale*randn(dim);
    Ck{5} = Ck{5}+randScale*randn(dim, 1);
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
    Ak = A; Ck = C; Mk = M;
    Ak{1} = Ak{1}+randScale*randn(dim);
    Ck{1} = Ck{1}+randScale*randn(dim, 1);
    Ak{5} = Ak{5}+randScale*randn(dim);
    Ck{5} = Ck{5}+randScale*randn(dim, 1);
    x0_sol = AffSub_solveNormal(w, Ak, Ck);
    [X] = AffSub_Lq_weiszfeld(Ak, Ck, x0_sol, q, iterations, projFunc);
    
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
