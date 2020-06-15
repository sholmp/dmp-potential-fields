function sf = static_forces(y)
    sf = zeros(3,1);

    % floor repellant
    floor_vec = y - [y(1), y(2), 0]';
    d = norm(floor_vec);
    if d < 0.05
        sf = (1/d^2) * floor_vec;
    end
    
    % Sphere around workspace repellant
    
    
    % Robot base repellant

end