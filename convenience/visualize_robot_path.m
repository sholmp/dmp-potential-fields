%input: qs is a MxN matrix, where M are the number of configurations and N
%are the number of joints

function visualize_robot_path(robot, qs, step, quivers, varargin)
   
    plot_quivers = false;
%     if exist('quivers', 'var')
%         plot_quivers = true;
%     end
    if ~isempty(quivers)
        plot_quivers = true;
    end
    
    for i = 1:step:size(qs, 1)
%         robot.show(qs(i,:)','PreservePlot', false, varargin);  
        robot.show(qs(i,:)', varargin{:}); 
        
%         Tcurr = robot.getTransform(qs(i,:)', endEffectorName)


%         robot.show(qs(i,:)'); 

%         showCollisionArray(robot, qs(i,:)');
        if plot_quivers
           head = quivers(i).head;
           tail = quivers(i).tail;
           vec = head - tail;
           quiver3(tail(1), tail(2), tail(3), vec(1), vec(2), vec(3), 0, 'LineWidth', 2.5, 'MaxHeadSize', 1);
        end
        drawnow;
    end
    robot.show(qs(end,:)', varargin{:});
%     robot.show(qs(end,:)'); 
    
end