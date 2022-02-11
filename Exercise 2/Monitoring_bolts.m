close all
clear all
%a)
I = im2double(imread('input_image.png'));
figure
imshow(I)
%b)
h_r = fspecial('sobel');
h_c = h_r';
I_x = imfilter(I,h_c);
I_y = imfilter(I,h_r);
I_mag = sqrt(I_x.^2+I_y.^2);
I_dir = rad2deg(atan(I_x./I_y));
%c)
im_hist = imhist(I);
[bg_count bg_c] = max(im_hist);
thr = 30/255;
bg_c = bg_c/255;
mask = I > bg_c+thr | I < bg_c-thr;
%d)
B = strel('disk',5);
mask = imclose(mask,B);
%e)
labelled = bwlabel(mask);
%f)
bolts = 0;
for i=1:max(labelled(:))
%f.I)
mask_obj_i = (labelled == i);
%f.II)
[r c] = find(mask_obj_i);
b = 10;
r_max = min(max(r)+b,size(I,1));
c_max = min(max(c)+b,size(I,2));
r_min = max(min(r)-b,1);
c_min = max(min(c)-b,1);
crop_mag = I_mag(r_min:r_max,c_min:c_max);
crop_dir = I_dir(r_min:r_max,c_min:c_max);
%f.III)
angle_v = crop_dir(crop_mag>0.2*max(crop_mag(:)));
%f.IV)
[h_angle,x] = hist(angle_v,[-90 -60 -30 0 30 60 90]);
h_angle(1) = h_angle(1) + h_angle(end);
h_angle = h_angle(1:end-1);
h_angle = sort(h_angle,'d');
if(h_angle(1) > 2*median(h_angle))
bolts = bolts+1;
end
end