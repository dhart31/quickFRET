function [y,x]=cum_hist(A,bin_size,ploton,spf)
ploton = lower(ploton);
% bin_size in frames
% bin_size = ceil(max(A)/bin_num);
% bin_size = max(A)/(bin_num-2);
% bin_size = 1000/(bin_num);
% n_counts = zeros(bin_num,2);
range = 0;
test = [];
% for i=1:bin_num
% while range < 201
while range < max(A)
    temp = length(find(A>=range));
    test = [test;[temp range]];
%     c = histc(A, [range, max(A)+.1]);
%     n_counts(i,1) = c(1);
%     n_counts(i,2) = range;
    range = range+bin_size;
%     if range > max(A)
%         range = max(A);
%     end
end
n_counts = test;
%normalize
n_counts(:,1)= n_counts(:,1)/max(n_counts(:,1));
y=n_counts(:,1);
x=n_counts(:,2);
%%
% x = x*.04/60;
% x = x*.05/60;
% x = x*.1/60;
% x = x*.2/60;
% x = x*.5/60;
x = x*spf;
% y= 1-y;
%%
if strcmp(ploton,'on')
    figure;
    bar(x,y,'histc');
    objects = findobj('type','line');%get(gca,'children');
%     plot(x,y,'o');
    delete(objects);
%     set(gca,'XTickLabel',get(gca,'XTick')*bin_size);
elseif strcmp(ploton,'off')
    return;
else
    disp('Wrong input3: plot ''on'' or ''off''')
end
