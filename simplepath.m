function res = simplepath(velocity, angle)
    theta = angle .* pi ./ 180; % convert to radians
    Vx = velocity .* cos(theta);
    Vy = velocity .* sin(theta);
    E = [0,1,Vx,Vy];
    
    [A,B] = ode45(@simpleproject, [0,100], E);
    x = B(:,1);
    y = B(:,2);
    Vx = B(:,3);
    Vy = B(:,4);
    
    clf
    hold on
    plot(x,y,'ro-');
end