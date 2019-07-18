function [L] = PL_correct(L)
% Pluecker correction, using the algorithm from:
% Plucker Correction Problem: Analysis and Improvements in Efficiency
% Joao Cardoso, Pedro Miraldo3, and Helder Araujo, 2016 ICPR
a = L(1:3);
b = L(4:6);

p = a'*b;
q = a'*a+b'*b;
mu = 2*p/(q+sqrt(q*q-4*p*p));
u_ = 1/(1-mu*mu);
x = (a-mu*b).*u_;
y = (b-mu*a).*u_;
L = [x ; y];
end