function[]=make_Fig6_AcrossSessionExample(data)

vlim=.1;
figure; hold on;
imagesc(data.DiagDiff_Correct);
title('correct')
set(gca, 'YDir', 'normal');
colorbar;
xlabel('Time bin (Image 1)');
ylabel('Time bin (Image 2)');
colormap(gca, redblue(256));
caxis([-vlim, vlim]); 
xlim([.5 16.5])
ylim([.5 16.5])
axis square;
hold off


figure;
imagesc(data.DiagDiff_Error);
title('error')
set(gca, 'YDir', 'normal');
xlabel('Time bin (Image 1)');
ylabel('Time bin (Image 2)');
colormap(gca, redblue(256));
caxis([-vlim, vlim]); 
xlim([.5 16.5])
ylim([.5 16.5])
axis square;
hold off

end