dhs = [0 1 0 0;
       0 1 0 0;
       0 1 0 0];
ls = [0.5 0.5 0.5];
masses = [50 50 50];
ratios = [110 110 110];
inertia_link = [10 10 10];
inertia_motor = [0.02 0.02 0.02];
q0 = [-50 90 30];
qd0 = [0 0 0];

dynamic_of_system(dhs, ls, masses, ratios, inertia_link, inertia_motor, q0, qd0);