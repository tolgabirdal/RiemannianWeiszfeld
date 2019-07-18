function [Ls] = PL_add_noise(Ls, sigma)
% add Gaussian noise on a bunch of Plucker lines
% Algorithm : find the line end-points and add the noise there

numLines = size(Ls,2);
for j=1:numLines
    [el1, el2] = PL_endpoints(Ls(:,j),-1,1);

    el1 = el1 + sigma*randn(3,1); 
    el2 = el2 + sigma*randn(3,1); 

    Li = PL_create( [el1 el2; 1 1] );
    
    Ls(:,j) = Li;
end

end