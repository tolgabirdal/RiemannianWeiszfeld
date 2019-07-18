function [result] = PL_check_intersects(L1, L2)

result = ~PL_isparallel(L1, L2) && ( abs(p1 * p2) < 10*eps );

end