%% Generates receptive fields of an example session

%% load data
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'S2', filesep);
load([dataPath, 'rfv4.mat']) %rfv4

%% plot RF
pos = [150 150 250];
ax=[-100 600 -250 250];
numNeur=64;

ha=figure('color','w','pos',[450,450,450,450]);

axes(ha(1)); hold on;
for ii=1:numNeur
    plot(gca,rfv4.staFit_beta(ii,2),rfv4.staFit_beta(ii,4),'.','markersize',15,'color',[0.2 0.9 0.3]*0.8);
    drawellipse(gca,'center',rfv4.staFit_beta(ii,[2 4]),'SemiAxes',abs(rfv4.staFit_beta(ii,[3 5])/2),'Color',[0.2 0.9 0.3],'facealpha',0,'InteractionsAllowed','none','selected',false,'linewidth',1,'edgealpha',0.5);
end
plot(0,0,'r.','markersize',20);
axis(ax)

axis square
ylim([ax(3), ax(4)])
yticks(linspace(ax(3), ax(4),3))
yticklabels(linspace(ax(3), ax(4),3))

xlim([ax(1), ax(2)])
xticks(linspace(ax(1), ax(2),8))
xticklabels(linspace(ax(1), ax(2),8))