function [lmap,rmap] = generate_mapping
calibration_pairs = load('calibration2.txt');
green_points = calibration_pairs(:,1:2);
red_points = calibration_pairs(:,3:4);
sz = size(green_points);
rmap = fitgeotrans(green_points,red_points, 'affine');
lmap = fitgeotrans(red_points,green_points, 'affine');
end