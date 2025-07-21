% Load camera parameters
load('Parameters_V1_1.mat', 'Parameters');
paramv1 = Parameters;
load('Parameters_V2_1.mat', 'Parameters');
paramv2 = Parameters;

% Intrinsic parameters (Matrix K)
K_V1 = paramv1.Kmat;
K_V2 = paramv2.Kmat;

% Extrinsic parameters (Matrix P)
P_V1 = paramv1.Pmat;
P_V2 = paramv2.Pmat;

% Display
disp('Intrinsic Matrix K (View 1):');
disp(K_V1);
disp('Intrinsic Matrix K (View 2):');
disp(K_V2);

disp('Projection Matrix P (View 1):');
disp(P_V1);
disp('Projection Matrix P (View 2):');
disp(P_V2);

disp('The camera position for img 1 is:');
C1 = paramv1.position; % For Camera 1
disp(C1);

disp('The camera postiton for img 2 is: ');
C2 = paramv2.position;
disp(C2);

disp('Rotation Matrix R:');
disp(paramv1.Rmat);

disp ('Rotation Matrix R:');
disp(paramv2.Rmat);
