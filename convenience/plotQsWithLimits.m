function plotQsWithLimits(qs, dt, doublePlot)
    figure

    t_end = (length(qs)-1) * dt;
    t = 0:dt:t_end;
    q_min = [-2.8973, -1.7628, -2.8973, -3.0718, -2.8973, -0.0175, -2.8973]';
    q_max = [2.8973, 1.7628, 2.8973, -0.0698, 2.8973, 3.7525, 2.8973]';
    n = length(t);
    
    fontSize = 20;
    lineWidth = 1.5;
    
    if nargin < 3
        for i = 1:7
            h = subplot(4,2,i)
            xlabel('t [seconds]')

            hold on
            plot(t, qs(:,i), 'LineWidth', lineWidth)
            plot(t, ones(n,1) * q_min(i), 'r--', 'LineWidth', lineWidth);
            plot(t, ones(n,1) * q_max(i), 'r--', 'LineWidth', lineWidth);
            h = ylabel("$q_"+string(i)+"$", 'FontSize', fontSize);
            h.set('Interpreter','latex');
        end
        sgtitle('q(t) and limits')

    else
        figure(1)
        for i = 1:4
            h = subplot(4,1,i)
            xlabel('t [seconds]')

            hold on
            plot(t, qs(:,i), 'LineWidth', lineWidth)
            plot(t, ones(n,1) * q_min(i), 'r--', 'LineWidth', lineWidth);
            plot(t, ones(n,1) * q_max(i), 'r--', 'LineWidth', lineWidth);
            ylabel("q_"+string(i));
        end

        figure(2)
        for i = 1:3
            h = subplot(3,1,i)
            hold on
            plot(t, qs(:,i + 4), 'c', 'LineWidth', lineWidth)
            plot(t, ones(n,1) * q_min(i + 4), 'r--', 'LineWidth', lineWidth);
            plot(t, ones(n,1) * q_max(i + 4), 'r--', 'LineWidth', lineWidth);
            xlabel('t [seconds]')
            ylabel("q_"+string(i + 4));
        end
    
    end
    
    hold off
end
