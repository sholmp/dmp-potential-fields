function obstacles = getObstaclesFromTriangles()
    string = fileread('/home/soren/9sem/speciale/matlab/DMP_OOP/data/triangle_positions.txt');
    expression = '(-?\d+\.?\d*),\s(-?\d+\.?\d*),\s(-?\d+\.?\d*)';

    tokens = regexp(string, expression, 'tokens');

    mat = [];
    for i=1:size(tokens,2)
        for j=1:3
            mat(end+1) = str2double(tokens{i}{j});
        end
    end

    mat = reshape(mat,[9 size(mat,2)/9]);
    mat = mat';

    X = mat(1:end,1:3:7);
    Y = mat(1:end,2:3:8);
    Z = mat(1:end,3:3:9);
    X_bar = mean(X,2);
    Y_bar = mean(Y,2);
    Z_bar = mean(Z,2);
    
    obstacles = [X_bar Y_bar Z_bar];
end

