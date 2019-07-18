
M = 1000000;
data = zeros(1,M);
q = 2.0;
n = 10;
for i=1:M
    x = 2*rand(n,1)-1;
    y = 2*rand(n,1)-1;
    z = 2*rand(n,1)-1;
    
    dxy = p_angle_unit(x,y,q)./4;
    dyz = p_angle_unit(y,z,q)./4;
    dxz = p_angle_unit(x,z,q)./4;
    
    if (dxz>(dxy+dyz))
        disp('violation');
    end
        
    data(i) = dxy;
end

hist(data)
max(data)
min(data)