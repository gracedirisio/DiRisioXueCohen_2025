%% Generates Figure S3: 
% RSI distributions
%% load data
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'S3', filesep);
load([dataPath,'data.mat']);  %'data' structure
m2=load([dataPath,'data_z.mat']);  %'data' structure

%% monkey 1, helium
RSI_c=data.RSI_correct;
RSI_error=data.RSI_error;
green = [0.4660, 0.6740, 0.1880];

figure;
title('error')
hold on
numBins = 15; % You can adjust this number as needed
binEdges = linspace(-1, .3, numBins + 1);
h2 = histogram(RSI_c, 'BinEdges', binEdges, 'FaceColor', green,'EdgeColor','none');
hold on
box off
title('correct')
xline(0,'-','LineWidth',4,'Color','k')
xlim([-1,.5])
medianValue = median(RSI_c);
axis square
xline(medianValue, 'r-', 'LineWidth', 4);

figure; hold on;
numBins = 15;
binEdges = linspace(-1, .3, numBins + 1);
h1 = histogram(RSI_error, 'BinEdges', binEdges, 'FaceColor', 'k','EdgeColor','none');
hold on
box off
xline(0,'-','LineWidth',4,'Color','k')
title('Errors')
xlim([-1,.5])
medianValue = median(RSI_error);
xline(medianValue, 'r-', 'LineWidth', 4);
axis square
hold off

[p_he, h, stats] = ranksum(RSI_c, RSI_error);

%% monkey 2, zip
RSI_c=m2.data.RSI_correct;
RSI_error=m2.data.RSI_error;

figure;
title('error')
hold on
numBins = 15; % You can adjust this number as needed
binEdges = linspace(-1, .3, numBins + 1);
h2 = histogram(RSI_c, 'BinEdges', binEdges, 'FaceColor', green,'EdgeColor','none');
hold on
box off
title('correct')
xline(0,'-','LineWidth',4,'Color','k')
xlim([-1,.5])
medianValue = median(RSI_c);
axis square
xline(medianValue, 'r-', 'LineWidth', 4);

figure; hold on;
numBins = 15;
binEdges = linspace(-1, .3, numBins + 1);
h1 = histogram(RSI_error, 'BinEdges', binEdges, 'FaceColor', 'k','EdgeColor','none');
hold on
box off
xline(0,'-','LineWidth',4,'Color','k')
title('Errors')
xlim([-1,.5])
medianValue = median(RSI_error);
xline(medianValue, 'r-', 'LineWidth', 4);
axis square
hold off

[p_z, h, stats] = ranksum(RSI_c, RSI_error);
