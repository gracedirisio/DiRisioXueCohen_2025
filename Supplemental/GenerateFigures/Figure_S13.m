%% Generates Figure S13: 
% Across session summary (medians) of RSI values and population correlation values 
% considering n-back condition. 
%% load data
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath_RS = fullfile(repoRoot, 'SourceData', 'S13_RS', filesep);
dataPath_PC = fullfile(repoRoot, 'SourceData', 'S13_PC', filesep);

m2=load([dataPath_RS,'zippy.mat']);  
m1=load([dataPath_RS,'helium.mat']);  

ConsistencyData=load([dataPath_PC,'data.mat']);  




%% inits (knicks colors)
orange=[245/256, 132/256, 38/256]; %knicks orange
blue=[0,107/256,182/256]; %blue

%% Repetition Suppression panel
RSI_error_low_He=m1.data.Error_low;
RSI_error_high_He=m1.data.Error_H;
RSI_correct_high_He=m1.data.Correct_H;
RSI_correct_low_He=m1.data.Correct_low;

RSI_error_low_Z=m2.data.Error_low;
RSI_error_high_Z=m2.data.Error_H;
RSI_correct_high_Z=m2.data.Correct_H;
RSI_correct_low_Z=m2.data.Correct_low;


figure; hold on;
title('repetition suppression')
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

%% Response consistency panel

% ConsistencyData
error_low_He=ConsistencyData.data.H_error_low;
error_high_He=ConsistencyData.data.H_error_high;
correct_high_He=ConsistencyData.data.H_Correct_high;
correct_low_He=ConsistencyData.data.H_Correct_low;

error_low_Z=ConsistencyData.data.Z_error_low;
error_high_Z=ConsistencyData.data.Z_error_high;
correct_high_Z=ConsistencyData.data.Z_Correct_high;
correct_low_Z=ConsistencyData.data.Z_Correct_low;


figure; hold on;
%Zippy data
plot(error_low_Z,correct_low_Z,'^','MarkerFaceColor',orange, 'MarkerEdgeColor','w','MarkerSize',12)
plot(error_high_Z,correct_high_Z,'^','MarkerFaceColor',blue, 'MarkerEdgeColor','w','MarkerSize',12)
%helium data
plot(error_low_He,correct_low_He,'o','MarkerFaceColor',orange, 'MarkerEdgeColor','w','MarkerSize',12)
plot(error_high_He,correct_high_He,'o','MarkerFaceColor',blue, 'MarkerEdgeColor','w','MarkerSize',12)
%format
axis square
refline(1,0)

% stats

% [p_low, h_low] = ttest(correct_low_He, error_low_He,'tail','right');
% [p_high, h_h] = ttest(correct_high_He, error_high_He,'tail','right');
% 
% 
% [p_low, h_low] = ttest(correct_low_Z,error_low_Z,'tail','right');
% [p_high, h_h] = ttest(correct_high_Z,error_high_Z, 'tail','right');




[p_low, h_low] = ttest([correct_low_Z; correct_low_He],[error_low_Z;error_low_He],'tail','right');
[p_h, h_h] = ttest([correct_high_Z; correct_high_He],[error_high_Z;error_high_He],'tail','right');


