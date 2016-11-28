function res = plottingknife()
clf
x_o = 0;
y_o = 1.7;
Vx_o = 0;
Vy_o = 0;
W_o = 0;
theta_o = 0;
length = .32; %m average length
r = .08; %assuming cm is a third of the way in from handle

E_o = [x_o; y_o; Vx_o; Vy_o; W_o; theta_o];

options = odeset('Events', @events, 'RelTol', 1e-4);

function [value,isterminal,direction] = events(~, E)
    Y = E(2);
   
    value = Y - 0;
    isterminal = 1;
    direction = -1;
end

[T, E] = ode45(@rotatingderiv, [0:0.01:10], E_o, options);
X = E(:,1);
Y = E(:,2);
theta = E(:,6);
tx = (length-r) * cos(theta) + X;
ty = (length-r) * sin(theta) + Y;

hold on
plot(X, Y, 'g');
plot(tx, ty, 'r');
line([6, 6.01], [0.6, 1.7]);
xlabel('horizontal position (m)')
ylabel('vertical position (m)')
title('vertical position v. horizontal position')
end