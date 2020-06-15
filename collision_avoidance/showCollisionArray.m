function showCollisionArray(robot, q)
    
    collisionArray = getCollisionArray(robot);

    %Copy collision array. 
    collisionArrayCopy = cell(size(collisionArray));
    for i = 1:numel(collisionArray)
        mesh = collisionArray{i};
        if isa(mesh, 'collisionMesh')
            collisionArrayCopy{i} = collisionArray{i}.copy;
        else
            collisionArrayCopy{i} = collisionArray{i};
        end
    end 
    
    transformBodyCollisionArray(robot, q, collisionArrayCopy);
    
%     robot.show(q, 'PreservePlot', false)
%     hold on
    for i = 1:numel(collisionArrayCopy)
        mesh = collisionArrayCopy{i};
        if isa(mesh, 'collisionMesh')
            mesh.show
        end
    end
    hold off
end

