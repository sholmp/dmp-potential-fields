function plotComparisonRPY(robot, endEffectorName, T_desired, qs, dt)
    figure
    t_end = (length(qs)-1) * dt;
    t = 0:dt:t_end;
    N = size(qs,1);

    T_actual = [];
    rpy_actual = zeros(size(qs,1),3);
    rpy_desired = zeros(size(T_desired,3),3);

    for i = 1:N
%         T_actual(:,:,idx) = robot.getTransform(qs(idx,:)', endEffectorName);
        T_actual = robot.getTransform(qs(i,:)', endEffectorName);

        rpy_actual(i,:) = tform2eul(T_actual,'ZYX');
        rpy_desired(i,:) = tform2eul(T_desired(:,:,i),'ZYX');
    end
    
    
% 
%     
%     T_actual = SE3(T_actual);
%     T_desired = SE3(T_desired);
%     rpy_actual = T_actual.torpy('zyx');
%     rpy_desired = T_desired.torpy('zyx');
    
    
    labels = {'R','P','Y'};
    lineWidth = 1.5;
    hold on
    for i = 1:3
        subplot(3,2,k);

        plot(t, rpy_desired(:,i),'r', 'LineWidth', lineWidth);
        hold on
        plot(t, rpy_actual(:,i),'b--', 'LineWidth', lineWidth);
        
        if i == 3
            legend('desired', 'End effector');
        end
        ylim([-pi pi])
        ylabel(labels{i});
    end
    sgtitle('RPY (ZYX) actual vs desired');
    xlabel('t [seconds]');

    hold off;
    
    
    
end

