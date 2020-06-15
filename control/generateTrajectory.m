function Ts = generateTrajectory(T0, T1, dmp, obstacles)
   
    y0 = transl(T0);
    goal = transl(T1);
    xyz = dmp.rollout(y0, goal, obstacles, [], []); %Last argument is eta: gain on repulsive pot. field
    
    R0 = SO3(T0);
    R1 = SO3(T1);
    Rs = R0.interp(R1, length(xyz));
    
    Ts = zeros(4,4);
    for i = 1:length(xyz)
        Ts(:,:,i) = [Rs(i).double xyz(:,i);
                     0 0 0 1];
    end
    
end