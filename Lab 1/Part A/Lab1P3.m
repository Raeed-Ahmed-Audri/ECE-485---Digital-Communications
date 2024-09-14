% Number of samples
n_samples = 1e4;


x = rand(n_samples, 1);
X = (x > 0.5) * 2 - 1;

% Case 1: Sigma^2 = 1
sigma1 = sqrt(1);
N1 = randn(n_samples, 1) * sigma1;
Y1 = X + N1;

% Case 2: Sigma^2 = 5
sigma2 = sqrt(5);
N2 = randn(n_samples, 1) * sigma2;
Y2 = X + N2;


figure;
subplot(2,1,1);
histogram(Y1, 'Normalization', 'pdf');
title('PDF of Y (sigma^2 = 1)');
xlabel('Y');
ylabel('Density');

subplot(2,1,2);
histogram(Y2, 'Normalization', 'pdf');
title('PDF of Y (sigma^2 = 5)');
xlabel('Y');
ylabel('Density');

% Compute probability of X = 1 and X = -1 given -0.5 < Y < -0.4 for sigma^2 = 1
interval = (-0.5 < Y1) & (Y1 < -0.4);
prob_X1_given_Y_interval = sum(X(interval) == 1) / sum(interval);
prob_Xm1_given_Y_interval = sum(X(interval) == -1) / sum(interval);

disp(['P(X = 1 | -0.5 < Y < -0.4, sigma^2 = 1) = ', num2str(prob_X1_given_Y_interval)]);
disp(['P(X = -1 | -0.5 < Y < -0.4, sigma^2 = 1) = ', num2str(prob_Xm1_given_Y_interval)]);

if prob_X1_given_Y_interval > prob_Xm1_given_Y_interval
    disp('X = 1 is more likely in the interval -0.5 < Y < -0.4 (sigma^2 = 1).');
else
    disp('X = -1 is more likely in the interval -0.5 < Y < -0.4 (sigma^2 = 1).');
end
