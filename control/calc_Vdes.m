%Calculates the desired spatial velocity given a current and a desired pose

function Vdes = calc_qx_dot(T_current, T_desired, dt)

    Vdes = tr2delta(T_current, T_desired);% / dt; %Makes spatial vector V: [vx,vy,vz wx,wy,wx, 
    Vdes = [Vdes(4:6); Vdes(1:3)]; % But geometric jacobian is [dw/dq1; dv/dq1]
    
%      Rot = [T_current(1:3,1:3) zeros(3,3);
%         zeros(3,3) T_current(1:3,1:3)];
%     
%     Vdes = Rot * Vdes;
    
end