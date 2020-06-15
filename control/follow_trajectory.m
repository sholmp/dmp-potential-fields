%dt: timestep between each pose in transforms
%mask: [1 1 1 1 0 0] means masking x,y


function [qs, q_dots] = follow_trajectory(robot, Ts, endEffectorName, q0, dt, obstacles, varargin)
   
    use_obstacle_avoidance = true;
    use_limit_avoidance = true;
    mask = [1 1 1 1 1 1];
    
%     Kp = 1/dt;
%     Kl = 1/dt;
%     Ka = 1/dt;
    
    Ka = 0.04; %0.06;
    Kl = 15;
%     Kp = 60;
    Kp = 10;
    windowSize = 15;
    qo_window = zeros(7, windowSize);
    
    for i = 1:length(varargin)
        if strcmp(varargin{i}, "obs_avoid")
            use_obstacle_avoidance = varargin{i+1};
        elseif strcmp(varargin{i}, "lim_avoid")
            use_limit_avoidance = varargin{i+1};
        elseif strcmp(varargin{i}, "mask")
            mask = varargin{i+1};
        elseif strcmp(varargin{i}, "gains")
            gains = varargin{i+1};
            Kp = gains.Kp;
            Kl = gains.Kl;
            Ka = gains.Ka;
        end
    end


    Ts = SE3(Ts); %Converts a stack of matrices into an array of SE3 objects
%     endEffectorName = robot.BodyNames{end};
    numJoints = countRevoluteJoints(robot);
    collisionArray = getCollisionArray(robot);
    
    qs = zeros(length(Ts), numJoints);
    q_dot_array = zeros(length(Ts), numJoints);
    qx_dot_array = zeros(length(Ts), numJoints);
    qo_dot_array = zeros(length(Ts), numJoints);
    ql_dot_array = zeros(length(Ts), numJoints);   
    qnull_dot_array = zeros(length(Ts), numJoints);
    lambdas = zeros(length(Ts), 1);
    
    qs(1,:) = q0';
    
    q = q0;
    Tcurr = robot.getTransform(q0, endEffectorName);  
    
    for i = 1:length(Ts)-1
        R = Tcurr(1:3,1:3);
        RRe = [R' zeros(3,3); zeros(3,3) R'];
        J = RRe * robot.geometricJacobian(q, endEffectorName);
        Vdes = calc_Vdes(Tcurr, Ts(i), dt);
        
        [J, Vdes] = applyMask(mask, J, Vdes);
        N = null(J);

        l = calc_lambda(J); %lambda
%         qx_dot = inv(J' * J + l * eye(numJoints)) * J' * Vdes;
        qx_dot = J' * inv(J * J' + l * eye(numrows(J))) * Vdes;
        qx_dot = Kp * qx_dot;
%         qx_dot = pinv(J) * Vdes;
        
        ql_dot = Kl * avoid_limits(q);
        qo_dot = Ka * avoid_obstacles(robot, q, obstacles, collisionArray);
        qo_window(:,1:end-1) = qo_window(:,2:end);
        qo_window(:,end) = qo_dot;
        qo_dot = mean(qo_window,2);
        
%         qnull_dot = N * pinv(N) * (ql_dot + qo_dot);
%         qnull_dot = zeros(7,1);
%         qnull_dot = N * pinv(N) * ql_dot;
        
        if use_obstacle_avoidance && use_limit_avoidance
            qnull_dot = N * pinv(N) * (ql_dot + qo_dot);
        elseif use_obstacle_avoidance
            qnull_dot = N * pinv(N) *  qo_dot;
        elseif use_limit_avoidance
            qnull_dot = N * pinv(N) *  ql_dot;
        else
            qnull_dot = zeros(7,1);
        end
        
        qdot = qx_dot + qnull_dot;
        
        qdot = clamp_qdot(qdot);
        q = q + qdot * dt;    
        
        Tcurr = robot.getTransform(q, endEffectorName);
        
        qs(i+1,:) = q';
        q_dot_array(i,:) = qdot;
        qx_dot_array(i,:) = qx_dot;
        qo_dot_array(i,:) = qo_dot;
        ql_dot_array(i,:) = ql_dot;
        qnull_dot_array(i,:) = qnull_dot;
        lambdas(i) = l;
    end
    
    q_dots.q_dot = q_dot_array;
    q_dots.qx_dot = qx_dot_array;
    q_dots.qo_dot = qo_dot_array;
    q_dots.ql_dot = ql_dot_array;
    q_dots.qnull_dot = qnull_dot_array;
    
end