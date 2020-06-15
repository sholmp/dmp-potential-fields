function rf = repulsive_force_avoid_projections(y, ydot, obstacles, goal)

rf = zeros(3,1);
for i = 1:size(obstacles,1)
    o = obstacles(i,:)';
    
    if norm(goal - o) < norm(goal - y) %obstacle is between y and goal - so obstacle needs to be considered
        rf = rf + calc_pval(ydot, o, y, 'xy')
        rf = rf + calc_pval(ydot, o, y, 'zx')
        rf = rf + calc_pval(ydot, o, y, 'yz')
    end
end

function pval = calc_pval(v,o,p,plane)
    gamma = 1000;
    beta = 15 / pi;
    op = o-p;
    
    switch plane
        case 'xy'
            v = [v(1); v(2)];
            o = [o(1); o(2)];
            p = [p(1); p(2)];
        case 'zx'
            v = [v(3); v(1)];
            o = [o(3); o(1)];
            p = [p(3); p(1)];
        case 'yz'
            v = [v(2); v(3)];
            o = [o(2); o(3)];
            p = [p(2); p(3)];
        otherwise
            disp("plane should be xy, zx or yz")
    end
    
    theta = atan2(op(2), op(1));
    RWF = rot2(theta);
    Fv = RWF \ v; %v as seen in frame F
    phi = atan2(Fv(2), Fv(1)); 
    dphi = gamma * phi * exp(-beta * norm(phi));
    vdot = RWF(:,2) * dphi;

    switch plane
        case 'xy'
            pval = [vdot(1); vdot(2); 0];
        case 'zx'
            pval = [vdot(2); 0; vdot(1)];
        case 'yz'
            pval = [0; vdot(1); vdot(2)];
        otherwise
            disp("plane should be xy, zx or yz")
    end
end



end