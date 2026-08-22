%% Generates Figure S4: 
% sparsity and kurtosis distributions
%% load data
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'S4', filesep);

load([dataPath,'skew_data.mat']);  %'data' structure
kurt=load([dataPath,'kurt_data.mat']);  %'data' structure

%% skewness

all_correct_skewness_combined= data.Correct;
all_error_skewness_combined= data.Error;


binEdges = -3:0.1:5;

figure; hold on;
histogram(all_correct_skewness_combined, 'BinEdges', binEdges, ...
    'FaceColor',[0.4660, 0.6740, 0.1880],'EdgeColor','none', 'DisplayName', 'Correct Trials');

histogram(all_error_skewness_combined, 'BinEdges', binEdges, ...
    'FaceColor', 'k','EdgeColor','none', 'DisplayName', 'Error Trials');

xline(0, '--', 'LineWidth', 2, 'Color', [0.5 0.5 0.5], 'DisplayName', 'Zero Skewness');
xlabel('Skewness');
ylabel('Frequency');
title('Skewness, Correct v Error Trials (both monkeys)');
legend('Location', 'northwest');
legend boxoff;
legend off
xlim([-2, 5]);
xticks(-2:1:5);
set(gca, 'LineWidth', 2);
box off;
axis square;
set(gca,'TickDir','out')
axis square
hold off;

[p, h, stats]=ranksum(all_correct_skewness_combined,all_error_skewness_combined)

%% kurtosis
all_correct_kurt_combined= kurt.data.Correct;
all_error_kurt_combined= kurt.data.Error;


figure; hold on;
binEdges = -2:0.2:10;
histogram(all_correct_kurt_combined, ...
    'BinEdges', binEdges,'EdgeColor','none', 'FaceColor', [0.4660, 0.6740, 0.1880], ...
     'DisplayName', 'Correct Trials');

histogram(all_error_kurt_combined, ...
    'BinEdges', binEdges, 'EdgeColor','none','FaceColor', 'k', ...
     'DisplayName', 'Error Trials');


xlabel('Kurtosis');
ylabel('Frequency');
title('Kurtosis, Correct v Error Trials (combining many sessions)');
legend('Location', 'northeast');
legend boxoff;
legend off
xlim([0, 10]);
xticks(0:2:10);
set(gca, 'LineWidth', 2);
set(gca, 'TickDir', 'out');
axis square
box off;
hold off;

[p_kurt_combined, h, stat_k] = ranksum(all_correct_kurt_combined, all_error_kurt_combined);
