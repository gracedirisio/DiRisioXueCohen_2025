%% Generates Figure S6: 
% : Population correlation distributions
%% load data
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'S6', filesep);

%inits
m1=load([dataPath,'data_m1.mat']);  %'data' structure
m2=load([dataPath,'data_m2.mat']);  %'data' structure
nback=load([dataPath,'data_nback.mat']);  %'data' structure

green=[0.4660, 0.6740, 0.1880];
gray=[.6 .6 .6];

%% monkey H response consistency plots

all_incorrect_m1=m1.data.incorrect;
all_correct_m1=m1.data.correct;

%incorrect
figure;
numBins = 10; % You can adjust this number as needed
binEdges = linspace(-.5, 1, numBins + 1);
h1 = histogram(all_incorrect_m1, 'BinEdges', binEdges, 'FaceColor', 'k');
box off
xline(.5,'-','LineWidth',1,'Color','k')
xlim([-.5,1])
medianValue = median(all_incorrect_m1);
xline(medianValue, 'r-', 'LineWidth', 4);
axis square
hold off

%correct
figure;
numBins = 10; % You can adjust this number as needed
binEdges = linspace(-.5, 1, numBins + 1);
h2 = histogram(all_correct_m1, 'BinEdges', binEdges, 'FaceColor', green);
box off
xline(.5,'-','LineWidth',1,'Color','k')
xlim([-.5,1])
medianValue = median(all_correct_m1);
xline(medianValue, 'r-', 'LineWidth', 4);
axis square
hold off

[p, h, stats] = ranksum(all_incorrect_m1, all_correct_m1);

%% monkey Z response consistency plots


all_incorrect_m2=m2.data.incorrect;
all_correct_m2=m2.data.correct;

%incorrect
figure;
numBins = 10; % You can adjust this number as needed
binEdges = linspace(-.5, 1, numBins + 1);
h1 = histogram(all_incorrect_m2, 'BinEdges', binEdges, 'FaceColor', 'k');
box off
xline(.5,'-','LineWidth',1,'Color','k')
xlim([-.5,1])
medianValue = median(all_incorrect_m2);
xline(medianValue, 'r-', 'LineWidth', 4);
axis square
hold off

%correct
figure;
numBins = 10; % You can adjust this number as needed
binEdges = linspace(-.5, 1, numBins + 1);
h2 = histogram(all_correct_m2, 'BinEdges', binEdges, 'FaceColor', green);
box off
xline(.5,'-','LineWidth',1,'Color','k')
xlim([-.5,1])
medianValue = median(all_correct_m2);
xline(medianValue, 'r-', 'LineWidth', 4);
axis square
hold off

[p2, h2, stat2] = ranksum(all_incorrect_m2, all_correct_m2);

%% nback

nback.data.correct_low
nback.data.incorrect_high
nback.data.incorrect_low
nback.data.correct_high
binEdges = -1:0.1:1;

% CORRECT
figure;
hold on;
histogram(nback.data.correct_high, 'BinEdges', binEdges,  ...
        'LineWidth', 2, 'FaceColor', green,'EdgeColor','none');

xline(0.5, '-', 'LineWidth', 2, 'Color', 'k')
xlabel('rvals')
title('Correct trials: high n-back (4,8,16), both monkeys')
xline(0.5, '-', 'LineWidth', 2, 'Color', 'k')
xlabel('rvals')
title('correct trials: high n-back (1,2), both monkeys')
xlim([-.5 1]); xticks(-1:.5:1); box off; axis square;

figure;
hold on;
histogram(nback.data.correct_low, 'BinEdges', binEdges,  ...
        'LineWidth', 2, 'FaceColor', green,'EdgeColor','none');

xline(0.5, '-', 'LineWidth', 2, 'Color', 'k')
xlabel('rvals')
title('Correct trials: low n-back (4,8,16), both monkeys')
xlim([-.5 1]); xticks(-1:.5:1); box off; axis square;



% error
figure;
hold on;
histogram(nback.data.incorrect_high, 'BinEdges', binEdges,  ...
        'LineWidth', 2, 'FaceColor', 'k','EdgeColor','none');

xline(0.5, '-', 'LineWidth', 2, 'Color', 'k')
xlabel('rvals')
title('error trials: high n-back (4,8,16), both monkeys')
xlim([-.5 1]); xticks(-1:.5:1); box off; axis square;


figure;
hold on;
histogram(nback.data.incorrect_low, 'BinEdges', binEdges,  ...
        'LineWidth', 2, 'FaceColor', 'k','EdgeColor','none');

xline(0.5, '-', 'LineWidth', 2, 'Color', 'k')
xlabel('rvals')
title('error trials: low n-back (4,8,16), both monkeys')
xlim([-.5 1]); xticks(-1:.5:1); box off; axis square;


%% Stats
[p_high, ~, stat_hi] = ranksum(nback.data.correct_high, nback.data.incorrect_high);

[p_low, ~, stat_lo] = ranksum(nback.data.correct_low, nback.data.incorrect_low);

