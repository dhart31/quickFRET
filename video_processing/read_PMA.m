function images = read_PMA(file)
% Converts PMA file into a uint16 3D matlab array. x,y represent image, z
% represent frames
f = fopen(file,'r');
s = dir(file);
imagesize = fread(f,2,'uint16');
n_frames = uint16(floor(s.bytes/(prod(imagesize)*2+2)));
images = zeros(imagesize(1),imagesize(2),n_frames,'uint16');
for i = 1:n_frames
    frame = fread(f,1,'uint16');
    images(:,:,i) = uint16(reshape(fread(f,prod(imagesize),'uint16'),imagesize')');
end
fclose(f);
end