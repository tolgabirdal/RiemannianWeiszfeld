function [Rs, ts, Ps] = synthesize_cam_poses_on_sphere(K, level, objectCenter, scale, shouldPlot)

if (~exist('shouldPlot', 'var'))
    shouldPlot = 0;
end
    
[coor,tri] = icosahedron2sphere(level);

numCameras = size(coor,1);

normCoor = dot(coor, coor, 2);
directions = -coor./repmat(normCoor, 1, 3);

ts = scale.*coor + repmat(objectCenter', numCameras, 1);

z = [0,0,1]';
Rs = cell(numCameras, 1);
Ps = cell(numCameras, 1);
for i=1:numCameras
    direction = directions(i,:)';
    [R, bad] = rotationFromTwoVectors(direction, z); % the camera pose
    if (bad)
        [R, bad] = rotationFromTwoVectors(direction, z); % the camera pose
    end
    Rs{i} = R;
    Ps{i} = K*[R -R*ts(i,:)'];
    Ps{i} = [Ps{i}; 0 0 0 1];
end

ts = ts';

if (shouldPlot)
    close all;
    figure,
    for i=1:numCameras
        cam.Orientation = Rs{i};
        cam.Location = (ts(:,i));
        hold on, plotCamera(cam,'Size',0.1);
    end
    hold on, plot3(objectCenter(1), objectCenter(2), objectCenter(3), 'b+');
    axis equal;
    drawnow();
end

ts = cellfun(@transpose,mat2cell(ts', ones(length(ts),1)),'UniformOutput',false);

end