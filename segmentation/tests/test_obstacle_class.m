%% Test bounding sphere
clc; clear;
sph = BoundingSphere([0,0.5,0]', 0.5)

p = [0 0 -2]';

[np, d] = sph.nearestPoint(p)

%% Test bounding box
clc; clear;
x = [0 1 0 1 0 1 0 1]';
y = [0 0 1 1 0 0 1 1]';
z = [0 0 0 0 1 1 1 1]';

[r, cp] = minboundbox(x,y,z);
% bb = BoundedBox(cp)
bb = BoundingBox(cp);

p = [-100 0.5 0.8];
[np, d] = bb.nearestPoint(p)

scatter3(x,y,z)
hold on
plotminbox(cp)
xlabel('x')
ylabel('y')
