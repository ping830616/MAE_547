clc
clear all
close all
hold on
p = [1.5 2.5 3.5]';
axis_start = p;
R = [-0.4330 -0.7500 0.5;
    0.2500 0.4330 0.8660;
    -0.8660 0.5000 0.0000];

figure(1)
for i=1:3
    axis_end(:,i) = axis_start + R(:,i);
end


plot3(p(1), p(2), p(3), 'o');
grid on
hold on
for i = 1:3
    h=plot3([axis_start(1) axis_end(1,i)],...
        [axis_start(2) axis_end(2,i)],...
        [axis_start(3) axis_end(3,i)]);
    if i==1
        h.Color='red';
    elseif i==2
        h.Color='green';
    else
        h.Color='blue';
    end
end


title('Part 1')

rotmZYZ=myrotmat(pi/3, 'z')*myrotmat(pi/2, 'y')*myrotmat(pi/6, 'z')
rotmZYZ = eul2r(pi/3, pi/2, pi/6)
p = [2.5 2.5 3.5]';
axis_start = p;

figure(2)
for i=1:3
    axis_end(:,i) = axis_start + rotmZYZ(:,i);
end


plot3(p(1), p(2), p(3), 'o');
grid on
hold on
for i = 1:3
    h=plot3([axis_start(1) axis_end(1,i)],...
        [axis_start(2) axis_end(2,i)],...
        [axis_start(3) axis_end(3,i)]);
    if i==1
        h.Color='red';
    elseif i==2
        h.Color='green';
    else
        h.Color='blue';
    end
end
title('Part 2')

R01=R; R02=rotmZYZ; 
R21=(R01'*R02)'