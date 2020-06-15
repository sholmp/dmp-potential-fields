function plotQdots(q_dot_array, dt)
    t_end = (length(q_dot_array)-1) * dt;
    t = 0:dt:t_end;
    fontSize = 20;

    
    plot(t, q_dot_array(:,1:4))
    hold on
    plot(t, q_dot_array(:,5:7),'--')
    h = legend('$\dot{q1}$', '$\dot{q2}$', '$\dot{q3}$', ...
    '$\dot{q4}$', '$\dot{q5}$','$\dot{q6}$','$\dot{q7}$','FontSize', fontSize);
    set(h, 'Interpreter', 'latex');
    xlabel('t [seconds]');
    ylabel('\theta [radians]');
    h = title('$\dot{q(t)}$');
    set(h, 'Interpreter', 'latex');

    hold off
end

