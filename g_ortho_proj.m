function [y_s] = g_ortho_proj(y, X, p)
k = size(X, 2);
n = size(X,1);
Gx = g_gram(X, p);
scale = 1./(det(Gx));
gx = zeros(k,1);
for i=1:k
    x = X(:, i);
    gx(i) = gLp(x,y,p);
end
Gx = [gx Gx];
y_s = zeros(n,1);
for i=1:k
    GxO = Gx;
    x = X(:, i);
    GxO(:,i+1) = [];
    if (mod(i,2)==1)
        y_s = y_s + det(GxO).*x;
    else
        y_s = y_s - det(GxO).*x;
    end
end
y_s = -scale .* y_s;
end