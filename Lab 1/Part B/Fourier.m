t = 0:0.001:2;

% Define the function f(t)
f = 0.5*(sign(t) - sign(t-0.5) - (sign(t-0.5) - sign(t-1)) + sign(t-1) - sign(t-1.5) - (sign(t-1.5) - sign(t-2)));

% Plot the original function f(t)
figure;
plot(t, f, 'LineWidth', 2);
axis([0 2 -2 2]);
title('Original function f(t)');
xlabel('t');
ylabel('f(t)');
grid on;

% Fourier approximation for different values of N
N_values = [1, 5, 20]; % N values to use for Fourier approximation

for i = 1:length(N_values)
    N = N_values(i);
    f_N = zeros(1, length(t));
    
    % Sum over n for the Fourier series approximation
    for n = 1:N
        f_N = f_N + 4*(-1)^(n+1) * sin(n*pi*(2*t)) * (sin(n*pi/2))^2 / (n*pi);
    end
    
    
    figure;
    plot(t, f_N, 'LineWidth', 2);
    axis([0 2 -2 2]);
    title(['Fourier Approximation f_N(t) for N = ', num2str(N)]);
    xlabel('t');
    ylabel(['f_N(t) for N = ', num2str(N)]);
    grid on;
end

