% Load 3D points and parameters
load('mocapPoints3D.mat', 'pts3D');
mocap = pts3D';
mocap = mocap/1000;




% Provided parameters
Kv1 = paramv1.Kmat;      % Intrinsic matrix
Rv1 = paramv1.Rmat;      % Rotation matrix (use this directly)
% `position` is in millimeters, convert it to meters
Cv1 = paramv1.position' / 1000; 

% Compute translation vector T
Tv1 = -paramv1.Rmat * Cv1;

Kv2 = paramv2.Kmat;      % Intrinsic matrix
Rv2 = paramv2.Rmat;      % Rotation matrix (use this directly)
% If `position` is in millimeters, convert it to meters
Cv2 = paramv2.position' / 1000; % Convert to meters (if necessary)

% Compute translation vector T
Tv2 = -paramv2.Rmat * Cv2;

projected_points_V1 = project3DTo2D(mocap, Kv1, Rv1, Tv1);

projected_points_V2 = project3DTo2D(mocap, Kv2, Rv2, Tv2);

% Plot the projected points on the images for verification
figure;
imshow('im1corrected.jpg'); hold on;
plot(projected_points_V1(:, 1), projected_points_V1(:, 2), 'ro', 'MarkerSize', 5);
title('Projected 2D Points on View 1');

figure;
imshow('im2corrected.jpg'); hold on;
plot(projected_points_V2(:, 1), projected_points_V2(:, 2), 'bo', 'MarkerSize', 5);
title('Projected 2D Points on View 2');
