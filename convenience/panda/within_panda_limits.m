function within = within_panda_limits(qs, qdots)
    
    within1 = true;
    
%     for i = 1:size(qs,1)
%         within1 = within_joint_limits(qs(i,:)')
%         
%         if ~within1
%             break
%         end
%     end
    within1 = within_joint_limits(qs);
    within2 = within_velocity_limits(qdots);
    within3 = within_acceleration_limits(qdots, 0.02);
    
%     within = within1 && within2 && within3;
    within = within2 && within3;

end