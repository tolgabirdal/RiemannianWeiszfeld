function [d] = p_distance(x,y,p)

x=x./norm(x,p);
y=y./norm(y,p);
s = 2-(norm(x-y, p).^p);

minsp = 2-2^p;
range = 2.^p;
d = 1.0-(s-minsp)./range;

end