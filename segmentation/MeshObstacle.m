classdef MeshObstacle < Obstacle
    
    properties
        center
        colMesh
        Property1
    end
    
    methods
        function obj = MeshObstacle(collisionMesh)
            obj.colMesh = collisionMesh;
            obj.center = transl(collisionMesh.Pose);
        end
        
        function [np, d] = nearestPoint(obj, p)
%             dummySideLength = 0.0001;
%             dummyBox = collisionBox(dummySideLength,dummySideLength,dummySideLength);
%             dummyBox.Pose = transl(p);
            
            dummyRadius = 0.0001;
            dummySphere = collisionSphere(dummyRadius);
            dummySphere.Pose = transl(p);
            
            [~, sepdist, wp] = checkCollision(obj.colMesh, dummySphere);
            
            np = wp(:,1);
            d = sepdist;   
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

