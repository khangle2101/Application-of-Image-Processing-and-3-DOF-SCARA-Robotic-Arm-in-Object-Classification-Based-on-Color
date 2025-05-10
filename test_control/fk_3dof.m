function out = fk_3dof(the2, the3, D1)
%% Length
D2 = 146;
% D3 = 20;
D4 = 160;
% D5 = 20;
D6 = 173;
D7 = 0;

%% Forward Kinematic
P3_EE = [D6; 0 ; -D7];
% Input cua FKRobot la bang DH
T01 = TransMatrix(0,0,D1,0);
T12 = TransMatrix(D2,0,0,the2);
T23 = TransMatrix(D4,0,0,the3);

P = T01*T12*T23*[P3_EE;1];
Px = P(1,1);
Py = P(2,1);
Pz = P(3,1);
out = [Px Py Pz];
end
