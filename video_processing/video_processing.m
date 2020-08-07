images = read_PMA('E:\matlab\100mMTris100mmNacl8pH_22C_20nMprobe1\trial1\1-noforce\Ixon39_100ms.pma');
frames = 25:35;
%%
% 1) Find spots using image average spanning variable frames
image_average = mean(images(:,:,frames),3);
green_channel = image_average(:,1:128);
red_channel =   image_average(:,129:256);
spot_params.threshold = 250;%mean(green_channel(:))+std(green_channel(:));
spot_params.min_separation = 5;
spot_params.boundary = 10;
spot_params.nMax = 300;

green_spots = find_spots(green_channel,spot_params);
[rmap,lmap] = generate_mapping;
red_spots = map_right(green_spots,rmap);
red_spots = find_local_maximum(image_average,red_spots,1);
imshow(mean(images(:,:,80:100),3),[]); hold on;
plot(green_spots(:,1),green_spots(:,2),'go');
plot(red_spots(:,1),red_spots(:,2),'ro')
%%
traces.green_traces = find_raw_traces(images,green_spots,1);
traces.red_traces = find_raw_traces(images,red_spots,1);
traces.fret_traces = find_fret_traces(traces.green_traces,traces.red_traces);
%%
n = 221;
subplot(2,1,1)
plot(green_traces(n,:),'g'); hold on;
plot(red_traces(n,:),'r')
subplot(2,1,2);
plot(fret_traces(n,:),'b');