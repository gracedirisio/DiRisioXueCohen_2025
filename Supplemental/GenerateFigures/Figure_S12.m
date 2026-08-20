%% Generates Figure S12: Across session summary of RSI values considering n-back condition

%% load data
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'S12', filesep);

m2=load([dataPath,'zippy_3d_nofilter.mat']);  
m1=load([dataPath,'helium_3d_nofilter.mat']);  

%% inits (knicks colors)
orange=[245/256, 132/256, 38/256]; %knicks orange
blue=[0,107/256,182/256]; %blue

%% 
RSI_error_low_He=m1.data.Error_low;
RSI_error_high_He=m1.data.Error_H;
RSI_correct_high_He=m1.data.Correct_H;
RSI_correct_low_He=m1.data.Correct_low;

RSI_error_low_Z=m2.data.Error_low;
RSI_error_high_Z=m2.data.Error_H;
RSI_correct_high_Z=m2.data.Correct_H;
RSI_correct_low_Z=m2.data.Correct_low;


figure; hold on;
%Zippy data
plot(RSI_error_low_Z,RSI_correct_low_Z,'^','MarkerFaceColor',orange, 'MarkerEdgeColor','w','MarkerSize',12)
plot(RSI_error_high_Z,RSI_correct_high_Z,'^','MarkerFaceColor',blue, 'MarkerEdgeColor','w','MarkerSize',12)
%helium data
plot(RSI_error_low_He,RSI_correct_low_He,'o','MarkerFaceColor',orange, 'MarkerEdgeColor','w','MarkerSize',12)
plot(RSI_error_high_He,RSI_correct_high_He,'o','MarkerFaceColor',blue, 'MarkerEdgeColor','w','MarkerSize',12)
%format
xlim([-0.3,0.5]); ylim([-0.3,0.5])
axis square
refline(1,0)
xline(0)
yline(0)