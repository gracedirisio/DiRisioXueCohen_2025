function[]=make_Fig3_singlesession(data)

symbol='^';
orange = [245/256, 132/256,  38/256];   % Knicks orange
blue   = [0,107/256, 182/256];
nback_plot=0;

if isfield(data,'low_Correct')
    nback_plot=1;
end

if nback_plot==0
    RSI_error=data.error;
    RSI_correct=data.Correct;
    amin=-0.1;
    amax=0.2;
    
    figure; hold on
    plot(RSI_error,RSI_correct,symbol,'MarkerSize',7,'MarkerFaceColor','k','MarkerEdgeColor','w','MarkerSize',12)
    plot([-1 1],[-1 1],'-','Color',[.3 .3 .3])
    ylabel('Correct')
    xlabel('Error')
    xline(0)
    yline(0)
    xticks(-.2:0.1:.3);
    yticks(-.2:0.1:.3);
    xlim([-.1,.2])
    xlim([-.1,.2])

    axis square
    box off
    hold off


else
    x=1;

    figure; hold on
    plot(data.low_error,data.low_Correct,symbol,'MarkerSize',7,'MarkerFaceColor',orange ,'MarkerEdgeColor','w','MarkerSize',12)
    plot(data.high_error,data.high_Correct,symbol,'MarkerSize',7,'MarkerFaceColor',blue ,'MarkerEdgeColor','w','MarkerSize',12)
    plot([-1 1],[-1 1],'-','Color',[.3 .3 .3])
    ylabel('Correct')
    xlabel('Error')
    xline(0)
    yline(0)
    xticks(-.2:0.1:.3);
    yticks(-.2:0.1:.3);
    xlim([-.2,.3])
    ylim([-.2,.3])

    axis square
    box off
    hold off
   
    

end

end