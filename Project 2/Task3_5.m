% Compute F
F_5 = FundamentalMatrix(Kv1,Kv2,Rv1,Rv2,Cv1,Cv2);
disp(F_5);

% Plot the epipolar lines
% Load images
im1 = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');

disp('choose eight points');
figure;
imshow('im1corrected.jpg');
title('Select points in Image 1');
[x1, y1] = ginput(8); 
points1_3_5 = [x1, y1];

figure;
imshow('im2corrected.jpg');
title('Select corresponding points in Image 2');
[x2, y2] = ginput(8);
points2_3_5 = [x2, y2];


% Call the plotEpipolarLines function with the loaded images
plotEpipolarLines(F_5, im1, im2, points1_3_5, points2_3_5);
