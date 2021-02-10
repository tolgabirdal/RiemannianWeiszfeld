function [res] = validate_entry(entry, number, op)

n = length(entry);

ni = 0; % number of well placeds
mi = 0; % number of misplaceds
for i=1:n
    k = number(i);
    [mem,f] = ismember(k,entry);
    if (mem)
        if(f==i)
            ni = ni + 1;
        else
            mi = mi + 1;
        end
    end
end

numOps = length(op);

if (ni+mi~=numOps)
    res = false;
    return;
end

numPlus = sum(op);
numNeg = numOps-numPlus;

if (numPlus~=ni || numNeg~=mi)
    res = false;
    return;
end

res = true;

end