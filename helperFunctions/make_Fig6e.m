function []=make_Fig6e(data)
%make lag correlation plots


lags=data.lags;
mean_lag_correct=data.MeanLag_Correct;
mean_lag_error=data.MeanLag_Error;
sem_lag_correct=data.semLag_correct;
sem_lag_error=data.semLag_error;

figure; hold on;

% Colors
c_correct = [0.4660, 0.6740, 0.1880]; %green, correct
c_error = [0 0 0]; %error

% Plot shaded CI (correct)
fill([lags fliplr(lags)], ...
     [mean_lag_correct + sem_lag_correct; flipud(mean_lag_correct - sem_lag_correct)]', ...
     c_correct, 'FaceAlpha', 0.2, 'EdgeColor', 'none');

% Plot shaded CI (error)
fill([lags fliplr(lags)], ...
     [mean_lag_error + sem_lag_error; flipud(mean_lag_error - sem_lag_error)]', ...
     c_error, 'FaceAlpha', 0.2, 'EdgeColor', 'none');

% Mean lines
plot(lags, mean_lag_correct, '-', 'Color', c_correct, 'LineWidth', 2);
plot(lags, mean_lag_error, '-', 'Color', c_error, 'LineWidth', 2);


% Axes formatting
xline(0, 'k-','LineWidth',3);
yline(0, 'k-','LineWidth',3);
xlim([-16 16])
xlabel('Lag, pres 1 frag j - pres 2 frag i');
ylabel('Mean correlation');
legend('Correct', 'Error');
title('Lag Correlation Across Sessions');
grid on;
axis square



end