sample_sizes = [1e3, 1e4, 1e6];

for i = 1:length(sample_sizes)
    XX = rand(sample_sizes(i), 1);
    [count_number, center_pos] = hist(XX, 20);
    bar(center_pos, count_number / (sample_sizes(i) * (center_pos(2) - center_pos(1))));
    title(['Histogram for ', num2str(sample_sizes(i)), ' Samples']);
    xlabel('x');
    ylabel('Density');
    hold on;
    plot([0 1], [1 1], 'r--', 'LineWidth', 2);
    legend('Histogram', 'True PDF');
    hold off;
    pause;
end
