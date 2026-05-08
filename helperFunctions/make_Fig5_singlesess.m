function []=make_Fig5_singlesess(data)

show_points = false;  % <-- toggle individual data points on/off

%no nback
correct=data.correct;
error=data.incorrect;
correct_low=data.correct_low;
error_low=data.incorrect_low;
correct_high=data.correct_high;
error_high=data.incorrect_high;

% Define colors
correct_color = [0.466, 0.674, 0.188];
error_color   = [0, 0, 0];
low_color     = [245/256, 132/256, 38/256];
high_color    = [0, 107/256, 182/256];
jitter_amount = 0.08;
jw = 0.1;

%% ---- Figure 1: Correct vs Error (no n-back) ----
figure;
hold on;

all_data_1   = [correct(:); error(:)];
group_labels = [ones(numel(correct),1); 2*ones(numel(error),1)];

h = boxplot(all_data_1, group_labels, ...
    'Labels', {'Correct', 'Error'}, ...
    'Colors', [correct_color; error_color], ...
    'Symbol', '', ...
    'Widths', 0.5);
set(h, 'LineWidth', 1.5);

bp_boxes = findobj(gca, 'Tag', 'Box');
patch(get(bp_boxes(1), 'XData'), get(bp_boxes(1), 'YData'), ...
    error_color,   'FaceAlpha', 0.15, 'EdgeColor', error_color,   'LineWidth', 1.5);
patch(get(bp_boxes(2), 'XData'), get(bp_boxes(2), 'YData'), ...
    correct_color, 'FaceAlpha', 0.15, 'EdgeColor', correct_color, 'LineWidth', 1.5);

if show_points
    jitter_c = (rand(numel(correct), 1) - 0.5) * 2 * jitter_amount;
    jitter_e = (rand(numel(error),   1) - 0.5) * 2 * jitter_amount;
    scatter(1 + jitter_c, correct(:), 20, correct_color, 'filled', ...
        'MarkerFaceAlpha', 0.4, 'MarkerEdgeColor', 'none');
    scatter(2 + jitter_e, error(:),   20, error_color,   'filled', ...
        'MarkerFaceAlpha', 0.4, 'MarkerEdgeColor', 'none');
end

ylabel('population correlation');
title('Fig 5b: Correct vs Error (all trials)');
box off;
hold off;

%% ---- Figure 2: Low N-back (correct vs error) ----
figure;
hold on;

all_low = [correct_low(:); error_low(:)];
grp_low = [ones(numel(correct_low),1); 2*ones(numel(error_low),1)];

h_low = boxplot(all_low, grp_low, ...
    'Labels', {'Correct', 'Error'}, ...
    'Colors', low_color, ...
    'Symbol', '', ...
    'Widths', 0.5);
set(h_low, 'LineWidth', 1.5);

bp_low = findobj(gca, 'Tag', 'Box');
for k = 1:numel(bp_low)
    patch(get(bp_low(k), 'XData'), get(bp_low(k), 'YData'), ...
        low_color, 'FaceAlpha', 0.15, 'EdgeColor', low_color, 'LineWidth', 1.5);
end

if show_points
    jitter_cl = (rand(numel(correct_low), 1)-0.5)*2*jw;
    jitter_el = (rand(numel(error_low),   1)-0.5)*2*jw;
    scatter(1 + jitter_cl, correct_low(:), 20, low_color, 'filled', ...
        'MarkerFaceAlpha', 0.4, 'MarkerEdgeColor', 'none');
    scatter(2 + jitter_el, error_low(:),   20, low_color, 'filled', ...
        'MarkerFaceAlpha', 0.4, 'MarkerEdgeColor', 'none');
end

xlim([0.4 2.6]);
ylabel('population correlation');
title('Fig 5d: Low N-back');
box off;
hold off;

%% ---- Figure 3: High N-back (correct vs error) ----
figure;
hold on;

all_high = [correct_high(:); error_high(:)];
grp_high = [ones(numel(correct_high),1); 2*ones(numel(error_high),1)];

h_high = boxplot(all_high, grp_high, ...
    'Labels', {'Correct', 'Error'}, ...
    'Colors', high_color, ...
    'Symbol', '', ...
    'Widths', 0.5);
set(h_high, 'LineWidth', 1.5);

bp_high = findobj(gca, 'Tag', 'Box');
for k = 1:numel(bp_high)
    patch(get(bp_high(k), 'XData'), get(bp_high(k), 'YData'), ...
        high_color, 'FaceAlpha', 0.15, 'EdgeColor', high_color, 'LineWidth', 1.5);
end

if show_points
    jitter_ch = (rand(numel(correct_high), 1)-0.5)*2*jw;
    jitter_eh = (rand(numel(error_high),   1)-0.5)*2*jw;
    scatter(1 + jitter_ch, correct_high(:), 20, high_color, 'filled', ...
        'MarkerFaceAlpha', 0.4, 'MarkerEdgeColor', 'none');
    scatter(2 + jitter_eh, error_high(:),   20, high_color, 'filled', ...
        'MarkerFaceAlpha', 0.4, 'MarkerEdgeColor', 'none');
end

xlim([0.4 2.6]);
ylabel('population correlation');
title('Figure 5d: High N-back');
box off;
hold off;

end