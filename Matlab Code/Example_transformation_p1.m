clear all
close all

w1 = 0.1;
w2 = 0.2;
L1 = 0.5;
L2 = 0.5;
t = 0:0.1:1000;
pA = [0.4, 0.5 0];
T0A = [1 0 0 0.4; 0 1 0 0.5; 0 0 1 0; 0 0 0 1];  q1 = (pi/3)*sin(w1*t);
q2 = (pi/6)*sin(w2*t);
figure
for i = 1:length(t)
    
    axis([0 3 -1.5 1.5]);
    R1 = myrotmat(q1(i), 'z');  TAB = [R1; 0 0 0];
    TAB = [TAB, [0; 0; 0; 1]];  pB = T0A*TAB*[L1;0;0;1];
    
    
    R2 = myrotmat(q2(i), 'z');
    TBC = [R2; 0 0 0];
    TBC = [TBC, [L1; 0; 0; 1]];
    
    TCe = [eye(3,3); 0 0 0 ];
    TCe = [TCe, [L2, 0 , 0, 1]'];
    pC = T0A*TAB*TBC*TCe*[0;0;0;1];
    pC = T0A*TAB*TBC*[L2;0;0;1];
    
    plot([pA(1) pB(1) pC(1)], [pA(2) pB(2) pC(2)], 'b', 'LineWidth', 4);  hold on
    plot([pA(1)], [pA(2)],'ks');
    
    pause(0.01);
    cla
    
end