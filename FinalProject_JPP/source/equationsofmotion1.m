clear all
clc
% In the GUI, inputs should have DH parameters(alpha theta a d), 
% kr, Im, IL, ml, mm. Degree can input number directly, it is not necessary
% changing it into pi format. In addition, input should mention whether
% prismatic or revolute. The maximum input is 5 links
%%%%%%%%%%%%%%%%%%
%%% GUI Input %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All the numbers are assumptions
%syms kr1 kr2 kr3 kr4 kr5
% kr
kr1 = 1;
kr2 = 2; 
kr3 = 3; 
kr4 = 4; 
kr5 = 5;

%syms ml1 ml2 ml3 ml4 ml5
ml1 = 1;
ml2 = 2; 
ml3 = 3; 
ml4 = 4; 
ml5 = 5;

%syms mm1 mm2 mm3 mm4 mm5
mm1 = 1;
mm2 = 2;
mm3 = 3;
mm4 = 4;
mm5 = 5;

%syms IL1 IL2 IL3 IL4 IL5
IL1 = 1;
IL2 = 2;
IL3 = 3; 
IL4 = 4; 
IL5 = 5;

%syms Im1 Im2 Im3 Im4 Im5
Im1 = 1;
Im2 = 2; 
Im3 = 3; 
Im4 = 4; 
Im5 = 5;

%syms tau1 tau2 tau3 tau4 tau5
tau1 = 1;
tau2 = 2; 
tau3 = 3; 
tau4 = 4; 
tau5 = 5;

% input prismatic or revolute
types = ["revolute" "prismatic" "prismatic"];

