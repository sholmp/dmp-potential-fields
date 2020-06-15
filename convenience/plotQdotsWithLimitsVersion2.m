function plotQdotsWithLimitsVersion2(qs, dt)

%     qdot_array(end,:) = [];
    
    figure

    q_dot_array = diff(qs) / dt;
    t_end = (length(q_dot_array)-1) * dt;
    t = 0:dt:t_end;
    vel_max = [(5/6)*pi, (5/6)*pi, (5/6)*pi, (5/6)*pi, pi, pi, pi]'; %For panda
    vel_min = -[(5/6)*pi, (5/6)*pi, (5/6)*pi, (5/6)*pi, pi, pi, pi]'; %For panda

    lineWidth = 1.5;
    fontSize = 25;
    n = length(t);
    for i = 1:7
        h = subplot(4,2,i)
        xlabel('t [seconds]')

        hold on
        plot(t, q_dot_array(:,i), 'LineWidth', lineWidth)
        plot(t, ones(n,1) * vel_min(i), 'r--', 'LineWidth', lineWidth);
        plot(t, ones(n,1) * vel_max(i), 'r--', 'LineWidth', lineWidth);
        h = ylabel("$\dot{q_"+string(i)+"}$", 'FontSize', fontSize);
        set(h, 'Interpreter', 'latex');
        hold off;
    end
    h = sgtitle('$\dot{q}$ and limits');
    set(h, 'Interpreter', 'latex');
   
end