function [ang] = p_angle(x,y,p)

x=x./norm(x,p);
y=y./norm(y,p);
s = 2-(norm(x+y, p).^p);
ang = acos((s+2));

end