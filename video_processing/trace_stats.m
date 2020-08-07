function [end_time dwell_time up_down] = trace_stats(fret_state)
n  = length(fret_state);
ind = zeros(1);
j = 1;
for i = 1:n-1
    if fret_state(i)~= fret_state(i+1)
        ind(1,j) = i;
        j = j+1;
    end
end
if j == 1
    end_time = [length(fret_state)]';
    up_down = [fret_state(end)]';
    dwell_time = diff([0 end_time'])';
    return
end
start_t=1;end_t=ind(1);
n = length(ind);
if n == 1
    ind(2,1) = round(mean(fret_state(start_t:end_t)));
else
    first_state = round(mean(fret_state(start_t:end_t)));
    if first_state == 1
        for i = 1:n
            ind(2,i) = mod(i,2);
        end
    else
        for i = 1:n
            ind(2,i) = ~mod(i,2);
        end
    end
end
end_time = [ind(1,:) length(fret_state)]';
up_down = [ind(2,:) fret_state(end)]';
dwell_time = diff([0 end_time'])';