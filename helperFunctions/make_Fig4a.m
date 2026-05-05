function []=make_Fig4a(data)
errorCounts=data.errorCounts;
correctCounts=data.correctCounts;

errorCounts = errorCounts(~isnan(errorCounts));
correctCounts = correctCounts(~isnan(correctCounts));

% Color mapping
black = [0 0 0];
green = [0.4660, 0.6740, 0.1880];

groups     = {correctCounts,errorCounts};
xPositions = [1, 2];
colors     = {green,black};

%% Plot for 4a
bAw=figure;
hold on;

boxWidth    = 0.08;  % half-width of IQR box
whiskerCap  = 0.05;  % half-width of whisker cap
jitterWidth = 0.15;  % spread of scatter points

for i = 1:numel(groups)
    data  = groups{i};
    x     = xPositions(i);
    col   = colors{i};

    %% --- Jittered scatter ---
    jitter = (rand(size(data)) - 0.5) * 2 * jitterWidth;
    scatter(x + jitter, data, 20, col, 'filled', ...
            'MarkerFaceAlpha', 0.6, 'MarkerEdgeAlpha', 0);

    %% --- Box and whisker stats ---
    q1      = quantile(data, 0.25);
    med     = median(data);
    q3      = quantile(data, 0.75);
    iqr_val = q3 - q1;

    lower_fence  = q1  - 1.5 * iqr_val;
    upper_fence  = q3  + 1.5 * iqr_val;
    whisker_low  = min(data(data >= lower_fence));
    whisker_high = max(data(data <= upper_fence));

    % Outliers
    outliers = data(data < lower_fence | data > upper_fence);
    if ~isempty(outliers)
        scatter(repmat(x, size(outliers)), outliers, 30, col, ...
                'filled', 'MarkerFaceAlpha', 0.8);
    end

    % IQR box
    rectangle('Position', [x - boxWidth, q1, 2*boxWidth, iqr_val], ...
              'FaceColor', 'none', 'EdgeColor', col, 'LineWidth', 2);

    % Median line
    line([x - boxWidth, x + boxWidth], [med, med], ...
         'Color', col, 'LineWidth', 2.5);

    % Whisker lines
    line([x, x], [q3, whisker_high], 'Color', col, 'LineWidth', 1.8);
    line([x, x], [q1, whisker_low],  'Color', col, 'LineWidth', 1.8);

    % Whisker caps
    line([x - whiskerCap, x + whiskerCap], [whisker_high, whisker_high], ...
         'Color', col, 'LineWidth', 1.8);
    line([x - whiskerCap, x + whiskerCap], [whisker_low,  whisker_low],  ...
         'Color', col, 'LineWidth', 1.8);
end

%% Formatting
xticks([1 2]);
xticklabels({'Correct','Error'});
ylabel('z scored firing rate');
xlim([0.5 2.5]);
ylim([-3 5]);
box off;
axis square;

end