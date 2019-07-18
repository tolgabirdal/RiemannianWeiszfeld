function [L] = PL_normalize(L, mode)
% normalize all plucker lines

if (mode==0) % ||L||=1
    denom = sqrt(dot(L, L, 1));
else % v-normalize
    denom = sqrt(dot(L(4:6,:), L(4:6,:), 1));
end

L = L./denom;

end