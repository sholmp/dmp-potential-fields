%Timestep is the the time between two samples in y_des
function [weights, centers, variances] = train_DMP(az, bz, ax, num_bfs, dt, y_des, timestep)
    
    n_dim = size(y_des,1);
    t_end = (length(y_des) - 1) * timestep;   
    
    % perturbation
%     y0 = y_des(:,1);
%     y_end = y_des(:,end);
%     
%     y_end(y0 == y_end) = y_end(y0 == y_end) + rand() * 1e-3; 
%     y_des(:,end) = y_end;
% %     
% %     (y0 == g) = g(y0 == g) + rand() * 1e-3;

    

       
    if(dt ~= timestep) %Then interpolate the trajectory
        y_interp = [];
        for i = 1:n_dim
            y_interp(i,:) = interp1(0:timestep:t_end, y_des(i,:), 0:dt:t_end)
        end
        y_des = y_interp;
    end
    
    %Differentiate y_des:
    yd_des  = [zeros(n_dim, 1) diff(y_des,  1, 2) ./ dt]; 
    ydd_des = [zeros(n_dim, 1) diff(yd_des, 1, 2) ./ dt];

    %Make equally spaced basis functions:
    t_eq = linspace(0, t_end, num_bfs);
    c = exp(-ax * t_eq);             %Centers
    h = 10 * num_bfs ./ c.^2;
    
    t = 0:dt:t_end;
    x = exp(-ax .* t);
    
    for i = 1:num_bfs
        bfs(i,:) = exp(-h(i) * (x-c(i)).^2);
    end    
    
    g   = y_des(:,end);
    y0  = y_des(:,1);
    F_target = ydd_des - az * (bz * (g - y_des) - yd_des); %No tau here, because 'relative time'
    
    
    for i = 1:n_dim
        S(:,i) = x' * (g(i)-y0(i));         
    end
    
    for i = 1:n_dim
        s = S(:,i);
        f_target = F_target(i,:)';
        for j = 1:num_bfs
            rj = diag(bfs(j,:));
            W(j,i) = s' * rj * f_target / (s' * rj *s);   %eq (2.14) p. 344 Ijspeert et al.  
        end
    end
    
    weights = W;
    centers = c;
    variances = h;
    
    %Plot basis functions:    
%     figure(2)
%     subplot(2,1,1)
%     for i = 1:num_bfs
%         plot(t,bfs(i,:))
%         hold on
%     end
%     xlabel('t')
%     
%     subplot(2,1,2)
%     for i = 1:num_bfs
%         plot(x,bfs(i,:))
%         hold on
%     end
%     xlabel('x')
%     
end