classdef TrajectoryGenerator
   
    properties
    
    end
    
    methods
        function y_des = step_function(this, t_stop, timestep)
            t = 0:timestep:t_stop;
            
            y_des = ones(1,length(t)) .* (t >= (0.5 * t_stop));
                        
        end
   
        
        function y_des = projectile_motion(this, t_stop, timestep, theta, v)
            t= 0:timestep:t_stop;
            
            px0 = 0;
            py0 = 0;
            g = 9.82;
            
            px = px0 + cos(theta) * v * t;                        %x(t)
            py = py0 + sin(theta) * v * t - 0.5 * g * t.^2;       %y(t)
            
            y_des = [px; py];
        end
        
        
        %tstop is the timestamp of the final point in y_time_series
        %dt is the rate which the timeseries should be up or downsampled to
        function y_des = splined_motion(this, y_demo, t_stop, dt) 
            
            t   = linspace(0,t_stop,length(y_demo));
            tq  = 0:dt:t_stop; %Query points. 
            
            n_dim = size(y_demo,1);
            for d = 1:n_dim
                y_des(d,:) = interp1(t, y_demo(d,:), tq, 'spline');
            end

            
        end
        
    
    end
    
    
end

