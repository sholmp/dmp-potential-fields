function within = within_joint_limits(qs)
    within = true;
    for i = 1:size(qs,1)
        within = within_joint_limits_single_q(qs(i,:)');
        if ~within
            break
        end
    end
    
    if ~within
        fprintf('Panda joint limits exceed \n');
    end

end