function res = rotatingderiv(t, E)
Cd = 0.3;
ro = 1.225;
length = .32; %m average length
mass = .35; %kg mass based on 11g per cm density
gravity = 9.8; %m/s^2
angle = 35 * pi / 180; %assuming angle, convert to radians
r = .08; %assuming cm is a third of the way in from handle
A = .32; %cross sectional area cutting through air

x = E(1);
y = E(2);
Vx = E(3);
Vy = E(4);
W = E(5);
theta = E(6)

F_g = -mass * gravity;

if t <= .1
    F_d_x = 0;
    F_d_y = 0;
    F_a = 35; %force applied, assumed based on data
else 
    F_d_x = -(0.5) .* Cd .* ro .* A .* Vx ./ sqrt(Vx.^2 + Vy.^2)
    F_d_y = -(0.5) .* Cd .* ro .* A .* Vy ./ sqrt(Vx.^2 + Vy.^2)
    F_a = 0;
end


F_x = F_d_x + F_a * cos(angle) * sin(angle);
F_y = F_g + F_d_y + F_a * cos(angle) * cos(angle);

I = (1 / 12) * mass * length^2; %moment of inertia of rod

dxdt = Vx;
dydt = Vy;
dVxdt = F_x ./ mass;
dVydt = F_y ./ mass;
dWdt = r * F_a * sin(angle) ./ I;
dthetadt = W;

res = [dxdt; dydt; dVxdt; dVydt; dWdt; dthetadt];
