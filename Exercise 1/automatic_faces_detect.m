clc
close all
clear all
n = 100;
%1.a)
for i=1:n
I = imread(sprintf('facesdb/%03d.jpg',i)); %1.b)
I_hsv = rgb2hsv(I); I_h = I_hsv(:,:,1);
I_s = I_hsv(:,:,2);
avg_h(i) = median(I_h(:));
avg_s(i) = median(I_s(:));
end
%1.c)
mean_h=mean(avg_h);
mean_s=mean(avg_s);
std_h=std(avg_h);
std_s=std(avg_s);
%2.a)
I = imread('input_image.jpg');
imshow(I)
%2.b)
I_hsv = rgb2hsv(I);
mask = I_hsv(:,:,1)>mean_h-1.5*std_h & I_hsv(:,:,1)<mean_h+1.5*std_h & ...
I_hsv(:,:,2)>mean_s-1.5*std_s & I_hsv(:,:,2)<mean_s+1.5*std_s;
%2.c)
SE_1 = strel('square',15);
mask = imclose(mask,SE_1);
%2.d)
SE_2 = strel('disk',10);
A = imresize(SE_2.Neighborhood,[30,20]);
SE_2 = strel('arbitrary',A);
mask = imopen(mask,SE_2);
%2.e)
face_pixeled = imresize(I, 0.1);
face_pixeled = imresize(face_pixeled, [size(I,1) size(I,2)], 'nearest');
%2.f)
face_out = face_pixeled.*uint8(mask) + I.*uint8(1-mask);
figure
imshow(face_out)