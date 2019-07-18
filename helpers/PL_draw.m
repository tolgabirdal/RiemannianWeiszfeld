function [] = PL_draw(Ls, lambda, clip, clr, endPoints2d, K, Rs, ts)

if (~clip)
    for i =1:size(Ls,2)
        L0 = Ls(:,i);
        [e1,e2] = PL_endpoints(L0,-lambda, lambda);
        hold on, line([e1(1) e2(1)], [e1(2) e2(2)], [e1(3) e2(3)], 'LineWidth', 0.1, 'Color', clr);
    end
else
    [e1Clip, e2Clip] = PL_clip(Ls, endPoints2d, K, Rs, ts, 0);
    for i =1:size(Ls,2)
        L0 = Ls(:,i);
        e1 = e1Clip(:, i);
        e2 = e2Clip(:, i);
        hold on, line([e1(1) e2(1)], [e1(2) e2(2)], [e1(3) e2(3)], 'LineWidth', 0.1, 'Color', clr);
    end
end

end