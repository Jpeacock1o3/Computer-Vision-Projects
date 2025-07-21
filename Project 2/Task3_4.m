% Display the first image and select points on the floor, wall, etc.
disp('choose three points on the floor for both images');
figure;
imshow('im1corrected.jpg');
title('Select points in Image 1');
[x1, y1] = ginput(3); % Select 3 points on the floor
points1_floor = [x1, y1];

figure;
imshow('im2corrected.jpg');
title('Select corresponding points in Image 2');
[x2, y2] = ginput(3);
points2_floor = [x2, y2];

% Triangulate to find the 3D coordinates of these floor points
floor_points_3D = triangulatePoints(P1, P2, points1_floor, points2_floor);

function plane = Plane(points)
    % Fit a plane ax + by + cz + d = 0 to a set of 3D points
    A = [points, ones(size(points, 1), 1)]; % Append a column of 1s for d
    [~, ~, V] = svd(A);
    plane = V(:, end)'; % The last column of V gives [a, b, c, d]
end

% Fit a plane to the floor points
floor_plane = Plane(floor_points_3D);
disp('Equation of the floor plane (aX + bY + cZ + d = 0):');
disp(floor_plane);


disp('Choose three points on the wall for both images');
figure;
imshow('im1corrected.jpg');
title('Select points in Image 1');
[x1, y1] = ginput(3); % Select 3 points on the wall 
points1_wall = [x1, y1];

figure;
imshow('im2corrected.jpg');
title('Select corresponding points in Image 2');
[x2, y2] = ginput(3);
points2_wall = [x2, y2];

% Fit a plane to the wall points
wall_points_3D = triangulatePoints(P1, P2, points1_wall, points2_wall); % Replace with selected wall points
wall_plane = Plane(wall_points_3D);
disp('Equation of the wall plane (aX + bY + cZ + d = 0):');
disp(wall_plane);

% Select top and bottom points of the doorway
disp("Select top and bottom of the doorway");
figure;
imshow('im1corrected.jpg');
title('Select points in Image 1');
[x1, y1] = ginput(2); % Select points at the top and bottom of the doorway in each image
points1_door = [x1, y1];
figure;
imshow('im2corrected.jpg');
title('Select corresponding points in Image 2');
[x2, y2] = ginput(2);
points2_door = [x2, y2];

% Triangulate to get 3D points for the top and bottom of the doorway
doorway_points_3D = triangulatePoints(P1, P2, points1_door, points2_door);
doorway_height = abs(doorway_points_3D(1, 3) - doorway_points_3D(2, 3));
disp(['Height of the doorway: ', num2str(doorway_height), ' units']);

% Select top and bottom points of the person
disp("Select top and bottom of person");
figure;
imshow('im1corrected.jpg');
title('Select points in Image 1');
[x1, y1] = ginput(2); % Select points at the top of the head and at the feet
points1_person = [x1, y1];
figure;
imshow('im2corrected.jpg');
title('Select corresponding points in Image 2');
[x2, y2] = ginput(2);
points2_person = [x2, y2];

% Triangulate to get 3D points for the top and bottom of the person
person_points_3D = triangulatePoints(P1, P2, points1_person, points2_person);
person_height = abs(person_points_3D(1, 3) - person_points_3D(2, 3));
disp(['Height of the person: ', num2str(person_height), ' units']);

% Select points on the camera on the tripod
disp("Select the camera on the tripod");
figure;
imshow('im1corrected.jpg');
title('Select points in Image 1');
[x1, y1] = ginput(1); % Select a point on the camera in each image
points1_camera = [x1, y1];
imshow('im2corrected.jpg');
title('Select corresponding points in Image 2');
[x2, y2] = ginput(1);
points2_camera = [x2, y2];

% Triangulate to get the 3D point for the camera
camera_tripod_position = triangulatePoints(P1, P2, points1_camera, points2_camera);
disp('3D location of the camera on the tripod:');
disp(camera_tripod_position);
