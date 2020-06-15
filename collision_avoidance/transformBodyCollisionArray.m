function transformBodyCollisionArray(robot, q, bodyCollisionArray)
    
    robotBodyNames = [{robot.Base.Name} robot.BodyNames];%[{robot.Base}, robot.Bodies];

    for i = 1:numel(bodyCollisionArray)
        if ~isempty(bodyCollisionArray{i})
            bodyName = robotBodyNames{i};
            bodyCollisionArray{i}.Pose = robot.getTransform(q, bodyName);
        end
    end

end