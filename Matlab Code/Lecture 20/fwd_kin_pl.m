function x = fwd_kin_pl(a1, a2, a3, q);
x = [a1*cos(q(1))+a2*cos(q(1)+q(2))+a3*cos(q(1)+q(2)+q(3));
    a1*sin(q(1))+a2*sin(q(1)+q(2))+a3*sin(q(1)+q(2)+q(3));
    q(1)+q(2)+q(3)];