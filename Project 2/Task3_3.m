% Compute the projection matrices for each view using the known parameters
P1 = Kv1 * [Rv1, Tv1];
P2 = Kv2 * [Rv2, Tv2];

% Use the triangulation function to estimate the original 3D points
recovered_points = triangulatePoints(P1, P2, projected_points_V1, projected_points_V2);

% Calculate the mean squared error between the original and recovered 3D points
original_points = mocap; % Original 3D points from the mocap data
error = mean(vecnorm(recovered_points - original_points, 2, 2).^2);

disp(['Mean squared error between original and recovered 3D points: ', num2str(error)]);