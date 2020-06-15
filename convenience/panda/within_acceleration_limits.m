function within = within_acceleration_limits(qdot_array, dt)
    
    % Hack: strip last row of qdot_array, because it contains all zeros
    % giving a large acceleration
    qdot_array(end,:) = [];
    
    
    q_acc_lims = [15 7.5 10 12.5 15 20 20]; % https://frankaemika.github.io/docs/control_parameters.html
    q_acc = diff(qdot_array) / dt;
    
    comparison = abs(q_acc) > q_acc_lims;
    
    if nnz(comparison) > 0
        fprintf("Panda acceleration limits exceeded\n")
        within = false;
    else
        within = true;
    end
    
    
    
end