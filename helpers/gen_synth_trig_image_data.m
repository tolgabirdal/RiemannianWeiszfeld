function [SynthData] = gen_synth_trig_image_data(points_3d, lineIndices)

points_3d = [points_3d ; ones(1,size(points_3d,2))];

numLines = size(lineIndices,1);

% line end-points in 3d:
endPoints3d = {};
for j=1:numLines
    endPoints3d = [endPoints3d [points_3d(1:3, lineIndices(j,1)) points_3d(1:3,lineIndices(j,2))]];
end

fx = 1000;
K = [fx 0 320; 0 fx 240; 0 0 1];
intrinsics = cameraIntrinsics(K(1,1),[K(1,3) K(2,3)],[1000 1000]);

objectCenter = mean(points_3d,2);
objectCenter = objectCenter(1:3);
scale = 3.0;
shouldPlot = 1;
[Rs, ts, Ps] = synthesize_cam_poses_on_sphere(K, 0, objectCenter, scale, shouldPlot);
plot_rect_prism(points_3d, lineIndices);

nViews = length(Ps);

T0 = Ps{1};
%T0 = K*[eye(3) [0 0 0]'];
%T0 = [T0; 0 0 0 1];

cubeImg = T0*points_3d;
cubeImg = cubeImg(1:3,:)./repmat(cubeImg(3,:),3,1);

endPoints2d = cell(nViews, 1);
% Ps = cell(nViews, 1);
% Rs = cell(nViews, 1);
% ts = cell(nViews, 1);
Pls = cell(nViews, 1);
for k=1:numLines
    endPoints2d{1} = [endPoints2d{1} [cubeImg(:,lineIndices(k,1))  cubeImg(:,lineIndices(k,2))]];
end

% Ps{1} = T0;
% Rs{1} = eye(3);
% ts{1} = [0,0,0]';
Pls{1} = PL_PM_to_PPM(T0);

i=2;
while (i<=nViews)
    % old way of getting a random cam pose
    % H2 = gen_rand_homography();
    % cubeImgH2 = H2*cubeImg;
    % [R1, t1] = estimateWorldCameraPose(cubeImgH2(1:2,:)', points_3d(1:3,:)', intrinsics, 'MaxReprojectionError', 30);
    % T1 = K*[R1 t1'];
    % R1 = Rs{i};
    % t1 = ts{i};
    % T1 = [T1; 0 0 0 1];
    
    % new way of doing it (see above)
    T1 = Ps{i};
    
    cubeImg2 = T1*points_3d;
    cubeImg2 = cubeImg2(1:3,:)./repmat(cubeImg2(3,:),3,1);
    
    % make sure they lie in the image. otherwise, regenarate
    if (all(all(cubeImg2(1:2,:)<=1500 & cubeImg2(1:2,:)>0)))
        for k=1:numLines
            endPoints2d{i} = [endPoints2d{i} [cubeImg2(1:3,lineIndices(k,1)) cubeImg2(1:3,lineIndices(k,2))]] ;
        end
        %Rs{i} = R1;
        %ts{i} = t1';
        %Ps{i} = T1;
        Pls{i} = PL_PM_to_PPM(T1);
        i = i + 1;
    end
end

SynthData.K = K;
SynthData.Rs = Rs;
SynthData.ts = ts;
SynthData.Ps = Ps;
SynthData.Pls = Pls;
SynthData.endPoints2d = endPoints2d;
SynthData.endPoints3d = endPoints3d;
SynthData.data3d = points_3d(:, 1:3);
SynthData.modelPoints = points_3d;
SynthData.modelLines = lineIndices;
% SynthData.cubeSize = dim;
SynthData.cubeOrigin = [0, 0, 1.5];

end