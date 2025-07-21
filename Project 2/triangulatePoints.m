function recovered_points = triangulatePoints(P1, P2, points1, points2)
    % Inputs:
    % P1, P2: Projection matrices for camera views 1 and 2
    % points1, points2: Nx2 matrices of corresponding 2D points in each view
    % Output:
    % recovered_points: Nx3 matrix of recovered 3D points

    num_points = size(points1, 1);
    recovered_points = zeros(num_points, 3);
    
    for i = 1:num_points
        % Set up matrix A for each pair of 2D points
        A = [
            (points1(i, 1) * P1(3, :) - P1(1, :));
            (points1(i, 2) * P1(3, :) - P1(2, :));
            (points2(i, 1) * P2(3, :) - P2(1, :));
            (points2(i, 2) * P2(3, :) - P2(2, :))
        ];
        
        % Solve A * X = 0 using SVD
        [~, ~, V] = svd(A);
        homogeneous_point = V(:, end);
        
        % Convert from homogeneous coordinates to 3D
        recovered_points(i, :) = homogeneous_point(1:3) / homogeneous_point(4);
    end
end