function [endPoints1, endPoints2] = PL_clip(L, endPoints2d, K, Rs, ts, shouldPlot)
% Clip the Plucker lines such that the projection line remains in the
% images. The new line is given by the endpoints.
numViews = length(Rs);
numLines = size(L,2);

endPoints1 = zeros(3, numLines);
endPoints2 = zeros(3, numLines);

% convert to line projection mats
% Pls = cell(numViews, 1);
% for i=1:numViews
%     Pls{i} = PL_PM_to_PPM(Ps{i});
% end
if (shouldPlot)
    close all;
end

for j=1:numLines
    [el1, el2] = PL_endpoints(L(:,j),-1,1);
    if (shouldPlot)
        clf;hold off;
        line([el1(1) el2(1)], [el1(2) el2(2)], [el1(3) el2(3)]);
    end
    
    F = zeros(3, numViews);
    for i=1:numViews
        curPoints = endPoints2d{i};
        Ri = Rs{i};
        ti = ts{i};
        origin = ti;
        
        pts = curPoints(:,(j-1)*2+1:2*j);
        %E = [pts ; ones(1, size(pts,2))];
        direction = Ri'*(inv(K)*pts);
        direction(:,1) = direction(:,1)./norm(direction(:,1));
        direction(:,2) = direction(:,2)./norm(direction(:,2));
        
        ei1 = [origin origin];
        ei2 = ei1 + direction(1:3, :);
        
        [pL1, ~, s1, t1] = closest_points_on_lines(el1, el2, ei1(:,1), ei2(:,1));
        [pL2, ~, s2, t2] = closest_points_on_lines(el1, el2, ei1(:,2), ei2(:,2));
        
        % if (t1>0 && t2>0)
        if (shouldPlot)
            hold on, line([ei1(1) ei2(1)], [ei1(2) ei2(2)], [ei1(3) ei2(3)]);
            hold on, plot3(origin(1),origin(2),origin(3),'r+','MarkerSize',10);
            hold on, plot3(pL1(1),pL1(2),pL1(3),'ko','MarkerSize',10);
            hold on, plot3(pL2(1),pL2(2),pL2(3),'ko','MarkerSize',10);
        end
        %  end
        
        F(:,i*2-1) = pL1;
        F(:,i*2) = pL2;
    end
    
    %[diameter, maxI, minI] = max_distance_pairwise(F,2);
    [diameter, maxI, minI] = median_distance_pairwise(F);
    X1 = F(:,maxI);
    X2 = F(:,minI);
    if(shouldPlot)
        hold on, plot3(X1(1),X1(2),X1(3),'bo','MarkerSize',20);
        hold on, plot3(X2(1),X2(2),X2(3),'bo','MarkerSize',20);
        drawnow;
    end
    
    endPoints1(:, j) = X1;
    endPoints2(:, j) = X2;
end

end
