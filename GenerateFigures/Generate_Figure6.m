%% GFD 05.07.2026
% generates figures corresponding to Figure 6: 
% Temporal dynamics of population response consistency reveal evidence of pattern completion.

% 6a shows a single session example (correct vs error trials)
% 6b shows the difference of matrices in 6a
% 6c shows the difference across the diagonal for correct vs error trials
% (single session)
% 6d shows the difference across the diagonal for correct vs error trials
% (across session)
% 6e shows the lag correlation for each monkey
% 6f and 6g shows the asymmetry index (either all trials or split by nback)
% for correct vs error trials 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% load data 
% All paths are relative to this script
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(repoRoot, 'helperFunctions')));
dataPath = fullfile(repoRoot, 'SourceData', 'Fig6', filesep);

% 6a, b, c: single session examples
AllData.SingleSession=load([dataPath,'SingleSession']);

% 6d: across session example
AllData.AcrossSessionExample=load([dataPath,'AcrossSession']);

% 6e: lag correlation analysis session 
AllData.Lag.H=load([dataPath,'AcrossSession_Lag_helium']);
AllData.Lag.Z=load([dataPath,'AcrossSession_Lag_zippy']);

% 6f and g: asymmetry index
AllData.AsymIdx=load([dataPath,'asymmetryIndex']);

%% 
% single session
make_Fig6_SingleSessionExample(AllData.SingleSession.data);

% across session example
make_Fig6_AcrossSessionExample(AllData.AcrossSessionExample.data);

% lag correlations
make_Fig6e(AllData.Lag.H.data); %monkey H
make_Fig6e(AllData.Lag.Z.data); %monkey Z

%asymmetry
make_Fig6_F_G(AllData.AsymIdx.data);
