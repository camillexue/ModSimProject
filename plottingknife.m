function res = plottingknife()
x_o = 0;
y_o = 1.7;
Vx_o = 0;
Vy_o = 0;
W_o = 0;

E_o = [x_o; y_o; Vx_o; Vy_o; W_o];

options = odeset('Events', @events, 'RelTol', 1e-4);

function [value,isterminal,direction] = events(~, E)
    Y = E(2);
   
    value = Y - 0;
    isterminal = 1;
    direction = -1;
end

[T, E] = ode45(@rotatingderiv, [0, 10], E_o, options);
X = E(:,1);
Y = E(:,2);

plot(X, Y);
line([8, 8.01], [0, 1]);
end