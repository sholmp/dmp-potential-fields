function y_des = getUserTrajectoryAndShowCurrentObstacles(obstacles)
    
    hold on
    axis([-0.85 0.85 -0.85 0.85])
    xo = obstacles(:,1);
    yo = obstacles(:,1);
    
    plot(xo,yo,'*')
    fig = figure(1)
    xlabel('x [m]'); ylabel('y [m]');
    axis([-0.85 0.85 -0.85 0.85])
    [x,y] = getpts(fig)

    res = 0.005; %resolution

    x_interp = interp1(linspace(0,1,length(x)), x, 0:res:1,'spline');
    y_interp = interp1(linspace(0,1,length(y)), y, 0:res:1,'spline');


end