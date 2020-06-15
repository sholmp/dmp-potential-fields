function d_avg = averagePoseDifference(robot, endEffectorName, T_desired, qs, S)
    T_actual = [];
    for idx = 1:size(qs,1);
        T_actual(:,:,idx) = robot.getTransform(qs(idx,:)', endEffectorName);
    end
    
    xyz_actual = transl(T_actual);
    xyz_desired = transl(T_desired);
    
%     diff = xyz_actual - xyz_desired;
%     
%     l = sqrt(diag(diff * diff'));% length vector 
%     d_avg = mean(l);
    
    T_actual = SE3(T_actual);
    T_desired = SE3(T_desired);
    rpy_actual = T_actual.torpy('zyx');
    rpy_desired = T_desired.torpy('zyx');
    
    
    %
    X_actual = [rpy_actual xyz_actual];
    X_desired = [rpy_desired xyz_desired];

    X_diff = X_actual - X_desired;
    
    % Apply mask
    for i = 6:-1:1
        if ~S(i)
            X_diff(:,i) = [];
%             J(i,:) = [];
%             Vdes(i,:) = [];
        end
    end
%     
    


    l = sqrt(diag(X_diff * X_diff'));% length vector 
    d_avg = mean(l);
    
    
    
end