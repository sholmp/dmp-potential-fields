%Repulsive Force Artificial Potential Field
function repulsive_force = repulsive_force_apf_closest_obstacle(y, obstacles)
    
     if ~isempty(obstacles)
        idx = knnsearch(obstacles, y); %y must be row vector, and obstacles is a list of row vectors
        o = obstacles(idx,:);       

        D = norm(y-o);
        Q = 0.3;
        eta = 200;
%         repulsive_force = eta * (1/D - 1/Q) * ((1/D)^3 * (y-o));


        if D < Q
%             repulsive_force = eta * (1/D - 1/Q) * ((1/D)^3 * (y-o)); 
            repulsive_force = eta * (y-o) / D;
        else
            repulsive_force = zeros(1,length(y));
        end
    else
        repulsive_force = 0;
    end
end