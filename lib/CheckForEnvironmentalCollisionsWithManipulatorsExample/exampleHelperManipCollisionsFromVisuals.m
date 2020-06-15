function collisionArray = exampleHelperManipCollisionsFromVisuals(robot)
    % This file is for internal use only and may be modified or removed in
    % a future release.
    %
    %exampleHelperCreateCollisionsFromVisuals Create collision array from visuals
    
    %   Copyright 2019 The MathWorks, Inc.
    
    % This function is a wrapper for the static method in the associated
    % helper class. Check that the helper class is available on the path
    if ~exist('helperClassManipCollisionsFromVisuals', 'class')
        error('This function uses the helperClassManipCollisionsFromVisuals class. Please ensure that it is available on the path.');
    end
    
    collisionArray = helperClassManipCollisionsFromVisuals.createCollisionArray(robot);
end

