%Run script to generate supplemental figure S8 (GLMs)

%% load data
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'GLM', filesep);

%% panel A: plot GLM weights 

monkeys={'helium';'zippy'};
symbols={'o','^'};
colors={[0 0 0],[0 0 0]}; 
numMonks=2;
figure; hold on;

predictor_labels = {'Population Correlation', 'Memorability', 'PC1', 'PC2', 'PC3', 'PC4', 'PC5', 'PC6', 'PC7', 'PC8', 'PC9', 'PC10'};
numPredictors = 12; % weights(2) through weights(13)
xInds = 1:numPredictors;
offset = 0.15; % horizontal jitter between monkeys

for m = 1:numMonks
    load([dataPath, monkeys{m}, '_GLM']) % loads variable 'mdl'
    % x1 = Population correlation
    % x2 = memorability
    % x3:end = top 10 PCs of image features
    weights = mdl.Coefficients.Estimate;
    pVals   = mdl.Coefficients.pValue;
    SE      = mdl.Coefficients.SE;

    % weights(2) through weights(13) = 12 predictors 
    w  = weights(2:13);
    pv = pVals(2:13);
    se = SE(2:13);

    xPos = xInds + (m - 1.5) * offset; % staggering monkeys 

    for i = 1:numPredictors
        % Error bar
        plot([xPos(i) xPos(i)], [w(i)-se(i) w(i)+se(i)], '-', ...
            'Color', colors{m}, 'LineWidth', 1.2);

        % Marker: filled if p < 0.05, open otherwise
        if pv(i) < 0.05
            plot(xPos(i), w(i), symbols{m}, ...
                'MarkerFaceColor', colors{m}, ...
                'MarkerEdgeColor', colors{m}, ...
                'MarkerSize', 8, 'LineWidth', 1.2);
        else
            plot(xPos(i), w(i), symbols{m}, ...
                'MarkerFaceColor', 'none', ...
                'MarkerEdgeColor', colors{m}, ...
                'MarkerSize', 8, 'LineWidth', 1.2);
        end
    end
end

% Reference line at zero
yline(0, '-k', 'LineWidth', 0.8, 'Alpha', 0.5);

% Axes formatting
set(gca, 'XTick', xInds, 'XTickLabel', predictor_labels, ...
    'XTickLabelRotation', 30, 'FontSize', 11, 'Box', 'off');
xlim([0.5, numPredictors + 0.5]);
xlabel('Predictor', 'FontSize', 12);
ylabel('GLM Weight ± SE', 'FontSize', 12);
title('Panel A: GLM Weights by Predictor', 'FontSize', 13);

% Legend: monkey identity + significance indicator
h(1) = plot(nan, nan, symbols{1}, 'MarkerFaceColor', colors{1}, ...
    'MarkerEdgeColor', colors{1}, 'MarkerSize', 8, 'LineStyle', 'none');
h(2) = plot(nan, nan, symbols{2}, 'MarkerFaceColor', colors{2}, ...
    'MarkerEdgeColor', colors{2}, 'MarkerSize', 8, 'LineStyle', 'none');
h(3) = plot(nan, nan, 'o', 'MarkerFaceColor', 'none', ...
    'MarkerEdgeColor', 'k', 'MarkerSize', 8, 'LineStyle', 'none');
h(4) = plot(nan, nan, '^', 'MarkerFaceColor', 'none', ...
    'MarkerEdgeColor', 'k', 'MarkerSize', 8, 'LineStyle', 'none');

legend(h, {'Monkey H, p<0.05', 'Monkey Z, p < 0.05', 'Monkey H, p \geq 0.05', 'Monkey Z, p \geq 0.05'}, ...
    'Location', 'best', 'FontSize', 11);

hold off;

%% panel b

names={'helium';'zippy'};
varNames = {'Pop Corr', 'PC1', 'PC2', 'PC3', 'PC4', 'PC5', 'PC6', 'PC7', 'PC8', 'PC9', 'PC10'};
nVars = length(varNames);

