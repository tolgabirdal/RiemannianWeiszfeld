function [Lmat] = PL_to_matrix(L, mode)

if(~exist('mode', 'var'))
    mode = 0;
end

v = L(1:3);
w = L(4:6);

if (mode == 1)
    Lmat = [
        0   L(1) L(2) L(3)
        -L(1)  0   L(4) L(5)
        -L(2) -L(4) 0   L(6)
        -L(3) L(5) -L(6) 0];
else
    Lmat = [
        0     v(3) -v(2) -w(1)
        -v(3)  0     v(1) -w(2)
        v(2) -v(1)  0    w(3)
        w(1) w(2) -w(3) 0    ];
end

end