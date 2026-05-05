function []=make_Fig4b(data)
green = [0.4660, 0.6740, 0.1880];
black=[0 0 0];

% Flatten to vectors
errorVec   = data.errorCounts(:);
correctVec = data.correctCounts(:);

% X positions for each violin
xCorrect = -0.25;
xError   =  0.25;
violinWidth = 0.2;  % max half-width of each violin

figure;
hold on;

% --- Violin for correct trials (green, LEFT) ---
[f2, xi2] = ksdensity(correctVec, 'BandWidth', 0.3);
f2_norm = f2 / max(f2) * violinWidth;
fill(xCorrect + [f2_norm, -fliplr(f2_norm)], ...
     [xi2, fliplr(xi2)], green, ...
     'EdgeColor', 'none', 'FaceAlpha', 0.8);

% --- Violin for error trials (black, RIGHT) ---
[f1, xi1] = ksdensity(errorVec, 'BandWidth', 0.3);
f1_norm = f1 / max(f1) * violinWidth;
fill(xError + [f1_norm, -fliplr(f1_norm)], ...
     [xi1, fliplr(xi1)], black, ...
     'EdgeColor', 'none', 'FaceAlpha', 0.8);

% --- Median lines ---
medianHalfWidth = 0.06;
plot(xCorrect + [-medianHalfWidth, medianHalfWidth], ...
     [nanmedian(correctVec), nanmedian(correctVec)], ...
     'w', 'LineWidth', 2);
plot(xError + [-medianHalfWidth, medianHalfWidth], ...
     [nanmedian(errorVec), nanmedian(errorVec)], ...
     'w', 'LineWidth', 2);


yline(2)

% Formatting
box off;
axis square;
ylabel('Count');
xticks([xCorrect, xError]);
xticklabels({'Correct', 'Error'});
xlim([-0.55 0.55]);
ylim([-4 5]);
yticks(-4:1:5);
hold off;


end