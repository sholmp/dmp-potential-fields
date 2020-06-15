clc; clear;

TG = TrajectoryGenerator;

y_demo = [1, 3, 7, 2];
t_stop = 1;
dt = 0.01;

y_splined = TG.splined_motion(y_demo, t_stop, dt)