function[cc]=make_Fig5a(data)


%calculate population correlation
cc=corrcoef(data.pres1, data.pres2);
cc=cc(1,2);
if data.correct==1
    title_str=['Fig 5a: r=' num2str(cc), ', Correct trial'];
elseif data.correct~=1
    title_str=['Fig 5a: r=' num2str(cc), ', error trial'];
end

figure;hold on
plot(data.pres1, data.pres2,'ko','MarkerFaceColor','k')
xlim([0 1.1])
ylim([0 1.1])
refline(1,0)
title(title_str)
xlabel('normalized response, presentation 1')
ylabel('normalized response, presentation 2')
axis square; box off; hold off;

end