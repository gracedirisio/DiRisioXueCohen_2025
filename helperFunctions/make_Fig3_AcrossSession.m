function[]=make_Fig3_AcrossSession(data1,data2)

if nargin<2
    data2=[];
    nback=0;
else
    nback=1;
    orange=[245/256, 132/256, 38/256]; %knicks orange
    blue=[0,107/256,182/256]; %blue
end

if nback

    figure; hold on;
    plot(data1.data.Error_low,data1.data.Correct_low,'o','MarkerFaceColor',orange,'MarkerEdgeColor','w')
    plot(data2.data.Error_low,data2.data.Correct_low,'^','MarkerFaceColor',orange,'MarkerEdgeColor','w')
    plot(data1.data.Error_H,data1.data.Correct_H,'o','MarkerFaceColor',blue,'MarkerEdgeColor','w')
    plot(data2.data.Error_H,data2.data.Correct_H,'^','MarkerFaceColor',blue,'MarkerEdgeColor','w')

    plot([-.3 .3], [-.3 .3], '-', 'Color', [.7 .7 .7], 'LineWidth', 3)
    xline(0); yline(0)
    xlim([-.3 .3]); ylim([-.3 .3])
    xlabel('median rsi, error '); ylabel('median rsi, correct')
    title('3d: Across session summary, split by nback')
    axis square; box off
    set(gca, 'TickDir', 'out')

    

    [h,p_low_m1] = ttest(data1.data.Correct_low, data1.data.Error_low);
    [h,p_hi_m1, ] = ttest(data1.data.Correct_H, data1.data.Error_H);

    [h,p_low_m1, ] = ttest(data2.data.Correct_low, data2.data.Error_low);
    [h,p_hi_m1, ] = ttest(data2.data.Correct_H, data2.data.Error_H);
    

else
    figure; hold on;
    plot(data1.data.Z_error,data1.data.Z_Correct,'k^')
    plot(data1.data.H_error,data1.data.H_Correct,'ko')
    plot([-.2 .2], [-.2 .2], '-', 'Color', [.7 .7 .7], 'LineWidth', 3)
    xline(0); yline(0)
    xlim([-.2 .2]); ylim([-.2 .2])
    xlabel('median rsi, error '); ylabel('median rsi, correct')
    title('3b: Across session summary')
    axis square; box off
    set(gca, 'TickDir', 'out')
    
    RSI_c=[data1.data.Z_Correct;data1.data.H_Correct];
    RSI_e=[data1.data.Z_error;data1.data.H_error];
    [h,p_all]=ttest(RSI_c,RSI_e,'Tail','right');

end

end