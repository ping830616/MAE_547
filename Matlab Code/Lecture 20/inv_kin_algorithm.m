clear all
clc

a1 = 0.5;
a2 = 0.3;
a3 = 0.3;
t=0:0.001:2;

pd = [0.25*(1-cos(pi*t)); 0.25*(2+sin(pi*t))];
phid = sin(pi*t/24);
pd_dot = [0.25*(pi*sin(pi*t)); 0.25*(pi*cos(pi*t))];
phid_dot = pi/24*cos(pi*t/24);
q= zeros(3,length(t));
q(:,1) = [pi -pi/2 -pi/2];
K=1*eye(3,3);

for i = 1:length(t)
    xe(:,i)= fwd_kin_pl(a1, a2, a3, q(:,i));
    Ja = an_Jac_pl(a1, a2, a3, q(:,i));
    e(:,i)=[pd(:,i); phid(i)] - xe(:,i);
    xd_dot=[pd_dot(:,i); phid_dot(i)];
    qdot = inv(Ja)*(xd_dot+K*e(:,i));
    q(:,i+1)=q(:,i)+qdot*0.001;
end

q(:,end)
qdot(:,end)
max(e(:))

