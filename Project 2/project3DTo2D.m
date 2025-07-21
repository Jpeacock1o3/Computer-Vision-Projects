function projected_points = project3DTo2D(mocapPoints3D, K, R, T)
    % Convert 3D points to homogeneous coordinates by appending 1 to each point
    homogenous_points = [mocapPoints3D, ones(size(mocapPoints3D, 1), 1)]';
    
    % Compute the extrinsic matrix [R | T]
    extrinsic_matrix = [R, T];
    
    % Apply the transformation: Project points into 2D
    projected_homogeneous = K * extrinsic_matrix * homogenous_points;
    
    % Normalize by the third (homogeneous) coordinate to get pixel coordinates
    projected_points = [projected_homogeneous(1, :) ./ projected_homogeneous(3, :); ...
                        projected_homogeneous(2, :) ./ projected_homogeneous(3, :)]';
end