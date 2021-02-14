
nLines = 32;
% P1 = randn(2, nLines);
% P2 = randn(2, nLines);
P1 = [-1 -1; -1 1; 1 1; 1 -1; 0 -1; -1 0; 0 1; 1 0]';
P2 = [-1 1; 1 1; 1 -1; -1 -1; -1 0; 0 1; 1 0; 0 -1]';
nLines = size(P1, 2);
L = zeros(3, nLines);
x0 = zeros(2,1);

 figure;
A = cell(nLines, 1);
C = cell(nLines, 1);
for i=1:nLines
    p1 = P1(:, i);
    p2 = P2(:, i);
    n = p2 - p1;
    n = n./norm(n);
    n = [-n(2); n(1)];
    pavg = 0.5*(p2+p1);
    
    d = -dot(n, pavg);
    li = [n; d];
    L(:, i) = li;
    
    x0 = x0 + pavg;
    
    Ai = eye(2) - n*n';
    Ci = pavg;
    A{i} = Ai;
    C{i} = Ci;
        
    hold on, plot([p1(1) p2(1)], [p1(2) p2(2)], 'b-');
end

x0 = x0./nLines;
hold on, plot(x0(1), x0(2), 'b+');
x0 = [-0.5; 0.5]+2;
projFunc = @(x)(x);
q = 1.01;
iterations = 30;

w = ones(nLines, 1);
xNormal = AffSub_solveNormal(w, A, C);
hold on, plot(xNormal(1), xNormal(2), 'ko');

for trials = 1:1000
    Ak = A; Ck = C;
    Ak{1} = Ak{1}+0.275*randn(2, 2);
    Ck{1} = Ck{1}+0.275*randn(2, 1);
    Ak{5} = Ak{5}+0.275*randn(2, 2);
    Ck{5} = Ck{5}+0.275*randn(2, 1);
    [X] = AffSub_Lq_weiszfeld(Ak, Ck, x0, q, iterations, projFunc);
    if (norm(X)<10)
        hold on, plot(X(1), X(2), 'ro');
    end
end

axis([-3 3 -3 3]);
