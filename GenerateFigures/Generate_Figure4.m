%% GFD 05.05.2026
%generates figures corresponding to Figure 4: 
%Unusually elevated activity in a sparse subset of neurons predicts successful memory on future image presentations.

% 4a shows single trial example
% 4b shows single session example
% 4c shows data across session and monkeys

%% load data %%
dataPath=['/Volumes/Colada/Grace/Code/ForSubmission/NatueComm_2025/SourceData/'];

% for 4a
AllData.a=load([dataPath, 'Fig4/', 'data_4a']);
%4b
AllData.b=load([dataPath, 'Fig4/', 'data_4b']);

%4c
AllData.c_monkZ=load([dataPath, 'Fig4/', 'data_4c_Z']);
AllData.c_monkH=load([dataPath, 'Fig4/', 'data_4c_H']);

%%

make_Fig4a(AllData.a.data);


make_Fig4b(AllData.b.data);


[stats]=make_Fig4c(AllData.c_monkZ.data,AllData.c_monkH.data);
