function writeObstaclesToFile(obstacles)

    if ~isempty(obstacles)
        
        obstacle_transforms = [obstacles  zeros(size(obstacles,1),3)];
        writematrix(obstacle_transforms,...
        '~/hobby/rw_place_box_ui/data/obstacles/obstacle_transforms.txt', 'delimiter', 'tab');
    else
        writematrix([],'~/hobby/rw_place_box_ui/data/obstacles/obstacle_transforms.txt');
    end
    
end