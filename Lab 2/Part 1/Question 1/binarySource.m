% Define the range of probabilities p for the binary source
p = 0:0.01:1;  % Probabilities from 0 to 1 in steps of 0.01

% Calculate entropy for the binary source
H_binary = -p .* log2(p) - (1 - p) .* log2(1 - p);

% Handle the case when p = 0 or p = 1 
H_binary(isnan(H_binary)) = 0;

% Find the maximum value of the entropy and corresponding probability p
[max_entropy, max_index] = max(H_binary);
p_max = p(max_index);

% Plot the entropy curve
figure;
plot(p, H_binary, 'LineWidth', 2);
title('Entropy of a Binary Source');
xlabel('Probability p');
ylabel('Entropy H(X)');
grid on;

str = ['Max Entropy = ', num2str(max_entropy), newline, 'at p = ', num2str(p_max)];
annotation('textbox', [0.15, 0.75, 0.3, 0.1], 'String', str, 'FitBoxToText', 'on', 'BackgroundColor', 'w');

