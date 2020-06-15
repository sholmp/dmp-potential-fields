function plotCircle(x,y,r,varargin)

    theta = 0:0.01:2*pi;
    
    x = r*cos(theta);
    y = r*sin(theta);
    
    plot(x,y,varargin{:});
    
    
    

end