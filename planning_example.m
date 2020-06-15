% This example shows how the framework can be used
% to generate trajectories for a pick and place application.
% The goal is to move cylinders from an initial position onto 
% different coasters.

clc; clear; close all;

%% Load Franka Panda Robot

robot = importrobot('panda_arm.urdf');
endEffectorName = robot.BodyNames{end};
robot.DataFormat = 'column';
robot.show(robot.randomConfiguration)

%% Build a test environment

% Can tray:
canTrayLength = 0.40;
canTrayWidth = 0.25;
canTrayHeight = 0.01;

canTray = collisionBox(canTrayLength, canTrayWidth, canTrayHeight);
canTray.Pose = transl(0.4,-0.3,-0.5 * canTrayHeight);

% Coaster tray
coasterTrayLength = 0.40;
coasterTrayWidth = 0.25;
coasterTrayHeight = 0.01;
coasterTray = collisionBox(coasterTrayLength, coasterTrayWidth, coasterTrayHeight);
coasterTray.Pose = transl(0.40, 0.35,-0.5*coasterTrayHeight);

% cans:
canRadius = 0.03;
canHeight = 0.1;

can1 = collisionCylinder(canRadius,canHeight)
can2 = collisionCylinder(canRadius,canHeight)
can3 = collisionCylinder(canRadius,canHeight)

can1.Pose = transl(0.3,-0.3, 0.5 * canHeight)
can2.Pose = transl(0.4,-0.3, 0.5 * canHeight)
can3.Pose = transl(0.5,-0.3, 0.5 * canHeight)

% Coasters:
coasterRadius = 0.05;
coasterHeight = 0.02;
c1 = collisionCylinder(coasterRadius,coasterHeight);
c2 = collisionCylinder(coasterRadius,coasterHeight);
c3 = collisionCylinder(coasterRadius,coasterHeight);

c1.Pose = transl(0.25,0.3,0.5*coasterHeight);
c2.Pose = transl(0.4,0.4,0.5*coasterHeight);
c3.Pose = transl(0.55,0.3,0.5*coasterHeight);

% Milk
milkLength = 0.05;
milkWidth = 0.05;
milkHeight = 0.15;
milk = collisionBox(milkLength, milkWidth, milkHeight);
milk.Pose = transl(0.3,0,0.5*milkHeight);

% interactiveRigidBodyTree(robot)
robot.show
hold on
canTray.show
coasterTray.show
% wall.show
milk.show

[~, can1Patch] = can1.show
[~, can2Patch] = can2.show
[~, can3Patch] = can3.show

[~, coaster1Patch] = c1.show;
[~, coaster2Patch] = c2.show;
[~, coaster3Patch] = c3.show;

can1Patch.FaceColor = [1 0 0];
can2Patch.FaceColor = [0 1 0];
can3Patch.FaceColor = [0 0 1];

coaster1Patch.FaceColor = [1 0 0];
coaster2Patch.FaceColor = [0 1 0];
coaster3Patch.FaceColor = [0 0 1];

%% Define the poses to grasp cylinders

z_offset = 0.05;
yaw = pi; %pi;
graspCan1 = can1.Pose * transl(0,0,z_offset) * eul2tform([0,0,yaw], 'ZYX')
releaseCan1 = c1.Pose * transl(0,0,z_offset) * eul2tform([0,0,yaw], 'ZYX');

graspCan2 = can2.Pose * transl(0,0,z_offset) * eul2tform([0,0,yaw], 'ZYX')
releaseCan2 = c2.Pose * transl(0,0,z_offset) * eul2tform([0,0,yaw], 'ZYX');

graspCan3 = can3.Pose * transl(0,0,-z_offset) * eul2tform([0,0,yaw], 'ZYX')
releaseCan3 = c3.Pose * transl(0,0,-z_offset) * eul2tform([0,0,yaw], 'ZYX');

trplot(graspCan1, 'length', 0.1, 'thick', 3, 'rgb')
trplot(releaseCan1, 'length', 0.1, 'thick', 3, 'rgb')

trplot(graspCan2, 'length', 0.1, 'thick', 3, 'rgb')
trplot(releaseCan2, 'length', 0.1, 'thick', 3, 'rgb')

trplot(graspCan3, 'length', 0.1, 'thick', 3, 'rgb')
trplot(releaseCan3, 'length', 0.1, 'thick', 3, 'rgb')

%% Compute joint configurations for grasp poses

sp.SolutionTolerance = 1e-6;
ik = inverseKinematics('RigidBodyTree', robot, 'SolverParameters', sp);
qGuess = robot.randomConfiguration;
q1 = ik(endEffectorName, graspCan1, [1 1 1 1 1 1], qGuess);
q2 = ik(endEffectorName, graspCan2, [1 1 1 1 1 1], qGuess);
q3 = ik(endEffectorName, graspCan3, [1 1 1 1 1 1], qGuess);

%% Load a DMP. 
% In this case it is trained to produce a straight line between two poses

load('dmp_straight_line.mat')
dt = dmp_straight_line.dt;
obstacles = {MeshObstacle(milk)}; % Define the "milk" as the only obstacle.

% Use DMP to generate trajectory to place can1 on coaster 2:
can2Traj = generateTrajectory(graspCan1, releaseCan2, dmp_straight_line, obstacles);

plotTransformTrajectory(can2Traj,'lineWidth',2.5);


%% Use Closed Loop Inverse Kinematics to track trajectory

[qs, q_dots] = follow_trajectory(robot, can2Traj, endEffectorName, q1, 0.02, obstacles,...
    'lim_avoid', true,'obs_avoid', true, 'mask', [1 1 0 1 1 1]);

visualize_robot_path(robot, qs, 10, [], 'PreservePlot', false, 'Frames', 'on', 'Visuals', "on");

% plotQdotsWithLimits(q_dots.q_dot,dt)
% plotQsWithLimits(qs, dt)
% plotComparisonXYZ(robot, endEffectorName, can2Traj, qs, dt)
% plotComparisonRPY(robot, endEffectorName, can2Traj, qs, dt)


