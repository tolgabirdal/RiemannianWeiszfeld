function [A] = plane_to_matrix(a, mode)

if (mode==0)
    A = [-a(2) -a(3) -a(4) 0 0 0;
        a(1) 0 0 -a(3) -a(4) 0;
        0 a(1) 0 a(2) 0 -a(4);
        0 0 a(1) 0 a(2) a(3)
        ];
else
    A = [-a(2) -a(3) -a(4) 0 0 0;
        a(1) 0 0 -a(3) -a(4) 0;
        0 a(1) 0 a(2) 0 -a(4);
        0 0 a(1) 0 a(2) a(3)
        0 0 0 0 0 0
        0 0 0 0 0 0
        ];
end

end