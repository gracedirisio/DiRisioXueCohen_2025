%% GFD 05.06.2026
%generates figures corresponding to Figure 5: 
%population response consistency predicts successful recognition

% 5a shows a single trial example
% 5b single session example
% 5c across session summary
% 5d Across single session  (same as 5b, split by nback)
% 5e across session summary, split by nback
% 5f relationship of neurons to behavior

%% load data 
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'Fig5', filesep);

% 5a, single trial examples
AllData.SingleTrial.ex1=load([dataPath, 'data_5a_img_359']);
AllData.SingleTrial.ex2=load([dataPath, 'data_5a_img_632']);

% 5b and d, single session 
AllData.SingleSession=load([dataPath, 'data_5_singlesess']);

% 5c and e, across session summary
AllData.AcrossSession=load([dataPath, 'data_5_AcrossSess']);



% for 5f (relationship of consistency to behavior)
AllData.AcrossSess_Behavior_H_low=load([dataPath, 'data_5f_monkH_low']);
AllData.AcrossSess_Behavior_H_high=load([dataPath, 'data_5f_monkH_high']);
AllData.AcrossSess_Behavior_Z_low=load([dataPath, 'data_5f_monkZ_low']);
AllData.AcrossSess_Behavior_Z_high=load([dataPath, 'data_5f_monkZ_high']);


%%
%5a, single trial
[corr_coef_example1]=make_Fig5a(AllData.SingleTrial.ex1.data); 
[corr_coef_example2]=make_Fig5a(AllData.SingleTrial.ex2.data);

%5b and d, single session
make_Fig5_singlesess(AllData.SingleSession.data);

%5c and e, across session
make_Fig5_AcrossSess(AllData.AcrossSession.data);


%5f, relationship to behavior
make_Fig3_5_behavior(AllData.AcrossSess_Behavior_H_low.data, AllData.AcrossSess_Behavior_H_high.data) %panel 5f
make_Fig3_5_behavior(AllData.AcrossSess_Behavior_Z_low.data, AllData.AcrossSess_Behavior_Z_high.data) %panel 5f
