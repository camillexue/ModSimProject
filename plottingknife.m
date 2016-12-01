function res = plottingknife()
clf
x_o = 0;
y_o = 1.7;
Vx_o = 0;
Vy_o = 0;
W_o = 0;
theta_o = 32.*pi./180;
length = .32; %m average length
r = length*.25; %assuming cm is a fourth of the way in from handle
target = 6;

E_o = [x_o; y_o; Vx_o; Vy_o; W_o; theta_o];

options = odeset('Events', @events, 'RelTol', 1e-4);
[T, E] = ode45(@rotatingderiv, [0:0.01:10], E_o, options);
X = E(:,1);
Y = E(:,2);
theta = E(:,6);
tx = (length-r) * cos(theta) + X;
ty = (length-r) * sin(theta) + Y;
hx = X - (r) * cos(theta);
hy = Y - (r) * sin(theta);

function [value,isterminal,direction] = events(~, E)
    X = E(1);
    theta = E(6);
    tx = (length-r) * cos(theta) + X;
    hx = (r) * cos(theta) + X;
    value = [tx-target; hx-target];
    isterminal = [1;1];
    direction = [1;1];
end

hold on
plot(X, Y, 'g');
plot(tx, ty, 'r');
plot(hx, hy, 'b');
line([target, target + .01], [0.6, 1.7]);
xlabel('horizontal position (m)')
ylabel('vertical position (m)')
title('vertical position v. horizontal position')

end