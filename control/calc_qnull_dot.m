function qnull_dot = calc_qnull_dot(ql_dot, qo_dot, use_obstacle_avoidance, use_limit_avoidance)
    if use_obstacle_avoidance && use_limit_avoidance
    qnull_dot = N * pinv(N) * (ql_dot + qo_dot);
    elseif use_obstacle_avoidance
        qnull_dot = N * pinv(N) *  qo_dot;
    elseif use_limit_avoidance
        qnull_dot = N * pinv(N) *  ql_dot;
    else
        qnull_dot = zeros(7,1);
    end
end