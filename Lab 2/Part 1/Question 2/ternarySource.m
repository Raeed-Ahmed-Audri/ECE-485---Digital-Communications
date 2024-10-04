p = 0:0.01:1;   
q = 0:0.01:1;   

[P, Q] = meshgrid(p, q);
R = 1 - P - Q;

% Avoid invalid values (when p + q > 1 or any probability is negative)
valid = (P >= 0 & Q >= 0 & R >= 0);
H_ternary = zeros(size(P));

% Calculate entropy only for valid values of P, Q, and R
H_ternary(valid) = -P(valid) .* log2(P(valid)) - Q(valid) .* log2(Q(valid)) - R(valid) .* log2(R(valid));

% Handle log(0) by setting those terms to zero (log(0) is undefined but should be treated as 0)
H_ternary(isnan(H_ternary)) = 0;

% Find the maximum value of the entropy and its corresponding indices
[max_entropy, max_index] = max(H_ternary(:));

% Get the corresponding values of p and q for the maximum entropy
[max_p, max_q] = ind2sub(size(H_ternary), max_index);
p_max = P(max_p, max_q);
q_max = Q(max_p, max_q);
r_max = 1 - p_max - q_max;

% Plot the entropy surface
figure;
surf(P, Q, H_ternary);
title('Entropy of a Ternary Source');
xlabel('Probability p');
ylabel('Probability q');
zlabel('Entropy H(X)');
grid on;


str = ['Max Entropy = ', num2str(max_entropy), newline, 'p = ', num2str(p_max), ...
       newline, 'q = ', num2str(q_max), newline, 'r = ', num2str(r_max)];
annotation('textbox', [0.15, 0.75, 0.3, 0.1], 'String', str, 'FitBoxToText', 'on', 'BackgroundColor', 'w');



