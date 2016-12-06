function res = plottingknife()
clf
x_o = 0;
y_o = 1.7;
V_o = 11;
theta_o = 10.*pi./180;
Vx_o = V_o * cos(theta_o);
Vy_o = V_o * sin(theta_o);
W_o = 15;
theta_o = 35.*pi./180;
klength = .32; %m average length
r = klength*.25; %assuming cm is a fourth of the way in from handle
target = 4;

E_o = [x_o; y_o; Vx_o; Vy_o; W_o; theta_o];

options = odeset('Events', @events, 'RelTol', 1e-4);
[T, E] = ode45(@rotatingderiv, [0:0.01:10], E_o, options);
X = E(:,1);
Y = E(:,2);
theta = E(:,6);
tx = (klength-r) * cos(theta) + X;
ty = (klength-r) * sin(theta) + Y;
hx = X - (r) * cos(theta);
hy = Y - (r) * sin(theta);

function [value,isterminal,direction] = events(~, E)
    X = E(1);
    Y = E(2);
    theta = E(6);
    ty = (klength-r) * sin(theta) + Y;
    tx = (klength-r) * cos(theta) + X;
    hx = (r) * cos(theta) + X;
    hy = Y - (r) * sin(theta);
    
    value = [tx-target; hx-target; ty; hy;];
    isterminal = [1;1;1;1];
    direction = [1;1;1;1];
end

hold on
plot(T, Y, 'g');
plot(T, ty, 'r');
plot(T, hy, 'b');
line([target, target + .01], [1.515, 1.676]);
xlabel('horizontal position (m)')
ylabel('vertical position (m)')
title('vertical position v. horizontal position')
end