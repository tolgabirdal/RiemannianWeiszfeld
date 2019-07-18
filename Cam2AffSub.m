function [Ai, Ci] = Cam2AffSub (endPoints, K, R, t)

x1 = endPoints(:,1);
x2 = endPoints(:,2);

RK = R'*inv(K);
x1h = RK*x1+t;
x2h = RK*x2+t;



end