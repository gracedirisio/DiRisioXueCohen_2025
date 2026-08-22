%% Run script to generate supplemental figure S1 (behavior)

%% load data
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'S1', filesep);

load([dataPath,'data.mat']);  %'data' structure

%%

x_vals=data.x;
weighted_mean=data.weighted_mean;
weighted_sem=data.weighted_sem;
%  Plot ---
figure; hold on;

% Plot 0-back alone
errorbar(x_vals(1), weighted_mean(1), weighted_sem(1), '^-', ...
    'LineWidth',1.5,'MarkerSize',8,'Color',[0 0.4470 0.7410],'MarkerFaceColor',[0 0.4470 0.7410]); 

% Plot 1–16 back connected
idx = x_vals > 0; % everything except 0
errorbar(x_vals(idx), weighted_mean(idx), weighted_sem(idx), '-^', ...
    'LineWidth',1.5,'MarkerSize',8,'Color',[0 0.4470 0.7410],'MarkerFaceColor',[0 0.4470 0.7410]); 

xlabel('n-back');
ylabel('Accuracy');
title('Weighted average n-back performance across sessions');
grid off;
ylim([0 1]);
yline(0.5,'-k');
axis square


