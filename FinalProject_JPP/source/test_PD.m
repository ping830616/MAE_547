clear all;
clc;
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
sim('PD_control_test2',10)

% plot desired vs actual end-effector position and contact force
figure('Name','Indirect force control through PD control');

% plot xe xd at x axis
subplot(4,1,1);
plot(ans.tout,ans.xe(:,1))
hold on;
plot(ans.tout,xd(1)*ones(length(ans.tout)))
xlabel('s')
ylabel('mm')
title('desired vs actual end-effector at x direction');

% plot ye yd at y axis
subplot(4,1,2);
plot(ans.tout,ans.xe(:,2))
hold on;
plot(ans.tout,xd(2)*ones(length(ans.tout)))
xlabel('s')
ylabel('mm')
title('desired vs actual end-effector at y direction');

% end effector contact force
subplot(4,1,3); 
plot(ans.tout,ans.f(:,1))
xlabel('s')
ylabel('N')
title('contact force at x direction');

subplot(4,1,4); 
plot(ans.tout,ans.f(:,2))
xlabel('s')
ylabel('N')
title('contact force at y direction');