function [green_traces_ideal,red_traces_ideal,fret_traces_ideal] = find_ideal_traces(traces,trace_params)
green_traces = traces.green_traces;
red_traces = traces.red_traces;
fret_traces = traces.fret_traces;
edge_scale = trace_params.edge_scale;
edge_threshold = trace_params.edge_threshold;
green_traces_ideal = zeros(size(green_traces));
red_traces_ideal = zeros(size(red_traces));
fret_traces_ideal = zeros(size(fret_traces));
for n = 1:size(green_traces,1)
    green_traces_ideal(n,:) = idealizedPath(green_traces(n,:),edge_scale,edge_threshold);
    red_traces_ideal(n,:) = idealizedPath(red_traces(n,:),edge_scale,edge_threshold);
    fret_traces_ideal(n,:) = idealizedPath(fret_traces(n,:),edge_scale,edge_threshold);
end