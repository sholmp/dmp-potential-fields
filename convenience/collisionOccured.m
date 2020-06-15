function collision = collisionOccured(robot, qs, obstacles)
    collision = false;

    bodyCollisionArray = getCollisionArray(robot);
    for i = 1:size(qs,1)
        transformBodyCollisionArray(robot, qs(i,:)', bodyCollisionArray);
        for j = 1:numel(bodyCollisionArray)
            mesh = bodyCollisionArray{j};
            for k = 1:length(obstacles)
                obstacle = obstacles{k}.colMesh;
                if isa(mesh, 'collisionMesh')
                    [inCollision, ~, ~] = checkCollision(mesh, obstacle);
                    if inCollision
                        collision = true;
                        return
                    end
                end
            end
        end
    end

end