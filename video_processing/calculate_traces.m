function [traces,spots] = find_traces2(images,peaks,pixel_sum_radius,spot_image_radius)
    %Finds traces for unspecified peak structures
    %Integrate square of pixels centered on peaks
    %Square has size pixel_sum_radius
    %Also finds spot images centered on peaks with size spot_image_radius
    r = pixel_sum_radius;
    r2 = spot_image_radius;
    peaks_cell = struct2cell(peaks);
    numSpots = size(peaks_cell{1},1);
    numFrames = size(images,3);
    traces = repmat({zeros(numSpots,numFrames,'int16')},1,2);
    spots = repmat({zeros(numSpots,r2*2+1,r2*2+1,numFrames,'int16')},1,2);
    for i = 1:size(peaks_cell,1)
       for j = 1:size(peaks_cell{i},1)
           traces{i}(j,:) = sum(reshape(images(...
                                               peaks_cell{i}(j,2)-r:peaks_cell{i}(j,2)+r,... %Get y values for rows
                                               peaks_cell{i}(j,1)-r:peaks_cell{i}(j,1)+r,... %Get x values for cols 
                                               :),...                                        %Get all time steps
                                               (2*r+1)^2,[]),1);
           spots{i}(j,:,:,:) = images(...
                                      peaks_cell{i}(j,2)-r2:peaks_cell{i}(j,2)+r2,...        %Get y values for rows
                                      peaks_cell{i}(j,1)-r2:peaks_cell{i}(j,1)+r2,...        %Get x values for rows
                                      :);                                                    %Get all time steps
       end
    end
end