function [perm] = randperm_indices(indices, k)
perm = randperm(length(indices), k);
perm = indices(perm);
end