function writeYtrackToFile(y_track)
    
    z = 0.2;
    num_cols = size(y_track,2);
    
    
    Rx = 0; Ry = pi; Rz = 0;
    rotation = [ones(num_cols,1)*Rx ones(num_cols,1)*Ry ones(num_cols,1)*Rz];
    y_track_transforms = [y_track' rotation];
    
    writematrix(y_track_transforms,...
        '~/hobby/rw_place_box_ui/data/trajectories/y_track_transforms.txt',...
        'Delimiter','tab');
end