function res = test(V_o, W_o)
    clf
    x_o = 0;
    y_o = 1.7;
    theta_o = 10.*pi./180;
    Vx_o = V_o * cos(theta_o);
    Vy_o = V_o * sin(theta_o);
    klength = .32; %m length of knife
    
    r = klength*.25; %assuming cm is a fourth of the way in from handle
    target = 6;

    E_o = [x_o; y_o; Vx_o; Vy_o; W_o; theta_o];

    options = odeset('Events', @events, 'RelTol', 1e-4);
    [T, E] = ode45(@rotatingderiv, [0:0.1:10], E_o, options);
    X = E(:,1);
    Y = E(:,2);
    theta = E(:,6);
    tx = (klength-r) * cos(theta) + X;
    ty = (klength-r) * sin(theta) + Y;
    hx = X - (r) * cos(theta);
    hy = Y - (r) * sin(theta);

    function [value,isterminal,direction] = events(~, E)
        X = E(1);
        theta = E(6);
        tx = (klength-r) * cos(theta) + X;
        hx = (r) * cos(theta) + X;
        value = [tx-target; hx-target];
        isterminal = [1;1];
        direction = [1;1];
    end

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
    if tx(end) > hx(end) && ty(end) >= .6 && ty(end) <= 1.7
        hit = 3;
    elseif ty(end) <= .6
        hit = 2;
    elseif ty(end) >= 1.7
        hit = 1;
    else
        hit = 0;
    end
    res = hit;
end


