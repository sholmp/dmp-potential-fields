classdef BoundingSphere < Obstacle
    properties
        center %Center of sphere
        radius %Radius of sphere
        colMesh
    end
    
    methods
        function obj = BoundingSphere(center, radius)
            if isequal(size(center), [1 3])
                center = center';
                radius = radius';
            end
            obj.center = center;
            obj.radius = radius;
            
            obj.colMesh = collisionSphere(radius)
            obj.colMesh.Pose = transl(center);
            
        end
        
        % Output: 
        % d: Distance measured from sphere surface
        function [np, d] = nearestPoint(obj, p)
            assert( isequal(size(p), [3 1]), 'p must be 3x1')
            c = obj.center; r = obj.radius;
            cp = p - c;
            d = norm(cp) - r; 
            np = c + (cp / norm(cp)) * r;
        end
    end
    
end

