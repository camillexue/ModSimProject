function res = test(klength,force)
    clf
    x_o = 0;
    y_o = 1.7;
    Vx_o = 0;
    Vy_o = 0;
    W_o = 0;
    theta_o = 32.*pi./180;
    klength = .32; %m average length
    r = klength*.25; %assuming cm is a fourth of the way in from handle
    target = 6;

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
    angle = 35 * pi / 180; %assuming angle, convert to radians
    r = klength*0.25; %assuming cm is a third of the way in from handle
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
        F_a = force; %force applied, assumed based on data
    else 
        F_d_x = -(0.5) .* Cd .* ro .* A .* Vx ./ sqrt(Vx.^2 + Vy.^2)
        F_d_y = -(0.5) .* Cd .* ro .* A .* Vy ./ sqrt(Vx.^2 + Vy.^2)
        F_a = 0;
    end


    F_x = F_d_x + F_a * cos(angle) * sin(angle);
    F_y = F_g + F_d_y + F_a * cos(angle) * cos(angle);

    I = (1 / 12) * mass * klength^2; %moment of inertia of rod

    dxdt = Vx;
    dydt = Vy;
    dVxdt = F_x ./ mass;
    dVydt = F_y ./ mass;
    dWdt = r * F_a * sin(angle) ./ I;
    dthetadt = W;

    res = [dxdt; dydt; dVxdt; dVydt; dWdt; dthetadt];


    hold on
    plot(X, Y, 'g');
    plot(tx, ty, 'r');
    plot(hx, hy, 'b');
    line([target, target + .01], [0.6, 1.7]);
    xlabel('horizontal position (m)')
    ylabel('vertical position (m)')
    title('vertical position v. horizontal position')

end