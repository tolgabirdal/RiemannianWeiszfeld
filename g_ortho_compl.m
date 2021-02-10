function [y_s] = g_ortho_compl(y, X, p)
k = size(X, 2);
n = size(X,1);
Gx = g_gram(X, p);
detGx = (det(Gx));
scale = 1./detGx;
gx = zeros(k,1);
for i=1:k
    x = X(:, i);
    gx(i) = gLp(x,y,p);
end
Gx = [gx Gx];
y_s = detGx.*y;
for i=2:k+1
    GxO = Gx;
    x = X(:, i-1);
    GxO(:,i) = [];
    if (mod(i,2)==0)
        y_s = y_s + det(GxO).*x;
    else
        y_s = y_s - det(GxO).*x;
    end
end
y_s = scale .* y_s;
end