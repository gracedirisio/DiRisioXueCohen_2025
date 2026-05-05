%% GFD 05.05.2026
%generates figures corresponding to Figure 2: 
%Behavioral performance and basic neural representations.

% 2c shows behavioral performance for each animal
% 2e shows decoding performance
% 2f-h shows psths

%% load data %%
dataPath=['/Volumes/Colada/Grace/Code/ForSubmission/NatueComm_2025/SourceData/'];

% for 2c (behavioral performance)
AllData.H_2c=load([dataPath, 'Fig2/', 'data_2c_H']);
AllData.Z_2c=load([dataPath, 'Fig2/', 'data_2c_Z']);

% for 2b
% AllData.b=load([dataPath, 'Fig2/', 'data_4b']);
% 
% for 2F-H (psths)
AllData.data_2F=load([dataPath, 'Fig2/', 'data_2F']);
AllData.data_2G_Left=load([dataPath, 'Fig2/', 'data_2G_Left']);
AllData.data_2G_Right=load([dataPath, 'Fig2/', 'data_2G_Right']);
AllData.data_2H=load([dataPath, 'Fig2/', 'data_2H']);

%% plots %%
%behavior
make_Fig2c(AllData.H_2c.data); %monkey H
make_Fig2c(AllData.Z_2c.data); %monkey Z

% %decoding performance
% make_Fig4b(AllData.b.data);


%psths
make_Fig2_PSTH('F', AllData.data_2F);
make_Fig2_PSTH('G', AllData.data_2G_Left, AllData.data_2G_Right);
make_Fig2_PSTH('H', AllData.data_2H);