% DHparameters
theta = [90;0;0];
alpha = [0;-90;0];
a = [0;0;0];
d = [1;1;1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% q qd qdd don't need to input from gui 
syms q1 q2 q3 q4 q5
syms qd1 qd2 qd3 qd4 qd5
syms qdd1 qdd2 qdd3 qdd4 qdd5

% gravity
g0 = [0 0 9.81];
% How many links
n = length(d); 

% determine q

switch n
    case 1
        ml = ml1;
        mm = mm1;
        kr = kr1;
        IL = IL1;
        Im = Im1;
        q = q1;
        qd = qd1;
        qdd = qdd1;
    case 2
        ml = [ml1 ml2];
        mm = [mm1 mm2];
        kr = [kr1 kr2];
        IL = [IL1 IL2];
        Im = [Im1 Im2];
        q = [q1; q2];
        qd = [qd1; qd2];
        qdd = [qdd1; qdd2];
    case 3
        ml = [ml1 ml2 ml3];
        mm = [mm1 mm2 mm3];
        kr = [kr1 kr2 kr3];
        IL = [IL1 IL2 IL3];
        Im = [Im1 Im2 Im3];
        q = [q1; q2; q3];
        qd = [qd1; qd2; qd3];
        qdd = [qdd1; qdd2; qdd3];
    case 4
        ml = [ml1 ml2 ml3 ml4];
        mm = [mm1 mm2 mm3 mm4];
        kr = [kr1 kr2 kr3 kr4];
        IL = [IL1 IL2 IL3 IL4];
        Im = [Im1 Im2 Im3 Im4];
        q = [q1; q2; q3; q4];
        qd = [qd1; qd2; qd3; qd4];
        qdd = [qdd1; qdd2; qdd3; qdd4];
    otherwise
        ml = [ml1 ml2 ml3 ml4 ml5];
        mm = [mm1 mm2 mm3 mm4 mm5];
        kr = [kr1 kr2 kr3 kr4 kr5];
        IL = [IL1 IL2 IL3 IL4 IL5];
        Im = [Im1 Im2 Im3 Im4 Im5];
        q = [q1; q2; q3; q4; q5];
        qd = [qd1; qd2; qd3; qd4; qd5];
        qdd = [qdd1; qdd2; qdd3; qdd4; qdd5];
end


% I use cosd and sind, instead of cos and sin, because cosd and sind can
% input degree directly, for example, cosd(90) = 0;
A1 = eye(4);
for i = 1:n
A = [cosd(theta(i)) -sind(theta(i))*cosd(alpha(i))  sind(theta(i))*sind(alpha(i)) a(i)*cosd(theta(i));
     sind(theta(i))  cosd(theta(i))*cosd(alpha(i)) -cosd(theta(i))*sind(alpha(i)) a(i)*sind(theta(i));
     0               sind(alpha(i))                 cosd(alpha(i))                d(i);
     0               0                              0                             1];
 T{i} = A1*A;
 A1 = T{i};
 R{i} = A(1:3,1:3);
 if i == 1
     Rm{i} = eye(3);
 else
     Rm{i} = R{i-1};
 end
end

% Calculate P0 P1 P2...
for i = 1:n+1
    if i == 1
        P(:,1) = [0;0;0];
    else
        psave = T{i-1}(1:3,4);
        P = [P psave];
    end
end

% Calculate PL1 PL2 PL3...
for i = 1:n
    PL{i} = 0.5*(P(:,i) + P(:,i+1));
end

% Calculate z0 z1 z2...
for i = 1:n
    if i == 1
        z(:,1) = [0;0;1];
    else
        zsave = T{i-1}(1:3,3);
        z = [z zsave];
    end
end

%Calculate JpL
%for prismatic joint, JpL is z0, z1 or z2. 
%for revolute joint, JpL is cross product of z0 and (PL{i}-P0)
for i = 1:n
    for j = 1:i
        switch types(j)
            case {"revolute"}
                JpL{i}(:,j) = cross(z(:,j),(PL{i}-P(:,j)));
            otherwise
                JpL{i}(:,j) = z(:,j);
        end
    end
    for k = 1:(n-i)
        JpL{i}(:,i+k) = zeros(3,1);
    end
end



%Calculate JoL
%for prismatic joint, JoL is 0. 
%for revolute joint, JoL is z0
for i = 1:n
    for j = 1:i
        switch types(j)
            case {"revolute"}
                JoL{i}(:,j) = z(:,j);
            otherwise
                JoL{i}(:,j) = zeros(3,1);
        end
    end
    for k = 1:(n-i)
        JoL{i}(:,i+k) = zeros(3,1);
    end
end

%Calculate Jpm
for i = 1:n
    if i == 1
        Jpm{i} = zeros(3,n);
    else
        for j = 1:i-1
            switch types(j)
                case {"revolute"}
                    Jpm{i}(:,j) = cross(z(:,j),(PL{i-1}-P(:,j)));
                otherwise
                    Jpm{i}(:,j) = z(:,j);
            end
        end
        for k = 0:(n-i)
            Jpm{i}(:,i+k) = zeros(3,1);
        end
    end
end

%Calculate Jom
for i = 1:n
    for j = 1:i
        if j < i
            Jom{i}(:,j) = JoL{i}(:,j);
        else
            Jom{i}(:,i) = kr(i)*z(:,i);
        end
    end
    for k = 1:(n-i)
        Jom{i}(:,i+k) = zeros(3,1);
    end
end

BB = zeros(n);
for i = 1:n
    B{i} =  ml(i)*JpL{i}'*JpL{i} + JoL{i}'*R{i}*IL(i)*R{i}'*JoL{i}... 
            + mm(i)*Jpm{i}'*Jpm{i} + Jom{i}'*Rm{i}*Im(i)*Rm{i}'*Jom{i};
    BB = BB + B{i};
end

C = sym(zeros(n,n));
for i = 1:n
    for j = 1:n
        s = 0;
        for k = 1:n
            c{k}(i,j) = 1/2*(diff(BB(i,j),q(k))+diff(BB(i,k),q(j))-diff(BB(j,k),q(i)))*qd(k);
            s = s + c{k}(i,j);
        end
        C(i,j) = s;
    end
end
for i = 1:n
    gg{i} = 0;
    for j = 1:n
        gg{i} = gg{i} + ml(j)*g0*JpL{j}(:,i) + mm(j)*g0*Jpm{j}(:,i);
    end
    if i == 1
        g1 = [gg{i}];
    else
        g1 = [g1; gg{i}];
    end
    
end
tau = BB*qdd + C*qd + g1;

switch n
    case 1
        tau1 = tau(1,1)
    case 2
        tau1 = tau(1,1)
        tau2 = tau(2,1)
    case 3
        tau1 = tau(1,1)
        tau2 = tau(2,1)
        tau3 = tau(3,1)
    case 4
        tau1 = tau(1,1)
        tau2 = tau(2,1)
        tau3 = tau(3,1)
        tau4 = tau(4,1)
    otherwise
        tau1 = tau(1,1)
        tau2 = tau(2,1)
        tau3 = tau(3,1)
        tau4 = tau(4,1)
        tau5 = tau(5,1)
end
