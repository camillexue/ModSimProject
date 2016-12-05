function res = rotatingderiv(t, E)
Cd = 0.3;
ro = 1.225;
klength = .32; %m average length
mass = .35; %kg mass based on 11g per cm density
gravity = 9.8; %m/s^2
A = .32; %cross sectional area cutting through air

Vx = E(3);
Vy = E(4);
W = E(5);


F_g = -mass * gravity;
F_d_x = -(0.5) .* Cd .* ro .* A .* Vx ./ sqrt(Vx.^2 + Vy.^2);
F_d_y = -(0.5) .* Cd .* ro .* A .* Vy ./ sqrt(Vx.^2 + Vy.^2);

F_x = F_d_x;
F_y = F_g + F_d_y;

dxdt = Vx;
dydt = Vy;
dVxdt = F_x ./ mass;
dVydt = F_y ./ mass;
dthetadt = W;
dWdt = 0;

res = [dxdt; dydt; dVxdt; dVydt; dWdt; dthetadt];
end