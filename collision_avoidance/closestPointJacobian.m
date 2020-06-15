%input:
%x_link - closest point on robot link

function JD = closestPointJacobian(robot, q, x_link, closest_link_name)

    pose_closest_link = robot.getTransform(q, closest_link_name); %Pose of closest link frame
    t = pose_closest_link(1:3,4);                                %3D position of closest link
    
    dummyBody = rigidBody('dummyBody');
    dummyJoint = rigidBodyJoint('dummyJoint', 'fixed');
    dummyJoint.setFixedTransform(transl(x_link-t)); 
    dummyBody.Joint = dummyJoint;
    
    dummyRobot = copy(robot);
    dummyRobot.addBody(dummyBody, closest_link_name);   
    
    JD = dummyRobot.geometricJacobian(q, 'dummyBody');
%     JD = JD(4:6,:);

end