% clc; clear;
% close all;

% load('obstacles_and_ptcloud.mat')
% load('/home/soren/speciale/simulation/tests/using_matlab/avoid_rod/rod.mat')

t_stop      = 1;

% x = linspace(0.1, -0.7, 100);
% y = linspace(0.6, 0.2, 100);
% z = linspace(0.3, 0.2, 100);
% obstacles = boundingSpheres(4);

% x = linspace(-1, 0, 100);
% y = linspace(0, -1, 100);
% z = linspace(0.3, 0.31, 100);
% obstacles = boundingBoxes(1);

% x = linspace(0.5, 0, 500);
% y = linspace(0, 0.5, 500);
% z = linspace(0.3, 0.31, 500);
% obstacles = {rod}
% 

% x = linspace(0.1,0.3, 500);
% y = linspace(0.1, 0.3, 500);
% zq = linspace(0, 2, 500);
% z = 0.19 * zq - 0.09 * zq.^2


x = linspace(0.1, 0.2, 500);
y = linspace(-0.3, 0.3, 500);
A = [0 0 1; (-0.3)^2 -0.3 1; 0.3^2 0.3 1];
b = [0.2; 0.1; 0.15];
c = A\b
z = c(1) * y.^2 + c(2) * y + c(3);


y_des = [x; y; z];

obstacles = {};

dt = t_stop / (length(y_des) - 1);
timestep = dt;
% dmp_straight_line = DMP(y_des, dt, dt)
% y_track = dmp_straight_line.rollout([],[],[], 1);

dmp_parabola = DMP(y_des, dt, dt);
g           = y_des(:,end);
y0          = y_des(:,1);
y_track = dmp_parabola.rollout(y0,g,[], [], []);




% y_des = getUserTrajectory()
% y_des = [y_des; zeros(1, length(y_des))]

% dt = t_stop / (length(y_des) - 1);
% timestep = dt;

az          = 50; %50
bz          = az / 4;
ax          = 1;
tau         = 1;
num_bfs     = 500;
g           = y_des(:,end);
y0          = y_des(:,1);
simulation_runtime = t_stop; % * 1.5;            

% [weights, centers, variances] = train_DMP(az,bz,ax,num_bfs,dt,y_des,timestep);
% y_track = rollout(az, bz, ax, tau, dt, weights, centers, variances, g, y0, obstacles, simulation_runtime);
if(size(y_des,1) == 1)
    plot(0:dt: (length(y_track)-1) * dt, y_track(1,:),'b--','linewidth', 2);
    hold on
    plot(0:dt:t_stop, y_des(1,:),'r')
    legend('Trained trajectory', 'Input trajectory')
    ylabel('y(t)')
    xlabel('time')
else
    %subplot(3,1,1)
    figure(1)
    plot(y_track(1,:), y_track(2,:),'b--', 'linewidth',2)
    hold on
    plot(y_des(1,:), y_des(2,:), 'r');
    axis([-1 1 -1 1]); axis square;

    xlabel('y1(t)')
    ylabel('y2(t)')
    hold on
    if ~isempty(obstacles)
%         plot(obstacles(:,1), obstacles(:,2), 'X', 'MarkerSize', 10)
        legend('Trained trajectory', 'Input trajectory', 'Obstacle')
    end
    figure(2)
    subplot(3,1,1)
    plot(0:dt: (length(y_track)-1) * dt , y_track(1,:),'b--','linewidth', 2);
    hold on
    plot(0:timestep:t_stop, y_des(1,:),'r')
    legend('Trained trajectory dimension 1', 'Input trajectory')
    ylabel('y1(t)')
    xlabel('time')
    
    subplot(3,1,2)
    plot(0:dt: (length(y_track)-1) * dt, y_track(2,:),'b--','linewidth', 2);
    hold on
    plot(0:timestep:t_stop, y_des(2,:),'r')
    legend('Trained trajectory dimension 2', 'Input trajectory')
    ylabel('y2(t)')
    xlabel('time')
    
    subplot(3,1,3)
    plot(0:dt: (length(y_track)-1) * dt, y_track(3,:),'b--','linewidth', 2);
    hold on
    plot(0:timestep:t_stop, y_des(3,:),'r')
    legend('Trained trajectory dimension 3', 'Input trajectory')
    ylabel('y3(t)')
    xlabel('time')
end


