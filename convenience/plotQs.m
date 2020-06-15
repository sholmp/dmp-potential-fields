function plotQs(qs, dt)
    t_end = (length(qs)-1) * dt;
    t = 0:dt:t_end;
    fontSize = 15;
    lineWidth = 2.5;
    plot(t, qs(:,1:4), 'LineWidth', lineWidth)
    hold on
    plot(t, qs(:,5:7),'--', 'LineWidth', lineWidth)
    legend('q_1','q_2', 'q_3','q_4', 'q_5','q_6', 'q_7', 'FontSize', fontSize)
    xlabel('t [seconds]')
    ylabel('\theta [radians]')
    hold off
end

