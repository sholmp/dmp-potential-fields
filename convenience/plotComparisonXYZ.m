function plotComparisonXYZ(robot, endEffectorName, T_desired, qs, dt)
    figure
    t_end = (length(qs)-1) * dt;
    t = 0:dt:t_end;
    
    T_actual = [];
    for idx = 1:size(qs,1);
        T_actual(:,:,idx) = robot.getTransform(qs(idx,:)', endEffectorName);
    end
    
    xyz_actual = transl(T_actual);
    xyz_desired = transl(T_desired);
       
    labels = {'x','y','z'};
    lineWidth = 1.5;
    hold on
    y_lims = {[-0.8 0.8], [-0.8 0.8], [-0.2 1]};

    for i = 1:3
        subplot(3,2,k);
        plot(t, xyz_desired(:,i),'r', 'LineWidth', lineWidth);
        hold on
        plot(t, xyz_actual(:,i),'b--', 'LineWidth', lineWidth);
        if i == 3
            legend('Desired', 'End effector');
        end
%         ylim(y_lims{i})
        ylabel(labels{i});
    end
    sgtitle('XYZ actual vs desired')
    xlabel('t [seconds]');

    hold off;
end

