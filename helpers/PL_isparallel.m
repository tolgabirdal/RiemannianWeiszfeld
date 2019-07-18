function v = PL_isparallel(L1, L2)
% check whether the two plucker lines are parallel
v = norm( cross(L1(4:6), L2(4:6)) ) < 10*eps;
end