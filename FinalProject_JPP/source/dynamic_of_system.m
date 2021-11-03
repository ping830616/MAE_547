
function re = dynamic_of_system(dhs, ls, masses, ratios, inertia_link, inertia_motor, q0, qd0)
    startup_rvc;
    SIM_TIME = 3;   % seconds
    Q0 = q0
    QD = qd0
    [rows, columns] = size(dhs);
    ROWS = rows
    for i=1:rows
       L(i) = Link('alpha', dhs(i,1), 'a', dhs(i,2), 'd', dhs(i,4), 'm', masses(i), 'r', [dhs(i,2)/2 0 0]', 'I', [0 0 ls(i)]', 'G', ratios(i), 'Jm', inertia_motor(i));
    end
    R = SerialLink(L);
    R.nofriction();
    
    
    % SerialLink.dyn Display inertial properties
    R.dyn();

    % Perform this simulation
    q0 = q0*(pi/180);

    % Plot
    plot(R, q0)
    hold on
    R.gravity = [0;0;0];

    % Run the simulation
    if rows==1
        torfun = @torfun1
    elseif rows==2
        torfun = @torfun2
    elseif rows==3
        torfun = @torfun3
    elseif rows==4
        torfun = @torfun4
    else
        torfun = @torfun5
    end
    [t, q, qd] = R.fdyn(SIM_TIME, torfun, q0', qd0');

    % Two plots for the resulting robot motion
    % 1. The three joint angles (degrees) £K={£c1 £c2 £c3}T vs. time
    figure
    plot(t, q*(180/pi), 'LineWidth', 2)
    title('Joint Position vs. Time')
    xlabel('Time(s)')
    ylabel('Position (degrees)')
    if rows==1
        legend('q1')
    elseif rows==2
        legend('q1', 'q2')
    elseif rows==3
         legend('q1', 'q2', 'q3')
    elseif rows==4
         legend('q1', 'q2', 'q3', 'q4')
    else
         legend('q1', 'q2', 'q3', 'q4', 'q5')
    end
    hold on

    % 2. The three joint rates (rad/s) ??={??1 ??2 ??3}T vs. time
    figure
    plot(t, qd, 'LineWidth', 2)
    title('Joint Velocity vs. Time')
    xlabel('Time(s)')
    ylabel('Velocity (rad/s)')
    if rows==1
        legend('qd1')
    elseif rows==2
        legend('qd1', 'qd2')
    elseif rows==3
         legend('qd1', 'qd2', 'qd3')
    elseif rows==4
         legend('qd1', 'qd2', 'qd3', 'qd4')
    else
         legend('qd1', 'qd2', 'qd3', 'qd4', 'qd5')
    end

end



function tau = torfun1(ti,q,qd,a)

tau=[50,40,10,5,1];
    
end

function tau = torfun2(ti,q,qd,a)

tau=[50,40];
    
end

function tau = torfun3(ti,q,qd,a)

tau=[50,40,10];
    
end

function tau = torfun4(ti,q,qd,a)

tau=[50,40,10,5];
    
end

function tau = torfun5(ti,q,qd,a)

tau=[50,40,10,5,1];
    
end