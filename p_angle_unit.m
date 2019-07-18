function [ang] = p_angle_unit(x,y,p)

x=x./norm(x,p);
y=y./norm(y,p);
s = 2-(norm(x-y, p).^p);

minsp = 2-2^p;
centr = (2+minsp)./2;
range = 2.^p;
ang = acos(2*(s-centr)./range);

end