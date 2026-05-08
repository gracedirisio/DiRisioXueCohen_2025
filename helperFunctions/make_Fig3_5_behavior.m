function[]=make_Fig3_5_behavior(low_data, high_data) 

%low /high data = low / high nback

low_x=low_data.x;
high_x=high_data.x;
low_y=low_data.y;
high_y=high_data.y;

low_SE_x=low_data.SE_x;
high_SE_x=high_data.SE_x;
low_SE_y=low_data.SE_y;
high_SE_y=high_data.SE_y;


low_LineFit_x=low_data.x_fit;
high_LineFit_x=high_data.x_fit;
low_LineFit_y=low_data.y_fit;
high_LineFit_y=high_data.y_fit;

measure=low_data.measure; %should be same for low and high
monkeyName=low_data.monk; %should be same for low and high

low_color=[245/256, 132/256,  38/256];   % Knicks orange for low nback
high_color=[0, 107/256, 182/256]; % blue for high nback

if monkeyName(1)=='h'
    symbol='o';
else
    symbol='^';
end

%% low nback 
figure; hold on;

% Plot points
plot(low_x, low_y, 'k', 'Marker', symbol, 'markerfacecolor', low_color, ...
    'MarkerEdgeColor', low_color, 'MarkerSize', 10, 'LineStyle', 'none');

% Plot error bars
for n = 1:numel(low_x)
    plot([low_x(n) - low_SE_x(n), low_x(n) + low_SE_x(n)], [low_y(n), low_y(n)], '-', 'color', low_color, 'LineWidth', 1);
    plot([low_x(n), low_x(n)], [low_y(n) - low_SE_y(n), low_y(n) + low_SE_y(n)], '-', 'color', low_color, 'LineWidth', 1);
end

%plot fit
plot(low_LineFit_x, low_LineFit_y, '-', 'Color', low_color, 'LineWidth', 5)
        set(gca,'linewidth',2);

%% high nback 
plot(high_x, high_y, 'k', 'Marker', symbol, 'markerfacecolor', high_color, ...
    'MarkerEdgeColor', high_color, 'MarkerSize', 10, 'LineStyle', 'none');

% Plot error bars
for n = 1:numel(high_x)
    plot([high_x(n) - high_SE_x(n), high_x(n) + high_SE_x(n)], [high_y(n), high_y(n)], '-', 'color', high_color, 'LineWidth', 1);
    plot([high_x(n), high_x(n)], [high_y(n) - high_SE_y(n), high_y(n) + high_SE_y(n)], '-', 'color', high_color, 'LineWidth', 1);
end



plot(high_LineFit_x, high_LineFit_y, '-', 'Color', high_color, 'LineWidth', 5)
        set(gca,'linewidth',2);
if measure(1)=='R'
    %rep supp (figure 3)
    plot([.5 1],zeros(1,2),'-','LineWidth',3,'Color',[.7 .7 .7])
    xlim([.5 1])
    yticks(-.25:.25:.25)
    ylim([-.25 .25])
    title('Figure 3e')
    ylabel('mean difference in normalized response')
    xlabel('proportion correct')

end

if measure(1)=='P'
    %pop consistency, figure 5
    if monkeyName(1)=='h'
            xlim([.5 1])
            ylim([.15 .65])
            yticks(.15:.1:.65)
    elseif monkeyName(1)=='z'
        xlim([.5 1])
        ylim([0 1])
        yticks(0:.25:1)
    end
    title('Figure 5f')
    ylabel('mean population correlation')
    xlabel('proportion correct')
end


end