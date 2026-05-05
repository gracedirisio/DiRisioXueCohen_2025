function[stat_results]=make_Fig4c(data_m1, data_m2)

monkeys = {'z', 'h'};
markers = {'^', 'o'};  % z = triangle, h = circle

Z_correct=[data_m1.PropFiringCorrect{:}];
Z_error=[data_m1.PropFiringError{:}];

H_correct=[data_m2.PropFiringCorrect{:}];
H_error=[data_m2.PropFiringError{:}];

% Perform rank-sum test (correct > error)
p = ranksum(Z_correct, Z_error, 'tail', 'right');
stat_results.(data_m1.FileName{1}).p = p;

p = ranksum(H_correct, H_error, 'tail', 'right');
stat_results.(data_m2.FileName{1}).p = p;


figure; hold on
plot(Z_error,Z_correct, markers{1},'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', ...
        'MarkerSize', 10, 'DisplayName', data_m1.FileName{1});
plot(H_error,H_correct, markers{2},'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', ...
        'MarkerSize', 10, 'DisplayName', data_m2.FileName{1});
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

end