function within = within_joint_limits_single_q(q)
    q_min = [-2.8973, -1.7628, -2.8973, -3.0718, -2.8973, -0.0175, -2.8973]';
    q_max = [2.8973, 1.7628, 2.8973, -0.0698, 2.8973, 3.7525, 2.8973]';


    and(q > q_min, q < q_max);
    within = all(q > q_min) && all(q < q_max);
    
%     if ~within
%         fprintf('Panda joint limits exceed \n');
%     end

end