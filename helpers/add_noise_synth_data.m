
function SynthData = add_noise_synth_data(SynthData, sigmaRot, sigmaTrans, sigma3DLines, sigma2DLines)

numCameras = length(SynthData.Rs);

Rs = SynthData.Rs;
ts = SynthData.ts;

qs = [];
qsNoisy = [];

tAvg = [0; 0; 0];
tAvgNoisy = [0; 0; 0];

% add noise on the camera poses - don't add to the first one
for i=1:numCameras
    Rs{i} = add_noise_rot_3d(SynthData.Rs{i}, sigmaRot);
    ts{i} = SynthData.ts{i} + randn(3,1)*sigmaTrans;
    qs = [qs; R2q(SynthData.Rs{i})];
    qsNoisy = [qsNoisy; R2q(Rs{i})];

    tAvg = tAvg + SynthData.ts{i};
    tAvgNoisy = tAvgNoisy + ts{i};
end
tAvg = tAvg./numCameras;
tAvgNoisy = tAvgNoisy./numCameras;

qAvg = avg_quaternion_markley(qs);
qAvgNoisy = avg_quaternion_markley(qsNoisy);

if (qAvg(1)<0)
    qAvg=-qAvg;
end
if (qAvgNoisy(1)<0)
    qAvgNoisy=-qAvgNoisy;
end

% get the relative transformations
tRel = zeros(3,1); % tAvg - tAvgNoisy;
RRel = eye(3); %q2R(rel_pose_q(qAvgNoisy,qAvg));

% register the first frame with the initials
for i=1:numCameras
    Rs{i} = RRel*Rs{i};
    ts{i} = tRel + ts{i};
    SynthData.Rs{i} = Rs{i};
    SynthData.ts{i} = ts{i};
    SynthData.Ps{i} = SynthData.K*[SynthData.Rs{i} -SynthData.Rs{i}*SynthData.ts{i}];
end

numViews = length(SynthData.endPoints2d);
for i=1:numViews
    epts = SynthData.endPoints2d{i}(1:2,:);
    epts = epts + randn(size(epts))*sigma2DLines;
    SynthData.endPoints2d{i}(1:2,:) = epts;
end


end

function [qp] = rel_pose_q(q1, q2)
qp = [q1(1)*q2(1) + q1(2) * q2(2) + q1(3) * q2(3) + q1(4) * q2(4), ...
   q1(1)*q2(2) - q1(2) * q2(1) + q1(3) * q2(4) - q1(4) * q2(3), ...
   q1(1)*q2(3) - q1(3) * q2(1) - q1(2) * q2(4) + q1(4) * q2(2), ...
   q1(1)*q2(4) + q1(2) * q2(3) - q1(3) * q2(2) - q1(4) * q2(1)];

end