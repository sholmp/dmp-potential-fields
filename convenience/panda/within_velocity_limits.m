function within = within_velocity_limits(qdot_array)

    q_vel_lims = [(5/6)*pi, (5/6)*pi, (5/6)*pi, (5/6)*pi, pi, pi, pi];
        
    comparison = abs(qdot_array) > q_vel_lims;
    
    if nnz(comparison) > 0
        fprintf("Panda velocity limits exceeded\n")
        within = false;
    else
        within = true;
    end
    
end