
number = [2 0 9 3];

ops = {0, 1, [1,0], 1, [0,0]}; % operators

rng(42);

n = length(number);
lengthTable = length(ops);
table = zeros(lengthTable, n);

for j=1:length(ops)
    op = ops{j};
    numOps = length(op);
    numPlus = sum(op);
    numNeg = numOps-numPlus;
    
    available = ones(1, n);
    entry = -ones(1, n);
    
    % random indices to keep fixed
    if (numPlus>0)
        fixed = randperm(n, numPlus);
        entry(fixed) = number(fixed);
        available(fixed) = 0;
    end
    
    if (numNeg>0)
        % random indices to permute
        remainInd = find(available);
        perm = randperm_indices(remainInd, numNeg);
        available(perm) = 0;
        
        remainIndEntry = find(available);
        permEntry = randperm_indices(remainIndEntry, numNeg);
        entry(permEntry) = number(perm);
    end
    
    % fill with unique 
    usedNum = number(available==0);
    allNum = 0:9;
    difference = setdiff(allNum, number);
    diffSelect = randperm(length(difference), n-length(usedNum));
    entry(entry==-1) = difference( diffSelect );
    
    table(j, :) = entry;
end

% display the problem
table
ops
