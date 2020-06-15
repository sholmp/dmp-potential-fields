function quivers = getQuivers(robot, obstacles, qs)
    collisionArray = getCollisionArray(robot);
    quivers = []
    for i = 1:size(qs,1)
        q = qs(i,:)';
        d = Inf;
        x_link = [];
        x_obs = [];
        closest_link_name = '';
        for i = 1:numel(obstacles)
            [~, x_link_i, x_obs_i] = findClosestLink(robot, q, collisionArray, obstacles{i}.colMesh);
            di = norm(x_link_i - x_obs_i);
            if di < d
                x_link = x_link_i;
                x_obs = x_obs_i;
                d = di;
            end
        end
        quiver.head = x_link;
        quiver.tail = x_obs;
        quivers = [quivers quiver];
    end
end

