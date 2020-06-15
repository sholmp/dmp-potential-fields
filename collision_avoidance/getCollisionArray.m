function collisionArray = getCollisionArray(robot)

    collisionArray = exampleHelperManipCollisionsFromVisuals(robot);
    collisionArray = collisionArray(:,1); %Cut away information: 
                                          %Transformation from mesh origin to body frame origin
end

