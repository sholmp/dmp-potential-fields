classdef DMP
    %DMP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        weights
        centers
        variances
        dt
        
        %
        az         
        bz         
        ax          
        tau         
        num_bfs     
        g           
        y0          
        y_des
    end
    
    methods
        function obj = DMP(y_des, timestep, dt)
            obj.az          = 50;
            obj.bz          = obj.az / 4;
            obj.ax          = 1;
            obj.tau         = 1;
            obj.num_bfs     = 500;
            obj.g           = y_des(:,end);
            obj.y0          = y_des(:,1);
            obj.dt          = dt;
            obj.y_des        = y_des;
            
            
            az = obj.az; bz = obj.bz; ax=obj.ax;
            tau = obj.tau; num_bfs = obj.num_bfs; g = obj.g;
            y0 = obj.y0; dt = obj.dt;
            
            [obj.weights, obj.centers, obj.variances] = train_DMP(az, bz, ax, num_bfs, dt, y_des, timestep)  
        end
        
        function y_track = rollout(obj, y0, g, obstacles, simulation_runtime, eta)
            
            if isempty(g)
                g = obj.g
            end
            if isempty(y0)
                y0 = obj.y0
            end
            if isempty(obstacles)
                obstacles = {}
            end
            if isempty(simulation_runtime)
                simulation_runtime = 1;
            end
            
            [y_track] = rollout(obj.az, obj.bz, obj.ax, obj.tau, obj.dt, obj.weights, ... 
            obj.centers, obj.variances, g, y0, obstacles, simulation_runtime, eta);
        end
    end
        
end

