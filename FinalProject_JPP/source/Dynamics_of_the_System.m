clc
clear
close all

% given information about the robot
a1 = 1; a2 = 1; a3 = 1; a4 = 1; a5 = 1; % m
l1 = 0.5; l2 = 0.5; l3 = 0.5; l4 = 0.5; l5 = 0.5;  % m
ml1 = 50; ml2 = 50; ml3 = 50; ml4 = 50; ml5 = 50;  % kg
Il1 = 10; Il2 = 10; Il3 = 10; Il4 = 10; Il5 = 10; % kg.m^2
kr1 = 110; kr2 = 110; kr3 = 110; kr4 = 110; kr5 = 110;  
Im1 = 0.02; Im2 = 0.02; Im3 = 0.02; Im4 = 0.02; Im5 = 0.02; % kg.m^2

% DH parameters
alpha = zeros(1,5);
a = [a1, a2, a3, a4, a5];
d = zeros(1,5);
theta = zeros(1,5);
dh = [theta' d' a' alpha'];


% 3 links with DH parameters and dynamics information
L{1} = Link('d', dh(1,2), 'a', dh(1,3), 'alpha', dh(1,4), 'm', ml1, 'r', [l1 0 0]', 'I', [0 0 Il1]', 'G', kr1, 'Jm', Im1);
L{2} = Link('d', dh(2,2), 'a', dh(2,3), 'alpha', dh(2,4), 'm', ml2, 'r', [l2 0 0]', 'I', [0 0 Il2]', 'G', kr2, 'Jm', Im2);
L{3} = Link('d', dh(3,2), 'a', dh(3,3), 'alpha', dh(3,4), 'm', ml3, 'r', [l3 0 0]', 'I', [0 0 Il3]', 'G', kr3, 'Jm', Im3);
L{4} = Link('d', dh(4,2), 'a', dh(4,3), 'alpha', dh(4,4), 'm', ml4, 'r', [l4 0 0]', 'I', [0 0 Il4]', 'G', kr4, 'Jm', Im4);
L{5} = Link('d', dh(5,2), 'a', dh(5,3), 'alpha', dh(5,4), 'm', ml5, 'r', [l5 0 0]', 'I', [0 0 Il5]', 'G', kr5, 'Jm', Im5);

R = SerialLink([L{1} L{2} L{3} L{4} L{5}]);
R.nofriction();

% SerialLink.dyn Display inertial properties
R.dyn();

% Plot
plot(R, [-50*pi/180 pi/2 pi/6 pi/6 pi/6])
hold on
R.gravity = [0;0;0];

% Run the simulation
[ti, q, qd] = R.fdyn(3, @torqfun, [-50*pi/180 pi/2 pi/6 pi/6 pi/6]', [0 0 0 0 0]');


% Two plots for the resulting robot motion
% 1. The three joint angles (degrees) £K={£c1 £c2 £c3}T vs. time
figure
plot(ti, q*(180/pi), 'LineWidth', 2)
title('Joint Position vs. Time')
xlabel('Time(s)')
ylabel('Position (degrees)')
legend('q1', 'q2', 'q3', 'q4', 'q5')
hold on

% 2. The three joint rates (rad/s) ??={??1 ??2 ??3}T vs. time
figure
plot(ti, qd, 'LineWidth', 2)
title('Joint Velocity vs. Time')
xlabel('Time(s)')
ylabel('Velocity (rad/s)')
legend('qd1', 'qd2', 'qd3', 'qd4', 'qd5')

function tau = torqfun(ti,q,qd,a)

tau=[50,40,10,5,1];
    
end

