% Task 3.7: Symmetric Epipolar Distance (SED)


% Compute SED for the fundamental matrix from camera calibration (Task 3.5)
SED_F1 = SymmetricEpipolarDistance(F_5, points1, points2);
disp(['SED for F1 (from camera calibration): ', num2str(SED_F1)]);

% Compute SED for the fundamental matrix from eight-point algorithm without normalization (Task 3.6)
SED_F2 = SymmetricEpipolarDistance(F_non, points1, points2);
disp(['SED for F2 (eight-point algorithm without normalization): ', num2str(SED_F2)]);

% Compute SED for the fundamental matrix from eight-point algorithm with Hartley normalization (Task 3.6)
SED_F3 = SymmetricEpipolarDistance(F_norm, points1, points2);
disp(['SED for F3 (eight-point algorithm with Hartley normalization): ', num2str(SED_F3)]);

