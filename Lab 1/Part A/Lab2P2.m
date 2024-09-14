sample_sizes = [1e3, 1e4, 1e6];
center_pos = -4.8:0.1:4.8;
x_values = -4.8:0.01:4.8; %True PDF for the normal distribution
true_pdf = normpdf(x_values, 0, 1); %Standard Gaussian PDF

for i = 1:length(sample_sizes)
    YY = randn(sample_sizes(i), 1);
    count_number = hist(YY, center_pos);
    bar(center_pos, count_number / (sample_sizes(i) * (center_pos(2) - center_pos(1))));
    title(['Histogram for ', num2str(sample_sizes(i)), ' Samples']);
    xlabel('x');
    ylabel('Density');
    hold on;
    plot(x_values, true_pdf, 'r--', 'LineWidth', 2); %Standard normal distribution
    legend('Histogram', 'True PDF');
    hold off;
    pause;
end
