function[]=make_Fig2c(data)

%0 nback = novel

x_vals=[0, data.nback_condition];
yvals=[data.novel_mean, data.nback_mean];
y_SEM=[data.novel_sem, data.nback_sem];
if data.monkey(1)=='z'
    symbol='^';
else
    symbol='o';

end

figure; hold on;
title(['Monkey: ', data.monkey])
errorbar(0, data.novel_mean, data.novel_sem, 'k-', 'Marker', symbol, ...
             'LineWidth', 2, 'MarkerFaceColor', 'k', 'MarkerSize', 10);
errorbar(1:5, data.nback_mean, data.nback_sem, 'k-', 'Marker', symbol, ...
             'LineWidth', 2, 'MarkerFaceColor', 'k', 'MarkerSize', 10);
ylim([0 1])
yline(.5)
xticks(0:5);
xticklabels([{'0'}, {'1','2','4','8','16'}]);
ylabel('proportion correct (weighted average across sessisons)')
xlabel('nback')


end