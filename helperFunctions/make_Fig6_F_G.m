function[]=make_Fig6_F_G(data)

colors=[ 245/256, 132/256, 38/256 ;
        0,107/256,182/256];

%% no nback split
figure; hold on;
plot(data.h.asym_error,data.h.asym_correct,'MarkerFaceColor','k','Color','k','Marker','o','LineStyle','none','MarkerSize',10)
plot(median(data.h.asym_error),median(data.h.asym_correct),'MarkerFaceColor','r','Color','r','Marker','o','LineStyle','none','MarkerSize',10)
xlabel('error')
ylabel('correct')

plot(data.z.asym_error,data.z.asym_correct,'MarkerFaceColor','k','Color','k','Marker','^','LineStyle','none','MarkerSize',10)
plot(median(data.z.asym_error),median(data.z.asym_correct),'MarkerFaceColor','r','Color','r','Marker','^','LineStyle','none','MarkerSize',10)
xlabel('error')
ylabel('correct')
xline(0)
yline(0)
xlim([-1 1])
ylim([-1 1])
refline(1,0)

%significance
[h,p_H]=ttest(data.h.asym_correct,data.h.asym_error,'Tail','right');
[h,p_H_cor]=ttest(data.h.asym_correct,0,'Tail','right');
[h,p_H_err]=ttest(data.h.asym_error,0,'Tail','left');

[h,p_Z]=ttest(data.z.asym_correct,data.z.asym_error,'Tail','right');


%% nback split
figure; hold on;

plot(data.z.asymidx_e_lo,data.z.asymidx_c_lo,'MarkerFaceColor',colors(1,:),'Color',colors(1,:),'Marker','^','LineStyle','none','MarkerSize',14)
plot(data.z.asymidx_e_hi,data.z.asymidx_c_hi,'MarkerFaceColor',colors(2,:),'Color',colors(2,:),'Marker','^','LineStyle','none','MarkerSize',14)
plot(data.h.asymidx_e_lo,data.h.asymidx_c_lo,'MarkerFaceColor',colors(1,:),'Color',colors(1,:),'Marker','o','LineStyle','none','MarkerSize',14)
plot(data.h.asymidx_e_hi,data.h.asymidx_c_hi,'MarkerFaceColor',colors(2,:),'Color',colors(2,:),'Marker','o','LineStyle','none','MarkerSize',14)

xline(0)
yline(0)
xlim([-1 1])
ylim([-1 1])
refline(1,0)
xlabel('error')
ylabel('correct')

% % Medians for low n-back
error_low = [data.h.asymidx_e_lo, data.z.asymidx_e_lo];
correct_low = [ data.h.asymidx_c_lo,data.z.asymidx_c_lo];


% Medians for high n-back
error_high = [data.h.asymidx_e_hi,data.z.asymidx_e_hi];
correct_high = [data.h.asymidx_c_hi, data.z.asymidx_c_hi];


% 

[h,p_low]=ttest(correct_low,error_low,'Tail','right');
[h,p_hi]=ttest(correct_high,error_high,'Tail','right');
[h,p_cor_lo]=ttest(correct_low,0,'Tail','right');
[h,p_cor_hi]=ttest(correct_high,0,'Tail','right');
[h,p_err_hi]=ttest(error_high,0,'Tail','left');
[h,p_err_lo]=ttest(error_low,0,'Tail','left');



end