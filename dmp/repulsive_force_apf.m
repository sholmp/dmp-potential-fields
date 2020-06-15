%Repulsive Force Artificial Potential Field
function rf = repulsive_force_apf(y, g, obstacles)
    rf = zeros(3, 1); 

    for i = 1:length(obstacles)
        o = obstacles{i};
        
        u = (y - o.center) / norm(y - o.center);
        [np, d] = o.nearestPoint(y);
        
        
        if norm(y - g) > norm(o.center - g)
            rf = rf + (1/d^2) * u;
        end
%         if d < 0.1
%             rf = rf + (1/d^2) * u;
%         end
    end
    
end