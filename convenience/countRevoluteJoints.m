function n = countRevoluteJoints(robot)
    n = 0;
    for i = 1:numel(robot.Bodies)
        if strcmp(robot.Bodies{i}.Joint.Type, 'revolute')
            n = n + 1;
        end
    end
end

