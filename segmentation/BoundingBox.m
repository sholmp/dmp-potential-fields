classdef BoundingBox < Obstacle
    properties
        bps %list of BoundingPlane objects
        center
        cp      %Average of corner points (3x1)
        colMesh
    end
    
    methods
        %input cornerpoints from the function 'minboundbox'
        %Which is an 8x3 matrix with the 8 terminal points
        function obj = BoundingBox(cp)
            p1 = cp(1,:); p2 = cp(2,:); p3 = cp(3,:); p4 = cp(4,:);
            p5 = cp(5,:); p6 = cp(6,:); p7 = cp(7,:); p8 = cp(8,:);

            bp1 = BoundedPlane(p1, p2, p4);
            bp2 = BoundedPlane(p5, p6, p8);
            bp3 = BoundedPlane(p2, p6, p3);
            bp4 = BoundedPlane(p1, p5, p4);
            bp5 = BoundedPlane(p1, p2, p5);
            bp6 = BoundedPlane(p4, p3, p8);
            
            obj.bps = {bp1, bp2, bp3, bp4, bp5, bp6};
            obj.center = mean(cp)';
            obj.cp = cp;
            
            obj.colMesh = collisionMesh(cp);
        end
        
        % Output 
        % np: nearest point on the BoundingBox
        % d: distance between cp and p
        function [np, d] = nearestPoint(obj, p)
            if isequal(size(p), [1 3])
                p = p';
            end
            np = zeros(3,1);
            d = inf;
            
            for i = 1:length(obj.bps)
                [npi, di] = obj.bps{i}.nearestPoint(p);
                if di < d
                    np = npi;
                    d = di;
                end
            end
            
        end
    end
end