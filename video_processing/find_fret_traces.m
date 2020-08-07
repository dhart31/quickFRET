function fret_traces = find_fret_traces(green_traces,red_traces)
    n = size(green_traces,1);
    fret_traces = zeros(size(green_traces));
    for i = 1:n
        donor = green_traces(i,:);
        acceptor = red_traces(i,:);
        fret_trace  = (acceptor)./(donor+acceptor);
        fret_traces(i,:) = remove_outliers(fret_trace);
    end
end