function [res] = validate_negative(entry, number, op)

n = length(entry);

misplaceds = [];
inplaceds = [];
for i=1:n
    k = number(i);
    [mem,f] = ismember(k,entry);
    if (mem)
        if(f==i)
            inplaceds = [inplaceds, i];
        else
            misplaceds = [misplaceds, i];
        end
    end
end

numOps = length(op);

ni = length(inplaceds);
mi = length(misplaceds);

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