function f = remove_outliers(f)

high = find(f>1.2);
fret_state = zeros(length(f),1);
fret_state(high) = 1;
[end_time dwell_time up_down] = trace_stats(fret_state);

n = length(up_down);
high_blocks  =[];
for i = 1:n
    if up_down(i) == 1
        if i == 1;
            ind = [end_time(i)+1,end_time(i)+1];
            high_blocks = [high_blocks; ind];
            continue;
        end
        if i == n
            ind = [end_time(i-1),end_time(i-1)];
            high_blocks = [high_blocks; ind];
            continue;
        end
        ind = [end_time(i-1),end_time(i)+1];
        high_blocks = [high_blocks; ind];
    end 
end
s = size(high_blocks);
for i = 1:s(1)
    f(high_blocks(i,1)+1:high_blocks(i,2)-1) = mean(f(high_blocks(i,:)));
end


low = find(f<-0.2);
fret_state = zeros(length(f),1);
fret_state(low) = 1;

[end_time dwell_time up_down] = trace_stats(fret_state);

n = length(up_down);
low_blocks  =[];
for i = 1:n
    if up_down(i) == 1
        if i == 1;
            ind = [end_time(i)+1,end_time(i)+1];
            low_blocks = [low_blocks; ind];
            continue;
        end
        if i == n
            ind = [end_time(i-1),end_time(i-1)];
            low_blocks = [low_blocks; ind];
            continue;
        end
        ind = [end_time(i-1),end_time(i)+1];
        low_blocks = [low_blocks; ind];
    end 
end
s = size(low_blocks);
for i = 1:s(1)
    f(low_blocks(i,1)+1:low_blocks(i,2)-1) = mean(f(low_blocks(i,:)));
end

high = find(f>1.2); f(high) = 1;
low = find(f<-0.2); f(low) = 0;
end
