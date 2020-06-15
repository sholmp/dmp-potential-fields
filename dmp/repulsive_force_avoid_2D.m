function repulsive_force = repulsive_force_avoid_2D(y, ydot, obstacles, goal)
    
    p = 0;

    for i = 1:size(obstacles,1)
        beta = 20 / pi;
        gamma = 250;

        obstacle = obstacles(i,:);

        phi_ydot = atan2(ydot(2),ydot(1));
        R_ydot = [cos(phi_ydot) sin(phi_ydot);
                  -sin(phi_ydot) cos(phi_ydot)];

        yo = obstacle - y';

        yo_rotated = R_ydot * yo';
        phi = atan2(yo_rotated(2), yo_rotated(1));

        dphi = gamma * phi * exp(-beta * norm(phi));

        R = [cos(pi/2) sin(pi/2);
         -sin(pi/2) cos(pi/2)];

        pval = R * ydot * dphi;
        
        if norm(yo) > norm(goal - y)
            pval = 0;
        end
        
        p = p + pval;
        
    end
    
    repulsive_force = p;
    

end