function [reprjErrors] = compute_line_repj_errors(L, Pls, points2d)

numViews = length(Pls);

% count how many lines we have
numLines = uint32(length(points2d{1})./2);

% now compute the geometric reprojection error
reprjErrors = 0;
for l=1:numLines
    Lcur = L(:,l);
    reprjError = 0;
    for i=1:numViews
        curPoints = points2d{i};
        Pi = Pls{i};        
        x = curPoints(:, 2*l-1);
        y = curPoints(:, 2*l);
        l2d = Pi*Lcur;
        %l2d = l2d./norm(l2d);
        d = (abs(dot(l2d, x)) + abs(dot(l2d, y))) / norm(l2d(1:2));
        reprjError = reprjError + d;
    end
    reprjError = reprjError./numViews;    
    reprjErrors = [reprjErrors reprjError];
end


end