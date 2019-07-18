function [Pl] = PL_PM_to_PPM(P, mode)
% compute the Plucker projection matrix from a standard projection matrix
% as in Bartoli, Sturm. Only mode == 0 is supported currently.

if (~exist('mode', 'var'))
    mode = 0;
end

if (mode==0) % bartoli-sturm
Pbar = P(1:3,1:3);
p = P(1:3, 4);
Pl = [det(Pbar)*inv(Pbar)' skew(p)*Pbar];
else % Zhang and Koch
   % I don't know how to do this. We need  K,R,t. Maybe
   % decomposeProjectionMatrix?
end
end