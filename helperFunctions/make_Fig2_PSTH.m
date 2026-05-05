function [] = make_Fig2_PSTH(subFig, data1, data2)
%   GFD 05.05.2026, Plots PSTH for Figure 2 subplots F, G, and H.
%
%    Baseline value plotted as a filled circle at x = 0
%    Line with errorbars extends from x = 0 to x = numbins
%
%   Data format: each field in the struct is [2 x 17]
%     row 1 = mean firing rate across 17 time bins
%     row 2 = SEM (error bar)
%     col 1 = baseline (plotted at x = 0)
%     col 2:17 = time bins corrresponding to number of fragments revealled (plotted at x = 1:16)
%
%   Usage:
%     make_Fig2_PSTH('F', AllData.data_2F)
%     make_Fig2_PSTH('G', AllData.data_2G_Left, AllData.data_2G_Right)
%     make_Fig2_PSTH('H', AllData.data_2H)

if nargin < 3
    data2 = [];
end

% Colors
green  = [0.4660, 0.6740, 0.1880];
orange = [245/256, 132/256,  38/256];   % Knicks orange
blue   = [0,       107/256, 182/256];
black  = [0, 0, 0];

switch upper(subFig)

    %%%%%% Subplot F %%%%%%
    case 'F'
        titleStr  = 'First presentation, correct vs error';
        colorList = {green; black};
        ltList    = {'-';   '--'};

        fig = figure('Color', 'w', 'Name', 'Fig 2F');
        ax  = axes('Parent', fig);
        hold(ax, 'on');

        [legStr, nBins] = plotStruct(ax, data1, colorList, ltList, {});
        finishAxes(ax, titleStr, legStr, nBins);

    %%%%%%% Subplot G: two panels %%%%%%
    case 'G'
        % Left panel  (data1): SData_Correct (green), SData_Co1Co2 (green --)
        % Right panel (data2): SData_Correct (green), SData_Co1E2  (black --)
        %
        fieldStylesLeft = struct( ...
            'SData_Correct', {{green, '-',  'Correct'}}, ...
            'SData_Co1Co2',  {{green, '--', 'Co1Co2'}});

        fieldStylesRight = struct( ...
            'SData_First_Co1E2',  {{green, '-',  'Correct'}}, ...
            'SData_Sec_Co1E2',    {{black, '--', 'Co1E2'}});

        panelData   = {data1, data2};
        panelStyles = {fieldStylesLeft, fieldStylesRight};
        panelTitles = {'Correct vs Co1Co2', 'SData_First_Co1E2 vs SData_Sec_Co1E2'};

        fig   = figure('Color', 'w', 'Name', 'Fig 2G');
        axAll = gobjects(1, 2);

        for panel = 1:2
            ds     = panelData{panel};
            styles = panelStyles{panel};
            if isempty(ds), continue; end

            axAll(panel) = subplot(1, 2, panel);
            hold(axAll(panel), 'on');

            [legStr, nBins] = plotStructStyled(axAll(panel), ds, styles);
            finishAxes(axAll(panel), panelTitles{panel}, legStr, nBins);
        end

        validAx = axAll(isgraphics(axAll));
        if numel(validAx) > 1
            linkaxes(validAx, 'y');
        end

    %%%%%%%% Subplot H: low vs high n-back %%%%%%%%%%%%%%
    case 'H'
        titleStr  = 'Low vs high n-back';
        colorList = {green; orange; blue};
        ltList    = {'-';   '--';   '--'};
        legLabels = {'Correct', 'Low n-back', 'High n-back'};

        fig = figure('Color', 'w', 'Name', 'Fig 2H');
        ax  = axes('Parent', fig);
        hold(ax, 'on');

        [legStr, nBins] = plotStruct(ax, data1, colorList, ltList, legLabels);
        finishAxes(ax, titleStr, legStr, nBins);

    otherwise
        error('make_Fig2_PSTH: unknown subFig ''%s''. Use ''F'', ''G'', or ''H''.', subFig);
end

end 


% =========================================================================
%  plotStructStyled: plot fields using a per-field style lookup struct.
%    styles.(fieldName) = {color, linestyle, legendLabel}
% =========================================================================
function [legStr, nBins] = plotStructStyled(ax, ds, styles)
    fields = fieldnames(styles);   % plot in the order defined in styles
    nBins  = [];
    legStr = {};

    for fi = 1:numel(fields)
        fn = fields{fi};
        if ~isfield(ds, fn)
            warning('make_Fig2_PSTH: field ''%s'' not found, skipping.', fn);
            continue;
        end

        mat  = ds.(fn);
        mu   = mat(1, :);
        sem  = mat(2, :);
        cfg  = styles.(fn);   % {color, linestyle, label}
        col  = cfg{1};
        lt   = cfg{2};
        lbl  = cfg{3};

        nBins = numel(mu) - 1;
        xVec  = 0:nBins;

        % Baseline filled circle at x = 0 (excluded from legend)
        errorbar(ax, 0, mu(1), sem(1), 'o', ...
            'Color',            col, ...
            'MarkerFaceColor',  col, ...
            'LineWidth',        1.5, ...
            'HandleVisibility', 'off');

        % Full line + errorbars
        errorbar(ax, xVec, mu, sem, lt, ...
            'Color',    col, ...
            'LineWidth', 3);

        legStr{end+1} = lbl; 
    end
end


% =========================================================================
%  plotStruct: generic version using positional color/style lists
% =========================================================================
function [legStr, nBins] = plotStruct(ax, ds, colorList, ltList, legLabels)
    fields = fieldnames(ds);
    nBins  = [];
    legStr = {};

    for fi = 1:numel(fields)
        mat = ds.(fields{fi});
        mu  = mat(1, :);
        sem = mat(2, :);
        col = colorList{min(fi, numel(colorList))};
        lt  = ltList{min(fi, numel(ltList))};

        nBins = numel(mu) - 1;
        xVec  = 0:nBins;

        errorbar(ax, 0, mu(1), sem(1), 'o', ...
            'Color',            col, ...
            'MarkerFaceColor',  col, ...
            'LineWidth',        1.5, ...
            'HandleVisibility', 'off');

        errorbar(ax, xVec, mu, sem, lt, ...
            'Color',    col, ...
            'LineWidth', 3);

        if ~isempty(legLabels) && fi <= numel(legLabels)
            legStr{end+1} = legLabels{fi}; 
        else
            legStr{end+1} = fields{fi};   
        end
    end
end


% =========================================================================
%  finishAxes: shared axis styling
% =========================================================================
function finishAxes(ax, titleStr, legStr, nBins)
    
    xlabel(ax, 'Time bin');
    ylabel(ax, 'Normalized rate');
    title(ax,  titleStr);
    ylim(ax,   [0 1.1]);
    yticks(ax, 0:0.25:1);
    if ~isempty(nBins)
        xlim(ax, [0, nBins]);
    end
    axis(ax, 'square');
    box(ax, 'off');
    if ~isempty(legStr)
        legend(ax, legStr, 'Interpreter', 'none', 'Location', 'southeast');
    end
    hold(ax, 'off');
end