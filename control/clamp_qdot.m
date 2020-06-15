function qdot_clamped = clamp_qdot(qdot)
    
    panda_vel_limits = [(5/6)*pi, (5/6)*pi, (5/6)*pi, (5/6)*pi, pi, pi, pi]';
    
    scale = abs(qdot ./ panda_vel_limits);

    if nnz(scale > 1) ~= 0
        qdot_clamped = qdot / max(scale);
    else
        qdot_clamped = qdot;
    end

end

