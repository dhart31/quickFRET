%% Use raw traces from video processing to get HMM states
trace_params.edge_scale = 8;       %See AnalyzeEdges
trace_params.edge_threshold = 0.15;%See AnalyzeEdges
trace_params.cutoff = 20;          %Cutoff segment of trace
trace_params.min_frames = 200;     %Remove truncated traces below this min frame length
trace_params.green_threshold = 50; %Select green & red min thresholds for photobleaching
trace_params.red_threshold = 50;
num_traces = size(traces.fret_traces,1);
num_frames = size(traces.fret_traces,2);
%Get idealized traces
[traces.green_traces_ideal,traces.red_traces_ideal,traces.fret_traces_ideal] = find_ideal_traces(traces,trace_params);
%Get photobleaching times using idealized traces
traces.pb_times = find_pb_times(traces,trace_params)';
%% Get HMM traces
fret_traces_cell = mat2cell(movmean(traces.fret_traces,2,2),ones(1,num_traces));
fret_traces_cell = cellfun(@(v,w) v(:,1:min(w,num_frames-trace_params.cutoff)),fret_traces_cell,traces.pb_times,'UniformOutput',false);
idx = cell2mat(cellfun(@length,fret_traces_cell,'UniformOutput',false))>min_frames;
traces.hmm_states = cell(233,1);
traces.hmm_traces = cell(233,1);
[traces.hmm_states(idx),traces.hmm_traces(idx)] = get_HMM_trace(fret_traces_cell(idx));
%% Look at traces: scroll through them with up/down, select trace with spacebar, save selected idx with 's'
locations = display_fret_traces(traces)
%% Collect statistics from traces
traces.hmm_states_selected = traces.hmm_traces(locations);
endtime = cell(size(traces.hmm_states_selected));
dwelltime = cell(size(traces.hmm_states_selected));
up_down = cell(size(traces.hmm_states_selected));
for i = 1:size(traces.hmm_states_selected,1)
[endtime{i},dwelltime{i},up_down{i}] = trace_stats(traces.hmm_states_selected{i}==max(traces.hmm_states_selected{i}))
end
%%
bound_times = cell2mat(cellfun(@(v,w) v(w==1),dwelltime,up_down,'UniformOutput',false))
unbound_times = cell2mat(cellfun(@(v,w) v(w==0), dwelltime,up_down,'UniformOutput',false));
%%
[y,x]=cum_hist(bound_times,1,'off',0.1);
semilogy(x,y,'k','LineWidth',2); hold on; 
f = fit(x,y,'exp1')
axis square;
semilogy(x,feval(f,x),'k--','LineWidth',2)
xlabel('Time (seconds)')
xlim([0 200])
ylim([10^-2 1])
ylabel('Normalized Count')
set(gca,'FontSize',20)
set(gca,'LineWidth',2)
%set(gca,'FontName','Times New Roman')
%set(gca, 'Units', 'normalized', 'Position', [0.1, 0.1,.6,.6]);
set(gcf,'Units','normalized','Position',[0,0,.5,.5])
title('Dwell Time Distribution')
legend('Raw data',['Fit (\tau = ' num2str(round(-1/f.b,1)) ')'])