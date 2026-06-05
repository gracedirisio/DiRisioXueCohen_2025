function[p_firing]=make_Fig4c(data)



figure; hold on
plot(data.Error,data.Correct,'d','MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', ...
        'MarkerSize', 10);

% Plot formatting
plot([0 .1], [0 .1], '-', 'LineWidth', 3, 'Color', 'k', 'DisplayName', 'Unity line');
xlabel('error');
ylabel('correct');
title('Proportion zscore firing > 2, Correct v Error (both monkeys)');
ylim([0 .1]);
xlim([0 .1]);
xticks(0:0.05:0.1);
yticks(0:0.05:0.1);
axis square;
set(gca, 'LineWidth', 2);
box off;
legend('Location', 'northwest');
legend boxoff;
set(gca, 'TickDir', 'out');

p_firing = ranksum(data.Correct, data.Error, 'tail', 'right');


end