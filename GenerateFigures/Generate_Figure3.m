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
dataPath=['/Volumes/Colada/Grace/Code/ForSubmission/NatueComm_2025/SourceData/'];

% for 3a and c (single session)
AllData.SingleSess_a=load([dataPath, 'Fig3/', 'data_3a']);
% AllData.SingleSess_c=load([dataPath, 'Fig3/', 'data_']);

% for 3b and d (across session)
%source file in
%smb://128.135.198.39/Colada/Grace/MyPapers/PopCorrData/RepSupp/Figure1b/

% %RSI 3b: but is not differentiating by monkey and low nbacks look weird
% load('/Volumes/Colada/Grace/MyPapers/PopCorrData/RepSupp/Figure1b/sessionRSI_correct.mat')
% load('/Volumes/Colada/Grace/MyPapers/PopCorrData/RepSupp/Figure1b/sessionRSI_error.mat')
% load('/Volumes/Colada/Grace/MyPapers/PopCorrData/RepSupp/Figure1b/sessionRSI_correctlow.mat')
% load('/Volumes/Colada/Grace/MyPapers/PopCorrData/RepSupp/Figure1b/sessionRSI_errorlow.mat')
% load('/Volumes/Colada/Grace/MyPapers/PopCorrData/RepSupp/Figure1b/sessionRSI_correcthi.mat')
% load('/Volumes/Colada/Grace/MyPapers/PopCorrData/RepSupp/Figure1b/sessionRSI_errorhi.mat')


% for 3e (relationship of RS to performance)
%source data saved out and good to go
AllData.SingleSess_a=load([dataPath, 'Fig3/', 'data_3e_monkH']);
AllData.SingleSess_a=load([dataPath, 'Fig3/', 'data_3e_monkZ']);

%% plots %%
% single session (3a and 3c)
make_Fig3_singlesession(AllData.SingleSess_a.data) %panel 3a
% make_Fig3_singlesession(AllData.SingleSess_c) %panel 3c
% across session (3b and 3d)

% relationship to behavior (3e)