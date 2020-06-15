function repulsive_force = repulsive_force_avoid(y, ydot, obstacles, goal)
    
    p = 0;
    beta = 15 / pi;
    gamma = 5000;
    
    for i = 1:size(obstacles,1)
        o = obstacles(i,:)';
        oy = o - y;
 
        r = cross(oy, ydot);
        
        dist_yg = norm(y - goal); 
        dist_og = norm(o - goal); 
        
        if nnz(r) ~= 0 && dist_yg > dist_og 
            R = angvec2r(pi/2, r);
            theta = acos( dot(oy,ydot) / (norm(oy) * norm(ydot)));
            
            p = p + gamma * R * ydot * theta * exp(-beta * theta);
        end
       
            
    end
    
    repulsive_force = p;
    

end