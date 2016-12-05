clf
V_o = 5:.5:20; %m/s
W_o = 5:.5:20;

num_linear = length(V_o);
num_angular = length(W_o);
hit = zeros(num_linear, num_angular);

for row = 1:num_linear
    for column = 1:num_angular
        hit(row, column) = test(V_o(row), W_o(column));
    end
end

mymap = [0,0,1;1,1,0;1,0,0;0,.8,0];
pcolor(W_o, V_o, hit)
colormap(mymap);
xlabel('Angular Velocity');
ylabel('Linear Velocity');
title('Throwing Velocity and Throwing Success');
colorbar

hold on