% Load and display images
figure;
imshow('im1corrected.jpg');
title('Select at least 8 points in Image 1');
[x1, y1] = ginput(8);
figure;
imshow('im2corrected.jpg');
title('Select corresponding points in Image 2');
[x2, y2] = ginput(8);

% Combine points into Nx2 matrices
points1 = [x1, y1];
points2 = [x2, y2];

%If you want the epipolar image for normalized points you need to comment
%out the non normalized data
F_norm = eightpoint(im1, im2, points1, points2);
disp("normalized matrix");
disp(F_norm);

%uncomment to update non normalized data, and see epipolar lines
F_non = eightpointnohartley(im1, im2, points1, points2);
disp("Non normalized F matrix");
disp(F_non);



