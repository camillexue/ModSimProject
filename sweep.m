clf
V_o = 10:1:14; %m/s
W_o = 10:.1:15;

num_linear = length(V_o);
num_angular = length(W_o);
hit = zeros(num_linear, num_angular);

for row = 1:num_linear
    for column = 1:num_angular
        hit(row, column) = test(V_o(row), W_o(column));
    end
end

mymap = [.8,0,0;0,.8,0];
pcolor(W_o, V_o, hit)
colormap(mymap);
xlabel('Linear Velocity');
ylabel('Angular Velocity');
title('Throwing Velocity and Throwing Success');

hold on