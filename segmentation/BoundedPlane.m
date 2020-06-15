classdef BoundedPlane
    
    properties
        p1 
        A
    end
    
    methods
        %Input:
        % 3 column vectors representing 
        % three vertices of the bounded plane
        function obj = BoundedPlane(p1, p2, p3)
            if isequal(size(p1), [1 3])
                p1 = p1'; p2 = p2'; p3 = p3';
            end
            obj.p1 = p1;            
            obj.A = [p2-p1 p3-p1]; %Basis for the plane
        end
        
        % Input: 
        % p: 3D point
        % Output
        % np: nearest point on the bounded plane
        % d: distance between np and p
        function [np, d] = nearestPoint(obj, p)
            if isequal(size(p), [1 3])
                p = p';
            end
            A = obj.A;
            p1 = obj.p1;
            
            b = p - p1; 
            xhat = (A'*A) \ A' * b;
            
            uv = min([1;1], max([0;0], xhat)) ;
            
            np = p1 + A * uv;
            d = norm(p - np);
        end
        
    end
end     