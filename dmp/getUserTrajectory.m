function [y_des, obstacles] = getUserTrajectory()
    fig = figure(1)
    xlabel('x [m]'); ylabel('y [m]');
     axis([-0.85 0.85 -0.85 0.85])
     [x,y] = getpts(fig)

    res = 0.001; %resolution

    x_interp = interp1(linspace(0,1,length(x)), x, 0:res:1,'spline');
    y_interp = interp1(linspace(0,1,length(y)), y, 0:res:1,'spline');

    plot(x_interp,y_interp);
    xlabel('x [m]'); ylabel('y [m]');
    axis([-0.85 0.85 -0.85 0.85])
    
    [xo, yo] = getpts(fig);    
    
    y_des = [x_interp; y_interp];
    obstacles = [xo,yo];
    
    
    function [x,y] = plot_circle(x0, y0, r, fig)
    
        x0 = 0;
        y0 = 2;
        
        theta = 0:0.01:2*pi;
        x_coords = [x0 + cos(theta) * r];
        y_coords = [y0 + sin(theta) * r];
        
%         h = plot(x_coords, y_coords);
        x = x_coords;
        y = y_coords;
    end
    
end