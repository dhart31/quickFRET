function spots = find_spots(image,spot_params)
%1) Finds max spot above thresh and inside border region (w px from edge)
%2) Replaces spot with zero square (nhood_size x nhood_size)
%   nMax specifies max number of located spots
n = 0;
spots = [];
threshold = spot_params.threshold;
r0 = spot_params.min_separation;
nMax = spot_params.nMax;
w = spot_params.boundary;
while n<=nMax
    [I,sub]=max(image(:));
    [r,c] = ind2sub(size(image),sub);
    if I > threshold
        if [r c] > [w w] & [r c] < [256-w 128-w]
            n = n+1;
            spots = [spots; [r c]];
        end
        image(max(1,r-r0):min(size(image,1),r+r0),...
            max(1,c-r0):min(size(image,2),c+r0)) = 0;
    else
        break;
    end
end
spots = flip(spots,2);
end