%% GFD 05.05.2026
% generates figure panels for Figure 2: 
% Behavioral performance and basic neural representations.

% 2c shows behavioral performance for each animal
% 2e shows decoding performance
% 2f-h shows psths

%% load data 
% All paths are relative to this script, so the code can work on any machine
% regardless of where the repository is cloned.
 
% This script lives in GenerateFigures/, so go up one level to repo root
repoRoot = fileparts(fileparts(mfilename('fullpath')));
 
% Add helperFunctions/ to the path
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
 
% Source data path
dataPath = fullfile(repoRoot, 'SourceData', 'Fig2', filesep);
% for 2c (behavioral performance)
AllData.H_2c=load([dataPath, 'data_2c_H']);
AllData.Z_2c=load([dataPath, 'data_2c_Z']);

% for 2e
% AllData.data_2e=load([dataPath,  'data_2e']);
% 
% for 2F-H (psths)
AllData.data_2F=load([dataPath, 'data_2F']);
AllData.data_2G_Left=load([dataPath, 'data_2G_Left']);
AllData.data_2G_Right=load([dataPath, 'data_2G_Right']);
AllData.data_2H=load([dataPath, 'data_2H']);

%% plots 

% behavior
make_Fig2c(AllData.H_2c.data); %monkey H
make_Fig2c(AllData.Z_2c.data); %monkey Z

% %decoding performance
% make_Fig2e(AllData.data_2e.data);


% psths
make_Fig2_PSTH('F', AllData.data_2F);
make_Fig2_PSTH('G', AllData.data_2G_Left, AllData.data_2G_Right);
make_Fig2_PSTH('H', AllData.data_2H);
