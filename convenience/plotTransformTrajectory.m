function plotHandle = plotTransformTrajectory(Ts,varargin)
    hold on
    xyz = transl(Ts);
    plotHandle = plot3(xyz(:,1), xyz(:,2), xyz(:,3),varargin{:});
    if ~isa(Ts(1), 'SE3')
        Ts = SE3(Ts);
    end

%     trplot(Ts(1), 'length', 0.1, 'thick', 3, 'rgb')
%     trplot(Ts(round(0.25*length(Ts))), 'length', 0.1, 'thick', 3, 'rgb')
%     trplot(Ts(round(0.50*length(Ts))), 'length', 0.1, 'thick', 3, 'rgb')
%     trplot(Ts(round(0.75*length(Ts))), 'length', 0.1, 'thick', 3, 'rgb')
%     trplot(Ts(end), 'length', 0.1, 'thick', 3, 'rgb')
%     
%     trplot(Ts(1), 'length', 0.1, 'thick', 3, 'rgb')
%     trplot(Ts(round(0.20*length(Ts))), 'length', 0.1, 'thick', 3, 'rgb')
%     trplot(Ts(round(0.40*length(Ts))), 'length', 0.1, 'thick', 3, 'rgb')
%     trplot(Ts(round(0.60*length(Ts))), 'length', 0.1, 'thick', 3, 'rgb')
%     trplot(Ts(round(0.80*length(Ts))), 'length', 0.1, 'thick', 3, 'rgb')
%     trplot(Ts(end), 'frame', 'END','length', 0.1, 'thick', 3, 'rgb')
end

