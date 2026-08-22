%% Run script to generate supplemental figure S7
%% load data — all paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'S7', filesep);

AllData.AcrossSession = load([dataPath, 'data_5_AcrossSess']);
AllData.SuperFam      = load([dataPath, 'data_6_SuperFamCorr']);

%% plot all super-familiar correlations
names = fieldnames(AllData.SuperFam.SuperFamCorr);

figure(2); hold on
figure(3); hold on

for i = 1:numel(names)
    d = AllData.SuperFam.SuperFamCorr.(names{i});

    figure(2)
    plot(d.error_corr, d.error_sf, d.marker, ...
        'MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)

    figure(3)
    plot(d.correct_corr, d.correct_sf, d.marker, ...
        'MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)
end

figure(2)
title('error x superfam')
xlabel('mean population correlation, error')
ylabel('population correlation, superfam')
xlim([0 1]); ylim([0 1]); axis square
r = refline(1,0); r.Color = 'k';
hold off

figure(3)
title('correct x superfam')
xlabel('mean population correlation, correct')
ylabel('population correlation, superfam')
xlim([0 1]); ylim([0 1]); axis square
r = refline(1,0); r.Color = 'k';
hold off