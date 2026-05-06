function[]=make_Fig3_singlesession(data)
nback_plot=0;
if isfield(data,'low_Correct')
    nback_plot=1;
end

if nback_plot==0
    RSI_error=data.error;
    RSI_correct=data.Correct;
    symbol='^';
    amin=-0.1;
    amax=0.2;
    
    figure; hold on
    plot(RSI_error,RSI_correct,symbol,'MarkerSize',7,'MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',12)
    plot([-1 1],[-1 1],'--','Color',[.7 .7 .7])
    ylabel('Correct')
    xlabel('Error')
    xline(0)
    yline(0)
    xticks(-.1:0.1:.2);
    yticks(-.1:0.1:.2);
    xlim([amin,amax])
    ylim([amin,amax])
    axis square
    box off
    hold off
else

end

end