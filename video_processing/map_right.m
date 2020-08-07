function peaks_map = map_right(peaks,rmap)
%Maps left channel spot locations to right channel
peaks_map = round(transformPointsInverse(rmap,peaks));
%peaks_map = peaks_map - repmat([128 0],size(peaks_map,1),1);
%peaks_map = find_local_maximum(image,peaks_map - repmat([128 0],size(peaks_map,1),1),1);
end