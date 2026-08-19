%generate Figure S9: Impact of same-sequence reveal 

% source data: (data_monkH_ster / data_monkH_rand / data_monkZ_ster / data_monkZ_rand,
% saved separately for RepSup (S9_RS) and PopCorr (S9_PC)) and generates
% Figure S9
%% load data
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
dataPath = fullfile(repoRoot, 'SourceData', filesep);


sourceDirs.RepSup  = [dataPath, 'S9_RS/'];
sourceDirs.PopCorr = [dataPath, 'S9_PC/'];

measures = {'RepSup','PopCorr'};
monks    = {'H','Z'};

% colors matching original script (group 2 = stereo reveal, group 3 = random reveal)
colorSter = [0 0 1];   % blue
colorRand = [1 0 0];   % red

% marker symbols per monkey, as in original (helium='o', zippy='^')
symbolByMonk = struct('H','o','Z','^');

for mIdx = 1:numel(measures)
    meas = measures{mIdx};
    srcDir = sourceDirs.(meas);

    for kIdx = 1:numel(monks)
        monkLetter = monks{kIdx};
        monknum = kIdx; % 1 = H, 2 = Z (matches original monknum convention)
        symbol = symbolByMonk.(monkLetter);

        % --- load stereo and random data for this monkey/measure ---
        sterFile = fullfile(srcDir, ['data_monk' monkLetter '_ster.mat']);
        randFile = fullfile(srcDir, ['data_monk' monkLetter '_rand.mat']);

        if ~isfile(sterFile) || ~isfile(randFile)
            warning('Missing file(s) for monk %s, measure %s. Skipping.', monkLetter, meas);
            continue
        end

        S_ster = load(sterFile);  data_ster = S_ster.data;
        S_rand = load(randFile);  data_rand = S_rand.data;

        % --- make figure ---
        figure('Name', [monkLetter '_' meas]);
        hold on

        % legend placeholders
        plot(nan,nan,'ko','markerfacecolor',colorSter);
        plot(nan,nan,'ko','markerfacecolor',colorRand);

        groupData = {data_ster, data_rand};
        groupColors = {colorSter, colorRand};
        xy = struct('x',{[],[]},'y',{[],[]}); % holds per-session x/y for connecting lines

        for g = 1:2
            d = groupData{g};
            col = groupColors{g};

            x = d.x(:);
            y = d.y(:);
            SE_x = d.SE_x(:);
            SE_y = d.SE_y(:);

            % guard against length mismatch between x/y and SE arrays
            n = min([numel(x), numel(y), numel(SE_x), numel(SE_y)]);
            x = x(1:n); y = y(1:n); SE_x = SE_x(1:n); SE_y = SE_y(1:n);

            xy(g).x = x;
            xy(g).y = y;

            % scatter points
            plot(x, y, 'k', 'markerfacecolor', col, 'MarkerSize', 15, ...
                'Marker', symbol, 'LineStyle', 'none')

            % error bars
            for nIdx = 1:n
                plot([x(nIdx)-SE_x(nIdx) x(nIdx)+SE_x(nIdx)], [y(nIdx) y(nIdx)], ...
                    '-', 'color', col, 'LineWidth', 1)
                plot([x(nIdx) x(nIdx)], [y(nIdx)-SE_y(nIdx) y(nIdx)+SE_y(nIdx)], ...
                    '-', 'color', col, 'LineWidth', 1)
            end
        end

        % connecting lines between each session's stereo point and its
        % matching random point (same session index), as in the original
        n_pairs = min(numel(xy(1).x), numel(xy(2).x));
        for nIdx = 1:n_pairs
            plot([xy(1).x(nIdx) xy(2).x(nIdx)], [xy(1).y(nIdx) xy(2).y(nIdx)], 'k-')
        end

        set(gca,'linewidth',5)

        axis square

        xlabel('proportion correct')
        ylabel(meas)
        title([monkLetter ' - ' meas])

        % --- axis limits matching original script ---
        if strcmp(meas,'RepSup')
            xlim([.5 1])
            if monknum == 2
                yticks(-.2:.2:.2)
                ylim([0 .2])
            else
                plot([.5 1], zeros(1,2), '-', 'LineWidth', 3, 'Color', [.7 .7 .7])
                yticks(-.15:.15:.15)
                ylim([-.15 .15])
            end
        elseif strcmp(meas,'PopCorr')
            xlim([.5 1])
            ylim([.15 .55])
            yticks(.15:.2:.55)
            if monknum == 2
                yticks(.2:.2:.65)
                ylim([.2 .65])
            end
        end

        legend({'same sequence reveal','random reveal'}, 'location', 'northwestoutside')
    end
end

