% Only for two-link planar arm
% User can input following information
xd = [1;0];
K_D = 10;
K_P = 10;
friction = 1;
a1 = 1; %dh parameter
a2 = 1; %dh parameter
IL1 = 1; %Inertia of links
IL2 = 1; %Inertia of links
mL1 = 1; % mass of links
mL2 = 1; % mass of links
mm2 = 1;
L1 = 1; % length of links
L2 = 1; % length of links
kr1 = 1; %ratios
kr2 = 1; %ratios
Im1 = 1; %inertia of motor
Im2 = 1; %inertia of motor
qi = [0.5;0.5];

PD_entrance(1, 0, K_D, K_P, a1, a2, friction, IL1, IL2, mL1, mL2, mm2, L1, L2, kr1, kr2, Im1, Im2, 0.5, 0.5)