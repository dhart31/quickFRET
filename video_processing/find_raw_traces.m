function [traces] = find_raw_traces(images,spots,pixel_sum_radius)
    r = pixel_sum_radius;
    numSpots = size(spots,1);
    numFrames = size(images,3);
    traces = zeros(numSpots,numFrames,'double');
    
    bg_idx = padarray(zeros(3,3,'logical'),[1 1],1,'both');
    spot_idx = ~repmat(bg_idx,1,1,numFrames);
    bg_idx([1 5 21 25]) = 0;
    bg_idx = repmat(bg_idx,1,1,numFrames);
    for i = 1:numSpots
        x = spots(i,1);
        y = spots(i,2);
        spot_images = double(images((y-(r+1)):(y+(r+1)),(x-(r+1)):(x+(r+1)),:));
        traces(i,:) = sum(reshape(spot_images(spot_idx),9,[]),1) - 9*median(reshape(spot_images(bg_idx),12,[]));
        
    end
end