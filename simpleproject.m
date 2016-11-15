function res = simpleproject(~, E)
Cd = 0.3;
ro = 1.225;
mass = 
velocity = 
gravity = 9.8;

x = E(1);
y = E(2);
Vx = E(3);
Vy = E(4);

F_g = -mass * gravity;
F_d_x = -(0.5) .* Cd .* ro .* A .* Vx ./ sqrt(Vx.^2 + Vy.^2);
F_d_y = -(0.5) .* Cd .* ro .* A .* Vy ./ sqrt(Vx.^2 + Vy.^2);

F_x = F_g + F_d_x;
F_y = F_g + F_d_y;

dxdt = Vx;
dydt = Vy;
dVxdt = F_x ./ mass;
dVydt = F_y ./ mass;

res = [dxdt; dydt; dVxdt; dVydt];
% HI maggie