%% Generates Figure S5

%% load data
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'S5', filesep);

% single session example, same session as Figure 4b
load([dataPath,'data.mat']);  % loads errorCounts, correctCounts
% errorCounts = errorCounts(~isnan(errorCounts));
% correctCounts = correctCounts(~isnan(correctCounts));

%% Schematic for session-wide measure - VIOLIN PLOTS
orange=[245 132 38] ./256;
blue=[0,107,182] ./256;
% Flatten to vectors
errorVec   = highCounts(:);
correctVec = lowCounts(:);

% X positions for each violin
xCorrect = -0.25;
xError   =  0.25;
violinWidth = 0.2;  % max half-width of each violin

figure;
hold on;

% (orange, LEFT) 
[f2, xi2] = ksdensity(correctVec, 'BandWidth', 0.3);
f2_norm = f2 / max(f2) * violinWidth;
fill(xCorrect + [f2_norm, -fliplr(f2_norm)], ...
     [xi2, fliplr(xi2)], orange, ...
     'EdgeColor', 'none', 'FaceAlpha', 0.8);

% (blue, RIGHT) 
[f1, xi1] = ksdensity(errorVec, 'BandWidth', 0.3);
f1_norm = f1 / max(f1) * violinWidth;
fill(xError + [f1_norm, -fliplr(f1_norm)], ...
     [xi1, fliplr(xi1)], blue, ...
     'EdgeColor', 'none', 'FaceAlpha', 0.8);

%  Median lines 
medianHalfWidth = 0.06;
plot(xCorrect + [-medianHalfWidth, medianHalfWidth], ...
     [nanmedian(correctVec), nanmedian(correctVec)], ...
     'w', 'LineWidth', 2);
plot(xError + [-medianHalfWidth, medianHalfWidth], ...
     [nanmedian(errorVec), nanmedian(errorVec)], ...
     'w', 'LineWidth', 2);


yline(2)
% Formatting
box off;
axis square;
ylabel('Count');
xticks([xCorrect, xError]);
xticklabels({'low nback', 'high'});
xlim([-0.55 0.55]);
ylim([-4 5]);
yticks(-4:1:5);
title('single sessione example, same example as 4b')
hold off;

[p, h, stats] = ranksum(correctVec, errorVec);


%% across session scatter
mnames={'helium';'zippy'};
symbols={'o','^'};
low_proportion=[];
hi_proportion=[];
combined_low=[];combined_high=[];

scatterData = [dataPath, 'data_scatter'];
load(scatterData)

figure;hold on 

for i=1:numel(mnames)
    mname=mnames{i};
    if i==1
        RelData=data.m1;
    else
        RelData=data.m2;
    end

    low_proportion=[cell2mat(RelData.PropFiringLo);];
    hi_proportion=[cell2mat(RelData.PropFiringHi);];
    
    plot(low_proportion,hi_proportion,'k','Marker',symbols{i},'LineStyle','none','MarkerFaceColor','k')
    hold on

    combined_low=[combined_low;low_proportion];
    combined_high=[combined_high; hi_proportion];

end

[a,b]=ranksum(combined_low,combined_high);
disp(['ranksum:' num2str(a)])

xlim([0 .1])
ylim([0 .1])
refline(1,0)
xlabel('low nback')
ylabel('high nback')
title('across session')
axis square