clf
klength = 20:0.1:40;
force = 20:0.1:50;

num_lengths = length(klength);
num_forces = klength(force);
theta_end = zeros(num_lengths, num_forces);

for row = 1:num_lengths
    for column = 1:num_forces
        theta_end(row, column) = test(klength(row), force(column));
    end
end

pcolor(force, klength, theta_end)
shading interp
colorbar

hold on