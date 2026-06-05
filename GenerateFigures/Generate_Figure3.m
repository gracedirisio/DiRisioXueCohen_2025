%% GFD 05.05.2026
%generates figures corresponding to Figure 3: 
%Repetition suppression does not predict successful memory when accounting
%for image recency

% 3a shows a single session example
% 3b across session summary
% 3c shows same single session example, split up by nback
% 3d Across session summary (split by nback)
% 3e relationship of repetition suppression to performance

%% load data %%
% All paths are relative to this script

repoRoot = fileparts(fileparts(mfilename('fullpath')));
 
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'Fig3', filesep);
% for 3a and c (single session)
AllData.SingleSess_a=load([dataPath, 'data_3a']);
AllData.SingleSess_c=load([dataPath,  'data_3c']);

% for 3b and d (across session)
AllData.AcrossSess_3=load([dataPath,  'data_3b']);
AllData.AcrossSess_3d_H=load([dataPath,  'helium_3d']);
AllData.AcrossSess_3d_Z=load([dataPath,  'zippy_3d']);

% for 3e (relationship of RS to performance)
%source data saved out and good to go
AllData.AcrossSess_Behavior_H_low=load([dataPath, 'data_3e_monkH_low']);
AllData.AcrossSess_Behavior_H_high=load([dataPath, 'data_3e_monkH_high']);
AllData.AcrossSess_Behavior_Z_low=load([dataPath, 'data_3e_monkZ_low']);
AllData.AcrossSess_Behavior_Z_high=load([dataPath, 'data_3e_monkZ_high']);

%% plots %%
% single session (3a and 3c)
make_Fig3_singlesession(AllData.SingleSess_a.data) %panel 3a
make_Fig3_singlesession(AllData.SingleSess_c.data) %panel 3c

% across session (3b and 3d)
make_Fig3_AcrossSession(AllData.AcrossSess_3) %panel 3b
make_Fig3_AcrossSession(AllData.AcrossSess_3d_H, AllData.AcrossSess_3d_Z) %panel 3c

% relationship to behavior (3e)
make_Fig3_5_behavior(AllData.AcrossSess_Behavior_H_low.data, AllData.AcrossSess_Behavior_H_high.data) %panel 3e
make_Fig3_5_behavior(AllData.AcrossSess_Behavior_Z_low.data, AllData.AcrossSess_Behavior_Z_high.data) %panel 3e
