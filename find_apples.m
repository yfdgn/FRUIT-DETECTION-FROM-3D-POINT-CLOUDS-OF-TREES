
% Load the point cloud data
load('ptCloud_ROI_234_s.mat')
point_cloud = ptCloud_ROI;

figure(1)
subplot(2,3,1);
pcshow(point_cloud);
title('Original Raw Data');
axis on;

green_channel = point_cloud.Color(:,2);

green_indices = find(green_channel > 200);
ptCloudGreen = select(point_cloud,green_indices);


%pcshow(ptCloudGreen);


% Extract the red channel of the point cloud
red_channel = ptCloudGreen.Color(:,1);

% Find the indices of the red points
red_indices = find(red_channel < 200);
ptCloudRed_Green = select(ptCloudGreen,red_indices);



%pcshow(ptCloudRed_Green);


blue_channel = ptCloudRed_Green.Color(:,3);
blue_indices = find(blue_channel < 150);
ptCloudRed_Green_Blue = select(ptCloudRed_Green,blue_indices);

ptCloudGreenSegmented = ptCloudRed_Green_Blue;

subplot(2,3,2);
pcshow(ptCloudGreenSegmented);
title('Green (RGB) Filtered Data');
axis on;

point_cloud2 = ptCloudGreenSegmented;


%
%orijinal data 
hsv1 = rgb2hsv((double(point_cloud.Color))/255);
hsv1 = hsv1*255;

hue_rd = hsv1(:,1);
sat_rd = hsv1(:,2);

%yeşil rgbden çıkan data
hsv2 = rgb2hsv((double(point_cloud2.Color))/255);
hsv2 = hsv2*255;

hue_gr = hsv2(:,1);
sat_gr = hsv2(:,2);

green_apple_indices = find((hue_gr>=40 & hue_gr<=70) & ( sat_gr>=120 & sat_gr<=220 )); %finding red and green apple indices

green_ptCloud_seg = select(point_cloud2,green_apple_indices); % segmented apples from original cloud
%|& ( sat>120 & sat<160 )

subplot(2,3,3);
pcshow(green_ptCloud_seg);
title('Green (RGB + HSV) Filtered Data');
axis on;
% 
red_apple_indices = find((hue_rd >0 & hue_rd<20) & ( sat_rd>150 & sat_rd<200 )); %finding red and green apple indices
red_ptCloud_seg = select(point_cloud,red_apple_indices); % segmented apples from original cloud

subplot(2,3,4);
pcshow(red_ptCloud_seg);
title('Red HSV Filtered Data');
axis on;

merged = pcmerge(red_ptCloud_seg,green_ptCloud_seg,0.001)

subplot(2,3,5);
pcshow(merged)
title('Apple Segmented Data');
axis on;

pcwrite(merged,'ptCloud_ROI_234_s_SEGMENTED.ply','Encoding','ascii');