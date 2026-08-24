%% GFD 05.05.2026
% generates figure panels for Figure 2 panel E

%% load data 
% All paths are relative to this script, so the code can work on any machine
% regardless of where the repository is cloned.
 
% This script lives in GenerateFigures/, so go up one level to repo root
repoRoot = fileparts(fileparts(mfilename('fullpath')));
 
% Add helperFunctions/ to the path
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
 
% Source data path
dataPath = fullfile(repoRoot, 'SourceData', 'Fig2', filesep);
% for decoder
load([dataPath, 'data_decoder']); %'All'

%%
%% Split into image features vs task variables
is_task=All.is_task;
feature_names_filt=All.featureNames;
combined_v4=All.data;

dot_size=10;
%%
image_idx = ~is_task;
task_idx  = is_task;

plot_groups = {
    image_idx, 'Image Features', [198/256 12/256 48/256], ...
    'combinedV4_imageFeatures_';

    task_idx, 'Task Variables', [0 51/256 141/256], ...
    'combinedV4_taskVariables_'
};

%% Make plots

for p = 1:size(plot_groups,1)

    current_idx   = plot_groups{p,1};
    current_title = plot_groups{p,2};
    current_color = plot_groups{p,3};
    save_prefix   = plot_groups{p,4};

    % Current subset
    current_names = feature_names_filt(current_idx);
    current_mat   = combined_v4(:, current_idx);

    %% Plot
    if p==1
    figure('Position',[70 70 980 490]);
    else
    figure('Position',[10 10 300 490]);

    end

    h = boxplot(current_mat, ...
        'Labels', current_names, ...
        'Whisker',1.5);

    hold on;

    % Make dashed lines solid
    h2 = findobj('LineStyle','--');
    set(h2,'LineStyle','-');

    % Make whiskers solid
    whiskers = findobj(h,'Tag','Whisker');

    for i = 1:length(whiskers)
        whiskers(i).LineStyle = '-';
        whiskers(i).LineWidth = 1.5;
    end

    % Thicker boxplot lines
    set(h,'Color','k','LineWidth',3);

    % Median lines
    set(findobj(gca,'Tag','Median'), ...
        'Color',[0.5 0.5 0.5], ...
        'LineWidth',3);

    %% Overlay scatter

    for i = 1:numel(current_names)

        x = repmat(i, size(current_mat,1), 1);
        y = current_mat(:,i);

        jitter = (rand(size(y)) - 0.5) * 0.2;

        % Helium = circles
        scatter( ...
            x + ...
            jitter, ...
            y, ...
            dot_size, ...
            'o', ...
            'filled', ...
            'MarkerFaceColor', current_color, ...
            'MarkerFaceAlpha', 0.6);

    end

    %% Styling

    title(['Feature Decoding Accuracy in V4: ' current_title]);

    xtickangle(45);
    if p ==1
    ylim([-.1 .5]);
    yticks(0:.25:.5);
    yline(0,'k-','LineWidth',2);
    ylabel('V4 Decoding Accuracy (r)');
    name_str='roc';
    else
    ylim([.5 1]);
    yticks(.5:.25:1);
    yline(.5,'k-','LineWidth',2);
    ylabel('V4 Decoding Accuracy (auc)');
    name_str='LR';

    end

    grid on;
    box off;

    set(gca,'TickDir','out');

    ax = gca;


end
