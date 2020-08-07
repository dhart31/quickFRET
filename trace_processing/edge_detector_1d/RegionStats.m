function [ stats ] = RegionStats( data, regionIdx, radius )
% [ stats ] = RegionStats( data, regionIdx )
% Finds statistics for data broken up into distinct regions.
% Input:
%   data        The data to analyze
%   regionIdx   The indices that demarcate distinct data regions
%   radius      The radius of transition regions (data within transition  
%               regions is excluded from statistics)

if (nargin < 3)
    radius = 1;
end
if max(data) < 2
    fret = 1;
else
    fret= 0;
end

region = 1:regionIdx(1)-radius;
stats(1, :) = [mean(data(region)), std(data(region))];

% JJ mod
% start_region = regionIdx(1)+radius;
% end_region = regionIdx(2)-radius;
% region = start_region:end_region;
% if mean(data(region)) < 0.45
%     init = 0;
% else
%     init = 1;
% end
%

for i = 2:length(regionIdx)
    start_region = regionIdx(i-1)+radius;
    end_region = regionIdx(i)-radius;
    region = start_region:end_region;
    if end_region - start_region > 10
        region = region(5:end-5);
    end
    
    stats(i, :) = [mean(data(region)), std(data(region))];
    if fret == 1
        if abs(diff([stats(i-1,1), stats(i,1)])) < 0.1
            stats(i,1) = stats(i-1,1);
        end
    end
%     if fret == 1
%         thre = jj_gmd2(data(50:end-50));
%         if thre(2) == 1;
%             stats(i,1) = 0.2;
%         else
%             if stats(i,1) < thre(1)
%                 stats(i,1) = 0.2;
%             else
%                 stats(i,1) = 0.8;
%             end
%         end
%     end
end
    
region = regionIdx(end)+radius:length(data);
stats(end+1, :) = [mean(data(region)), std(data(region))];
x= 1;
