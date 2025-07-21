function F = FundamentalMatrix(K1, K2, R1, R2, C1, C2)
    % Step 1: Calculate the relative rotation and translation
    R = R2 * R1';             % Relative rotation from camera 1 to camera 2
    T = R * (C2 - C1);        % Translation of camera 2 relative to camera 1 in camera 1's coordinate system

    % Step 2: Convert T to skew-symmetric matrix S
    S = [0, -T(3), T(2); 
         T(3), 0, -T(1); 
         -T(2), T(1), 0];

    % Compute the essential matrix E
    E = S * R;

    % Step 3: Convert E to F using the intrinsic matrices
    F = inv(K2)' * E * inv(K1);
end