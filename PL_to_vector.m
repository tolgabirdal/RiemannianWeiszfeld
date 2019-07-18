function [L] = PL_to_vector(Lmat)

L = [
    Lmat(1,2);
    Lmat(1,3);
    Lmat(1,4);
    Lmat(2,3);
    Lmat(2,4);
    Lmat(3,4)
    ]; 
end