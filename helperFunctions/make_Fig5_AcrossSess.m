function[]=make_Fig5_AcrossSess(data)

low_color=[245/256, 132/256,  38/256];   % Knicks orange for low nback
high_color=[0, 107/256, 182/256]; % blue for high nback

figure; hold on;
plot(data.H_AllError ,data.H_AllCorrect,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)
plot(data.Z_AllError ,data.Z_AllCorrect,'^','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)
xlim([0 1])
ylim([0 1])
refline(1,0)
title('5e, split by nback')
xlabel('mean population correlation, error')
ylabel('mean population correlation, correct')

% [h,p_both] = ttest([data.H_AllCorrect;data.Z_AllCorrect], [data.H_AllError;data.Z_AllError ],'Tail','right');


figure; hold on;
plot(data.H_error_low ,data.H_Correct_low,'o','MarkerFaceColor',low_color,'MarkerEdgeColor',low_color, 'MarkerSize',10)
plot(data.Z_error_low ,data.Z_Correct_low,'^','MarkerFaceColor',low_color,'MarkerEdgeColor',low_color,'MarkerSize',10)
plot(data.H_error_high ,data.H_Correct_high,'o','MarkerFaceColor',high_color,'MarkerEdgeColor',high_color,'MarkerSize',10)
plot(data.Z_error_high ,data.Z_Correct_high,'^','MarkerFaceColor',high_color,'MarkerEdgeColor',high_color,'MarkerSize',10)
refline(1,0)
title('5e, split by nback')
xlabel('mean population correlation, error')
ylabel('mean population correlation, correct')

% [h,p_low]=ttest([data.H_Correct_low;data.Z_Correct_low],[data.H_error_low;data.Z_error_low],'Tail','right');
% [h,p_high]=ttest([data.H_Correct_high;data.Z_Correct_high],[data.H_error_high;data.Z_error_high],'Tail','right');


end