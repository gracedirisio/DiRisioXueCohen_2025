%% Generates Figure S11

%% load data
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'S11', filesep);


%% Plotting
%monkey 1 = Helium
%monkey 2 = Zippy

for m=1:2
load([dataPath, 'data_', num2str(m)]) %'data', each monkey has a matrix

 % Plot
        figure;
        h = heatmap(data.key_labels, data.key_labels, data.rho, ...
            'Colormap', redblue(256), ...
            'ColorLimits', [-1 1], ...
            'CellLabelFormat','%.2f');
        title(['Weighted Avg Partial Correlation']);
end



%% colormap
function cmap = redblue(m)
    if nargin < 1
        m = 256;
    end

    %buffalo bills colors
    red_rgb = [198 12 48] / 255;
    white_rgb = [1 1 1];
    blue_rgb = [0 51 141] / 255;

    p = linspace(-1, 1, m);
    cmap = interp1([-1 0 1], [blue_rgb; white_rgb; red_rgb], p, 'linear');
end