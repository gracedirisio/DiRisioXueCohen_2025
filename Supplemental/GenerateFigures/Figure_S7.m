%Run script to generate supplemental figure S7

%% load data
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'S7', filesep);

AllData.AcrossSession=load([dataPath, 'data_5_AcrossSess']);

%%
names={'helium';'zippy'};
symbols={'o','^'};
AllCorrect=[];
AllIncorrect=[];
Allsf=[];
numTrials=[];
sf=[];

%plot

%%%%%% plot all super familiar correlations

figure(2); hold on;
figure(3); hold on;
for i = 1:numel(names)
    monkeyname=names{i};
    thepath=['/Volumes/Colada/Grace/' monkeyname '/output_figs/superFam/'];
    load([thepath,'PopConsistency.mat']); %struct 'AllData
    sessions=fieldnames(AllData);
    correct=[];incorrect=[];sf=[];EmptyFlag=zeros(1,numel(sessions));numTrials=[];
    for j = 1:numel(sessions)
        sess=sessions{j};
        if isempty(AllData.(sess))
            EmptyFlag(j)=1;
        else
            fam=AllData.(sess).superfam;
            sf{j}=fam;                          % store all fam values per session
            numTrials=[numTrials; numel(fam)];
        end
    end
    disp(numTrials)

    % Get the correlation values for non-empty sessions
    if monkeyname(1)=='h'
        corrVals_error   = data.H_AllError(~EmptyFlag);
        corrVals_correct = data.H_AllCorrect(~EmptyFlag);
        marker = 'o';
    else
        corrVals_error   = data.Z_AllError(~EmptyFlag);
        corrVals_correct = data.Z_AllCorrect(~EmptyFlag);
        marker = '^';
    end

    % Expand correlation values to match all fam entries per session
    nonempty_idx = find(~EmptyFlag);
    sf_error_all   = [];
    sf_correct_all = [];
    corr_error_all = [];
    corr_correct_all = [];

    for k = 1:numel(nonempty_idx)
        n = numel(sf{nonempty_idx(k)});
        sf_error_all     = [sf_error_all;   sf{nonempty_idx(k)}];
        sf_correct_all   = [sf_correct_all; sf{nonempty_idx(k)}];
        corr_error_all   = [corr_error_all;   repmat(corrVals_error(k),   n, 1)];
        corr_correct_all = [corr_correct_all; repmat(corrVals_correct(k), n, 1)];
    end

    figure(2)
    plot(corr_error_all, sf_error_all, marker, 'MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)
    figure(3)
    plot(corr_correct_all, sf_correct_all, marker, 'MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)
end



figure(2)
title('error x superfam')
xlabel('mean population correlation, error')
ylabel('population correlation, superfam')
xlim([0 1])
ylim([0 1])
axis square
r=refline(1,0)
r.Color = 'k';

hold off

figure(3)
title('correct x superfam')
xlabel('mean population correlation, correct')
ylabel('population correlation, superfam')
xlim([0 1])
ylim([0 1])
r=refline(1,0)
r.Color = 'k';
axis square
hold off


