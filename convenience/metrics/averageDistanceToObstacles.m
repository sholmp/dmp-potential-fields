%Disclaimer: Only works for a single obstacle
function d_avg = averageDistanceToObstacles(robot, qs, obstacle)
    d = 0;
    collisionArray = getCollisionArray(robot);
    
    for i = 1:size(qs,1)
        q = qs(i,:)';
        transformBodyCollisionArray(robot, q, collisionArray);
        for j = 4:numel(collisionArray) %Loop starts at 2 to ignore base
            mesh = collisionArray{j};
            if isa(mesh, 'collisionMesh')
                
                [inCollision, dj, wpj] = checkCollision(mesh, obstacle.colMesh);
                if inCollision
                    fprintf("robot collision @ q(%d), link %d)\n",i,j)
                end
                d = d + dj;  
            end
        end
    end
    
    num_points = size(qs,1);
    num_links = 10; % 2 links have no meshes, and base frame ignored: 13-3 = 10
    d_avg = d / (num_points * num_links);
    
    
    
end