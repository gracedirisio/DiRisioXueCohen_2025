%% Generates Figure S10: 
% lag correlations for same sequence reveals

%% load data
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'S10', filesep);
load([dataPath,'data.mat']);  %'data' structure

%%
% inits
c_stereo = [0 0 1];
c = [1 0 0];
lags=data.lags;
mean_lag_stereo=data.lag_stereo;
sem_lag_stereo=data.sem_stereo;
mean_lag_rand=data.lag_rand;
sem_lag_rand=data.sem_rand;



%plot lag correlation
figure; hold on;
% Plot shaded CI (stereo / same sequence)
fill([lags fliplr(lags)], ...
     [mean_lag_stereo + sem_lag_stereo; flipud(mean_lag_stereo - sem_lag_stereo)]', ...
     c_stereo, 'FaceAlpha', 0.2, 'EdgeColor', 'none');

%random sequence
fill([lags fliplr(lags)], ...
     [mean_lag_rand + sem_lag_rand; flipud(mean_lag_rand - sem_lag_rand)]', ...
     c_rand, 'FaceAlpha', 0.2, 'EdgeColor', 'none');

% Mean lines
plot(lags, mean_lag_stereo, '-', 'Color', c_stereo, 'LineWidth', 2);
plot(lags, mean_lag_rand, '-', 'Color', c_rand, 'LineWidth', 2);

legend('same sequence', 'random sequence');
xline(0)
yline(0)
ylim([-.03, .03])
xlim([-16 16])
xlabel('lag')
ylabel('mean correlation difference along diagonal')
legend()