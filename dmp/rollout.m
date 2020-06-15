%c: centers of basis functions
%h: variance of basis functions
%eta: gain on repulsive potential field
function y_track = rollout(az, bz, ax, tau, dt, weights, c, h, g, y0, obstacles, runtime, eta)
    n_dim = size(weights,2);
    
    function forcing_term = f(x)
        forcing_term = zeros(1,n_dim);
        for d = 1:n_dim
            psi = exp(-h .* (x - c).^2);  
            num = dot(psi,weights(:,d));
            den = sum(psi);
            forcing_term(d) = (num / den) * x;
        end
    end

    %if y0 == g in any dimension, then perturb that dimensions goal a tiny
    %bit
%     g(y0 == g) = g(y0 == g) + rand() * 1e-2;

    %initial conditions:
    y = y0;
    z = zeros(n_dim,1);
    x = 1;
    
    t = 0;
    y_array =   [y0];
    x_array =   [x];
    z_array =   [z];
    f_array =   [f(x)];
    
%     rf_array    = repulsive_force_apf(y0', obstacles);
    if isempty(eta)
        eta = 4;
    end
    
    %simulation:
    while t < runtime;
        ydot = tau * z;
%         zdot = tau * ( az * (bz * (g - y) - z) + f(x)' .* (g - y0) )
%         zdot = tau * ( az * (bz * (g - y) - z) + f(x)' .* (g - y0) ) + repulsive_force_apf_nearest_point(y, obstacles); 
        zdot = tau * ( az * (bz * (g - y) - z) + f(x)' .* (g - y0) ) + eta * repulsive_force_apf(y, g, obstacles) + static_forces(y); %avoid_obstacle(y,ydot,obstacles, g);
%         zdot = tau * ( az * (bz * (g - y) - z) + f(x)' .* (g - y0) ) + repulsive_force_avoid(y,ydot,obstacles, g);
%         zdot = tau * ( az * (bz * (g - y) - z) + f(x)' .* (g - y0) ) + repulsive_force_avoid_projections(y, ydot, obstacles, g);

        xdot = -ax * tau * x;
        
        y = y + ydot * dt;
        z = z + zdot * dt;
        x = x + xdot * dt;

        t = t + dt;
                
        y_array     = [y_array y];
        x_array     = [x_array x];
%         z_array     = [z_array z];
%         f_array     = [f_array; f(x)];
%         rf_array    = [rf_array; rf(y', obstacles)];

    end
    %plot(vecnorm(f_array,2,2),'LineWidth', 3)
%     hold on
%     plot(rf_array(:,1),'b','LineWidth', 1.5)
%     plot(rf_array(:,2),'r','LineWidth', 1.5)
%     plot(rf_array(:,1), rf_array(:,2));
%     plot(vecnorm(rf_array,2,2),'LineWidth', 1.5)
%     plot(z_array(1,:),'LineWidth', 1.5)
%     plot(z_array(2,:),'LineWidth', 1.5)
    
    %legend('norm forcing term', 'rf_{array} dim 1', 'rf_array dim 2', 'norm rf', 'z_array dim 1', 'z_array dim 2');
    

    y_track = y_array;

end