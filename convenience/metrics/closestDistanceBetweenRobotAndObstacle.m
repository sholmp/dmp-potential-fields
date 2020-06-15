function [d, collision] = closestDistanceBetweenRobotAndObstacle(robot, qs, obstacle)

    d = inf;
    collisionArray = getCollisionArray(robot);
    collision = false;
    
    for i = 1:size(qs,1)
        q = qs(i,:)';
        transformBodyCollisionArray(robot, q, collisionArray);
        for j = 1:numel(collisionArray) %Loop starts at 2 to ignore base
            mesh = collisionArray{j};
            if isa(mesh, 'collisionMesh')
                
                [inCollision, dj, wpj] = checkCollision(mesh, obstacle.colMesh);
                if inCollision
                    fprintf("robot collision @ q(%d), link %d)\n",i,j)
                    collision = true;
                end
                
                if dj < d
                    d = dj;
                end

            end
        end
    end
    
    
    
    
    
end