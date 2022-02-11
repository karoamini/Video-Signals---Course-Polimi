clc
close all
clear all
%a)
I_RGB = imread('test_img.png');
%b)
I_RGB = imresize(I_RGB,[256 256]);
figure()
imshow(I_RGB)
%c)
I_HSV = rgb2hsv(I_RGB);
%d)
V = I_HSV(:,:,3);
min_v = min(V(:));
max_v = max(V(:));
V_new = (V - min_v)/(max_v - min_v);
%e)
I_HSV_2 = I_HSV;
I_HSV_2(:,:,3) = V_new;
I_RGB_2 = hsv2rgb(I_HSV_2);
%f)
R = histeq(I_RGB_2(:,:,1));
G = histeq(I_RGB_2(:,:,2));
B = histeq(I_RGB_2(:,:,3));
I_RGB_3(:,:,1) = R;
I_RGB_3(:,:,2) = G;
I_RGB_3(:,:,3) = B;
%g)
h = fspecial('gaussian',3,0.5);
R = imfilter(R,h,'symmetric','conv');
G = imfilter(G,h,'symmetric','conv');
B = imfilter(B,h,'symmetric','conv');
I_RGB_4(:,:,1) = R;
I_RGB_4(:,:,2) = G;
I_RGB_4(:,:,3) = B;
%h)
figure()
imshow(I_RGB_4)