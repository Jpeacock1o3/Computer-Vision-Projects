function SED = SymmetricEpipolarDistance(F, points1, points2)
    % Computes the Symmetric Epipolar Distance (SED) for a given fundamental matrix F.
    %
    % Inputs:
    % - F: Fundamental matrix (3x3)
    % - points1: Nx2 matrix of points in image 1
    % - points2: Nx2 matrix of points in image 2
    %
    % Output:
    % - SED: Symmetric Epipolar Distance error (scalar)

    num_points = size(points1, 1);
    total_distance = 0;

    for i = 1:num_points
        % Points in homogeneous coordinates
        p1 = [points1(i, :), 1]';
        p2 = [points2(i, :), 1]';

        % Epipolar line in image 2 for p1 in image 1
        l2 = F * p1;

        % Distance from p2 to its epipolar line l2 in image 2
        distance1 = (p2' * l2)^2 / (l2(1)^2 + l2(2)^2);

        % Epipolar line in image 1 for p2 in image 2
        l1 = F' * p2;

        % Distance from p1 to its epipolar line l1 in image 1
        distance2 = (p1' * l1)^2 / (l1(1)^2 + l1(2)^2);

        % Accumulate the symmetric distance
        total_distance = total_distance + distance1 + distance2;
    end

    % Compute the mean of the accumulated distances
    SED = total_distance / num_points;
end