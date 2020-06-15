function d_avg = averageDistanceFromLimitsMidpoint(qs)

    q_min = [-2.8973, -1.7628, -2.8973, -3.0718, -2.8973, -0.0175, -2.8973]';
    q_max = [2.8973, 1.7628, 2.8973, -0.0698, 2.8973, 3.7525, 2.8973]';
    centers = 0.5 * (q_min + q_max);
    
    diff = qs - centers';
    diff_bar = mean(diff);
    
    d_avg = norm(diff_bar);
    

end