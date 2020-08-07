function [path stats]= idealizedPath(data, edge_scale, edge_threshold)
if max(data) < 2
    fret = 1;
else
    fret= 0;
end
fret = 0;
[d minmax stats] = AnalyzeEdges(data,edge_scale,edge_threshold);
if fret == 1;
    
    k = 1;
    index = [];
    for i = 1:length(stats)-1
        if stats(i) == stats(i+1)
            index(k) = i+1;
            k = k+1;
        end
    end
    if ~isempty(index)
        minmaxIdx = find(minmax);
        minmaxIdx(index-1) = [];
        stats(index) = [];
    else
        minmaxIdx = find(minmax);
    end
    
    time =  1:length(minmax);    
    
    path = zeros(length(time),1);
    path(:,1) = stats(end,1);
    s = 1;
    
    
    updown = 0;
    if stats(1) > stats(2)
        updown = 1;
    elseif stats(1) < stats(2)
        updown = 0;
    end
    for i = 1:length(minmaxIdx)
        if updown == 1
            path(s:minmaxIdx(i),1)= 0.8;
            updown = 0;
        elseif updown == 0
            path(s:minmaxIdx(i),1)= 0.2;
            updown = 1;
        end
        
        s = minmaxIdx(i);
    end
else
        
    time =  1:length(minmax);
    minmaxIdx = find(minmax);
    
    
    path = zeros(length(time),1);
    path(:,1) = stats(end,1);
    s = 1;
    
    
    
    for i = 1:length(minmaxIdx)
        path(s:minmaxIdx(i),1)= stats(i);
       
        s = minmaxIdx(i);
    end
end