for m=1:2
    monkeyname=names{m};
    load([dataPath, monkeyname,'_ModelInputs']);
    Features = AllFeatures(:,[1,3:end]);
    mdl_Interactions = fitglm(Features, AllChoices, 'interactions', 'Distribution', 'Binomial');

    coefTable = mdl_Interactions.Coefficients;
    allNames  = coefTable.Row(2:end);
    allEst    = coefTable.Estimate(2:end);
    allSE     = coefTable.SE(2:end);
    allP      = coefTable.pValue(2:end);
    allCI     = [allEst - 1.96*allSE, allEst + 1.96*allSE];

    % Identify main effects vs interactions by presence of ':'
    isInteraction = contains(allNames, ':');
    nsColor = 'k';

    %% --- Figure 1: Main effects dot plot ---
    mainIdx   = find(~isInteraction);
    mainEst   = allEst(mainIdx);
    mainCI    = allCI(mainIdx,:);
    mainP     = allP(mainIdx);
    mainNames = allNames(mainIdx);

    % Rename x1-x11 to readable labels
    for t = 1:length(mainNames)
        name = mainNames{t};
        for v = nVars:-1:1
            name = strrep(name, ['x' num2str(v)], varNames{v});
        end
        mainNames{t} = name;
    end

    isSig = mainP < 0.05;
    figure;
    hold on;
    for i = 1:length(mainIdx)
        plot([i i], [mainCI(i,1) mainCI(i,2)], 'Color', [0.5 0.5 0.5], 'LineWidth', 1);
        if isSig(i)
            plot(i, mainEst(i), 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', 'MarkerSize', 7);
        else
            plot(i, mainEst(i), 'o', 'MarkerFaceColor', 'none', 'MarkerEdgeColor', nsColor, 'MarkerSize', 7);
        end
    end
    yline(0, '-k', 'LineWidth', 0.8, 'Alpha', 0.5);
    ylim([-1.5 1.5])
    set(gca, 'XTick', 1:length(mainIdx), 'XTickLabel', mainNames, ...
        'XTickLabelRotation', 45, 'FontSize', 8);
    xlim([0 length(mainIdx)+1]);
    ylabel('Coefficient estimate');
    title([monkeyname ' - main effects'], 'Interpreter', 'none');
    box off;
    hold off;
    output=['/Volumes/Colada/Grace/MyPapers/Figs_svg/Supplement/GLM/'];
    % saveas(gcf,[output,'GLM_mainEffects_monk', num2str(m)], 'svg');

    %% --- Figure 2: Interaction heatmap ---
    intIdx = find(isInteraction);
    intEst = allEst(intIdx);
    intP   = allP(intIdx);
    intNames = allNames(intIdx);

    % Build nVars x nVars matrix for heatmap
    heatEst = nan(nVars, nVars);
    heatSig = false(nVars, nVars);

    for k = 1:length(intIdx)
        name = intNames{k};
        parts = strsplit(name, ':');
        % Get indices for each part
        idx = zeros(1,2);
        for p = 1:2
            for v = nVars:-1:1
                if strcmp(parts{p}, ['x' num2str(v)])
                    idx(p) = v;
                    break;
                end
            end
        end
        if all(idx > 0)
            heatEst(idx(1), idx(2)) = intEst(k);
            heatEst(idx(2), idx(1)) = intEst(k);  % symmetric
            heatSig(idx(1), idx(2)) = intP(k) < 0.05;
            heatSig(idx(2), idx(1)) = intP(k) < 0.05;
        end
    end

    figure;
    imagesc(heatEst, 'AlphaData', ~isnan(heatEst));
    colormap(parula);   % or use 'redblue', 'bwr' — see note below
    colorbar;
    clim([-1, 1]); 
    set(gca, 'XTick', 1:nVars, 'XTickLabel', varNames, 'XTickLabelRotation', 45, ...
             'YTick', 1:nVars, 'YTickLabel', varNames, 'FontSize', 8);
    axis square;
    title([monkeyname ' - interactions'], 'Interpreter', 'none');

    % Overlay asterisks for significant interactions
    hold on;
    for r = 1:nVars
        for c = 1:nVars
            if heatSig(r,c)
                text(c, r, '*', 'HorizontalAlignment', 'center', ...
                    'VerticalAlignment', 'middle', 'FontSize', 12, 'Color', 'k');
            end
        end
    end
    hold off;
end