% input: bodyCollisionArray : Nx1 cell array of collisionMeshes 
% (note that some cells will be empty [] - because no stl file was
% associated with the rigidBody.

% output:
% x_link - closest point on a robot link (called x0 in paper)
% x_obs - closest point on obstacle

function [link_name, x_link, x_obstacle] = findClosestLink(robot, q, bodyCollisionArray, obstacle)

    robotBodyNames = [{robot.Base.Name} robot.BodyNames];
    
    closest_idx = 0;
    d = inf;
    wp = zeros(3,2);
    
    transformBodyCollisionArray(robot, q, bodyCollisionArray);

    for i = 1:numel(bodyCollisionArray)
        mesh = bodyCollisionArray{i};
        if isa(mesh, 'collisionMesh')
            [inCollision, di, wpi] = checkCollision(mesh, obstacle);
            
            if di < d
                d = di;
                wp = wpi;
                closest_idx = i;
            end
        end
    end
    
    link_name = robotBodyNames{closest_idx};
    x_link = wp(:,1);
    x_obstacle = wp(:,2);
    
end