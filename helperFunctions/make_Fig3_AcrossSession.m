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

    plot([-.3 .5], [-.3 .5], '-', 'Color', [.7 .7 .7], 'LineWidth', 3)
    xline(0); yline(0)
    xlim([-.3 .5]); ylim([-.3 .5])
    xlabel('mean rsi, error '); ylabel('mean rsi, correct')
    title('3d: Across session summary, split by nback')
    axis square; box off
    set(gca, 'TickDir', 'out')


    [h,p_low_m1] = ttest(data1.data.Correct_low, data1.data.Error_low);
    [h,p_hi_m1, ] = ttest(data1.data.Correct_H, data1.data.Error_H);

    [h,p_low_m1, ] = ttest(data2.data.Correct_low, data2.data.Error_low);
    [h,p_hi_m1, ] = ttest(data2.data.Correct_H, data2.data.Error_H);


    

else
    figure; hold on;
    plot(data1.data.Z_error,data1.data.Z_Correct,'k^','MarkerFaceColor','k')
    plot(data1.data.H_error,data1.data.H_Correct,'ko','MarkerFaceColor','k')
    plot([-.2 .2], [-.2 .2], '-', 'Color', [.7 .7 .7], 'LineWidth', 3)
    xline(0); yline(0)
    xlim([-.2 .2]); ylim([-.2 .2])
    xlabel('mean rsi, error '); ylabel('mean rsi, correct')
    title('3b: Across session summary')
    axis square; box off
    set(gca, 'TickDir', 'out')
    
    RSI_c=[data1.data.Z_Correct;data1.data.H_Correct];
    RSI_e=[data1.data.Z_error;data1.data.H_error];
    [h,p_all]=ttest(RSI_c,RSI_e,'Tail','right');


    lowerlim=-.4;
    highlim=.4; %add axes before

    edges = linspace(lowerlim, highlim, 15);  % 30 bins between -0.5 and 1


    figure; hold on;
    histogram([RSI_e-RSI_c], 'FaceColor', 'k', 'FaceAlpha', 0.6, 'EdgeColor', 'none','BinEdges',edges);
    xline(0,'-','Color','k',"LineWidth",3)
    xlabel('RSI');
    ylabel('Count');
    xlim([-.4 .4]);




end

end