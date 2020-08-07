function locations = display_fret_traces(traces)
green_traces = traces.green_traces;
green_traces_ideal = traces.ideal_green_traces;
red_traces = traces.ideal_red_traces;
red_traces_ideal = traces.ideal_red_traces;
fret_traces = traces.fret_traces;
fret_traces_ideal = traces.ideal_fret_traces;
hmm_traces = traces.hmm_traces;
pb_times = traces.pb_times;
k = 1;
m = 2;
fig = gcf;
ha = tight_subplot(3,1,[0 0.05],[0.05 0.05],[0.06 0.05])
axes(ha(1));
h1 = plot(green_traces(k,:),'g'); hold on;
h2 = plot(green_traces_ideal(k,:),'k--','LineWidth',m);
set(ha(1),'XTickLabel',[]);
set(ha(1),'XLim',[1 3101]);
h3 = plot(red_traces(k,:),'r');
h4 = plot(red_traces_ideal(k,:),'k--','LineWidth',m);
h5 = plot([pb_times{k} pb_times{k}],ylim,'k','LineWidth',1);
axes(ha(2));
h6 = plot(fret_traces(k,:),'b'); hold on;
h7 = plot(fret_traces_ideal(k,:),'k--','LineWidth',m);
set(ha(2),'XTickLabel',[]);
set(ha(2),'XLim',[1 3101]);
axes(ha(3));
h8 = plot(1:size(hmm_traces{k},1),hmm_traces{k},'r');
ylim([-0.2 1.2])
max_k = size(green_traces,1);
hmm_selected_idx = zeros(num_traces,1);
while k <= max_k
    title(ha(1),num2str(hmm_selected_idx(k)))
    set(h1,'YData',green_traces(k,:))
    set(h2,'YData',green_traces_ideal(k,:))
    set(h3,'YData',red_traces(k,:))
    set(h4,'YData',red_traces_ideal(k,:))
    set(ha(1),'YLim',[min([green_traces(k,:) red_traces(k,:)]) max([green_traces(k,:) red_traces(k,:)])]);
    set(h5,'XData',[pb_times{k} pb_times{k}]);
    set(h6,'YData',movmean(fret_traces(k,:),2));
    set(ha(2),'YLim',[min(fret_traces(k,:)) max(fret_traces(k,:))]);
    set(h7,'YData',fret_traces_ideal(k,:));
    set(h8,'XData',1:size(hmm_traces{k},1));
    set(h8,'YData',hmm_traces{k});
    set(ha(3),'XLim',[1 3101]);
    set(ha(3),'YLim',[min(fret_traces(k,:)) max(fret_traces(k,:))]);
    was_a_key = waitforbuttonpress;
    if was_a_key && strcmp(get(fig, 'CurrentKey'), 'uparrow')
      k = max(1,k - 1);
    elseif was_a_key && strcmp(get(fig,'CurrentKey'),'downarrow')
      k = k + 1;
    elseif was_a_key && strcmp(get(fig,'CurrentKey'),'space')
        if hmm_selected_idx(k) == 0
            disp('marked');
            hmm_selected_idx(k) = 1;
        else
            disp('unmarked');
            hmm_selected_idx(k) = 0;
        end
    end
end
end