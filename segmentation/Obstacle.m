classdef (Abstract) Obstacle
    
    properties (Abstract)
        center
        colMesh %Collision Mesh
    end
    
    methods (Abstract)
        nearestPoint(obj)
    end
    
end