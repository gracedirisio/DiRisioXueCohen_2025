function []=make_Fig6_SingleSessionExample(data)

vlim=.5;
%% 6a
figure;
hold on
imagesc(data.Correct);  
title('Fig 6a: correct, Average Time-bin Correlation Across Images');
set(gca, 'YDir', 'normal');  
caxis([-vlim vlim]); 
colorbar;
ylabel('Time bin (Image 2)');
xlabel('Time bin (Image 1)');
xlim([.5 16.5])
ylim([.5 16.5])
axis square;

figure;
imagesc(data.Error);  % Transpose so Image 1 is on x-axis
title('error')
set(gca, 'YDir', 'normal');  % Flip Y so time increases upwards
caxis([-vlim vlim]);  % <-- shared color scale
colorbar;
ylabel('Time bin (Image 2)');
xlabel('Time bin (Image 1)');
title('Fig 6a: error, Average Time-bin Correlation Across Images');
xlim([.5 16.5])
ylim([.5 16.5])
axis square;
hold off;

%% 6b: difference
vlim=.1;

diff_mat = data.Correct - data.Error;


% Plot the difference matrix
figure;
imagesc(diff_mat);
set(gca, 'YDir', 'normal');
colorbar;
caxis([-vlim vlim]);  % <-- shared color scale
xlim([.5 16.5])
ylim([.5 16.5])
axis square;
title('Fig 6b: Correct minus Error');
xlabel('Time bin (Image 1)');
ylabel('Time bin (Image 2)');
cmap = redblue(256);
colormap(gca, cmap);

%% 6c: across diagonal difference for correct and error trials
diff_mat_c = data.Correct - data.Correct';
diff_mat_error = data.Error - data.Error';

figure;
imagesc(diff_mat_c);
title('6c: Correct, across diagonal difference');
set(gca, 'YDir', 'normal');
caxis([-vlim vlim]);  
colorbar;
xlim([.5 16.5])
ylim([.5 16.5])
axis square;
xlabel('Time bin (Image 1)');
ylabel('Time bin (Image 2)');
cmap = redblue(256);
colormap(gca, cmap);

figure;
imagesc(diff_mat_error);
title('Fig 6c: Error, across diagonal difference');
set(gca, 'YDir', 'normal');
caxis([-vlim vlim]); 
colorbar;
xlim([.5 16.5])
ylim([.5 16.5])
axis square;
xlabel('Time bin (Image 1)');
ylabel('Time bin (Image 2)');
colormap(gca, cmap);

end