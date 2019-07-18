function [pip] = get_pi_pnorm(p)

xmin = 0;
xmax = 2^(-1./p);
fun = @(x) ((1+abs(x.^(-p)-1).^(1-p)).^(1./p) );
pip = 4*integral(fun,xmin,xmax);

end