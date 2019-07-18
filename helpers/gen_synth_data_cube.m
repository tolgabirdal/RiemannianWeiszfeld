function [SynthData] = gen_synth_data_cube(nViews)

dim = 0.25;
cube_points = [ -dim -dim 1
    dim -dim 1
    dim dim 1
    -dim dim 1
    -dim -dim 2
    dim -dim 2
    dim dim 2
    -dim dim 2
    ]';

lineIndices = [
    1 2
    2 3
    3 4
    4 1
    5 6
    6 7
    7 8
    8 5
    1 5
    6 2
    7 3
    4 8
    1 3
    5 7
    3 6
    2 5
    1 8
    4 7
];

SynthData = gen_synth_trig_image_data(cube_points, lineIndices);

end