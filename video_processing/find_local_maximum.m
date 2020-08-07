function new_locations = find_local_maximum(image,map_locations,window)
    w = window;
    new_locations = zeros(size(map_locations));
    for i = 1:size(map_locations,1)
       x = map_locations(i,1);
       y = map_locations(i,2);
       x,y
       image_region = image(max(1,y-w):min(256,y+w),max(1,x-w):min(256,x+w));
       [~,max_index] = max(image_region(:));
       [yc,xc] = ind2sub(size(image_region),max_index);
      new_locations(i,1) = x + xc - (w+1);
      new_locations(i,2) = y + yc - (w+1);
    end
end