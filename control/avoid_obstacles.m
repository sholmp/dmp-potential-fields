%input
%obstacles - cell array of Obstacle objects.

function qo_dot = avoid_obstacles(robot, q, obstacles, collisionArray)   
    %find closest obstacle:
    
    if isempty(obstacles)
        qo_dot = zeros(7,1);
        return
    end
    
    d = Inf;
    x_link = [];
    x_obs = [];
    closest_link_name = '';
%     qo_dot = zeros(7,1);
    for i = 1:numel(obstacles)
        [closest_link_name_i, x_link_i, x_obs_i] = findClosestLink(robot, q, collisionArray, obstacles{i}.colMesh);
        di = norm(x_link_i - x_obs_i);
        if di < d
            x_link = x_link_i;
            x_obs = x_obs_i;
            closest_link_name = closest_link_name_i;
            d = di;
        end
        
%         [closest_link_name, x_link, x_obs] = findClosestLink(robot, q, collisionArray, obstacles{i}.colMesh);
%         d = norm(x_link - x_obs);
%         x0_dot = (1/d^2) * (x_link - x_obs); %0.001 * (1/d^2) * (x_link - x_obs);
%         J0 = closestPointJacobian(robot, q, x_link, closest_link_name);
%         J0 = J0(4:6,:);
%         qo_dot = qo_dot + pinv(J0) * x0_dot;
        
    end

    d = norm(x_link - x_obs);
    x0_dot = (1/d^2) * (x_link - x_obs); %0.001 * (1/d^2) * (x_link - x_obs);
%     x0_dot = (1/d) * (x_link - x_obs); %0.001 * (1/d^2) * (x_link - x_obs);

    
    
    J0 = closestPointJacobian(robot, q, x_link, closest_link_name);
    J0 = J0(4:6,:);
    qo_dot = pinv(J0) * x0_dot;
    
end