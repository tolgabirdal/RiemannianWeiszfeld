function [] = plot_triangle(p1, p2, p3, clr)

hold on, line([p1(1), p2(1), p3(1), p1(1)]', [p1(2), p2(2), p3(2), p1(2)]', [p1(3), p2(3), p3(3), p1(3)]', 'Color', clr);

end