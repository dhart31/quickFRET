function bg = find_background(spot_images,frames)
    %Calculates the median pixel value for every spot subimage stack (4D array:idx,x,y,t)
    numSpots = size(spot_images,1);
    bg = median(reshape(spot_images(:,:,:,frames),numSpots,[]),2);
end