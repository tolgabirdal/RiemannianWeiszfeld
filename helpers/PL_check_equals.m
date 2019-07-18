function result = PL_check_equals(L1, L2)
% Test if two Pucker lines are equivalent
% Note, lines can be equivalent even if they have different parameters.
L1 = double(L1);
L2 = double(L2);

L1 = L1./norm(L1);
L2 = L2./norm(L2);
result = abs( 1 - dot((double(L1)), (double(L2))) ) < 10*eps;
end