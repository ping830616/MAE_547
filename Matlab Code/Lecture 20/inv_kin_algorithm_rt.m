clc
clear all 
close all 
warning off
 
addpath(genpath('rvctools')); 
alpha = [0, (pi/2), -(pi/2), -(pi/2), (pi/2), (pi/2), -(pi/2)];  a = zeros(1,7); 
d = [0.3105, 0, 0.4 , 0, 0.39, 0, 0.083];  theta = zeros(1,7); 
dh = [theta' d' a' alpha']; 
for i = 1:7 
L{i} = Link('d', dh(i,2), 'a', dh(i,3), 'alpha', dh(i,4), 'modified'); 
L{i}.qlim = [-pi, pi];  
end

R = SerialLink([L{1} L{2} L{3} L{4} L{5} L{6} L{7}]);
 
qd = [ 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]  

Td = R.fkine([qd]) 
 
qcomp = R.ikine(Td, 'pinv') 
 
Tcomp = R.fkine(qcomp)