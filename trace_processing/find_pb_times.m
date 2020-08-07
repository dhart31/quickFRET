function pb_times = find_pb_times(traces,trace_params)

green_traces_ideal = traces.green_traces_ideal;
red_traces_ideal = traces.red_traces_ideal;
green_threshold = trace_params.green_threshold;
red_threshold = trace_params.red_threshold;

numFrames = size(green_traces_ideal,2);
for n = 1:size(green_traces_ideal,1)
    pb_time = find((green_traces_ideal(n,:) < green_threshold) & (red_traces_ideal(n,:) < red_threshold),1,'first');
    pb_time
    if pb_time
        pb_times{n} = pb_time - 1;
    else
        pb_times{n} =  numFrames;
    end
end
end