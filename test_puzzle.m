
table = [1 5 3 7; 
        2 4 6 8; 
        6 9 4 3; 
        4 0 7 8; 
        6 3 1 2]; % the search table
ops = {0, 1, [1,0], 1, [0,0]}; % operators

% can be done more efficiently by searching and not generation
uniqueNumbers = [];
for i=0:9
    for j=0:9
        if (i~=j)
            for k=0:9
                if (k~=j && k~=i)
                    for l=0:9
                        if (l~=k && l~=j && l~=i)
                            uniqueNumbers = [uniqueNumbers; [i,j,k,l]];
                        end
                    end
                end
            end
        end
    end
end

n = length(uniqueNumbers);

found = false;
i=1;
while(i<=n)
    num = uniqueNumbers(i,:);
    allFound = zeros(5,1);
    for j=1:length(ops)
        entry = table(j,:);
        op = ops{j};
        if (validate_entry(entry, num, op))
            allFound(j) = true;
        end
    end
    found = all(allFound);
    if (found==true)
        num
    end
    i=i+1;imagesc(a)
end
%num

x0 = uniqueNumbers(size(uniqueNumbers,1)/2,:);
options = optimset('PlotFcns',@optimplotfval);
% x = fminsearch(@validate_table, x0, options)
IntCon = [1,2,3,4];
opts = optimoptions('ga','PlotFcn',@gaplotbestf);
[x,fval,exitflag] = ga(@validate_table,4,[],[],[],[], [1,0,0,0],[9,9,9,9],[],IntCon,options);


