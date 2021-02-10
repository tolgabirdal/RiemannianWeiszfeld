function [d] = validate_table(number)

number = double(int32(number));

if (number(1) == number(2) || number(2)==number(3) || number(3)==number(4) || number(4)==number(1) || number(2)==number(3) || number(1)==number(3))
    d = 100;
    return ;
end

table = [1 5 3 7; 
        2 4 6 8; 
        6 9 4 3; 
        4 0 7 8; 
        6 3 1 2]; % the search table
ops = {0, 1, [1,0], 1, [0,0]}; % operators

allFound = zeros(size(table,1),1);
for j=1:length(ops)
    entry = table(j,:);
    op = ops{j};
    if (validate_entry(entry, number, op))
        allFound(j) = true;
    end
end

d = sum(allFound);

end