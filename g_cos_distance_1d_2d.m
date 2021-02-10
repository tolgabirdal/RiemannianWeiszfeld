% Implements 2.2 of the paper:
% A Formula for the g-Angle between Two Subspaces of a Normed Space
% M. Nur, H. Gunawan, 25 Feb. 2019
% Original idea developed by Milicic:
% 
function [d] = g_cos_distance_1d_2d(u, v1, v2, p)

dimV = length(v1);

nrmu = norm(u,p)^(1./p);

v1n = v1./norm(v1,p);
v2n = v2./norm(v2,p);

d = 0;
for j3=1:dimV
    dcur = 0;
    for j2=1:dimV
        for j1=1:dimV
            A = [v1(j1) v1(j2) v1(j3); 
                 v2(j1) v2(j2) v2(j3);
                 u(j1) u(j2) 0
                ];
            
            dcur = dcur + abs(v1n(j1)).^(p-1) .* abs(v2n(j2)).^(p-1) .* sign(v1(j1)).*sign(v2(j2)).*det(A);
        end
    end
    d = d + abs(dcur).^p;
end

d = d^(1/p)./(nrmu);

end
