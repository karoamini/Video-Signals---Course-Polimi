%a)
img = imread('test_img.png');
img_gray = rgb2gray(img);
figure
imshow(img_gray)
%b)
ent = zeros(size(img_gray));
%c)
grid_size = 8;
for i=1:grid_size:size(img_gray,1)
for j=1:grid_size:size(img_gray,2)
I = img_gray(i:(i+grid_size-1),j:(j+grid_size-1));
%c1)
p = imhist(I);
p = p/numel(I);
%c2)
entropy = -sum(p.*log2(p+1e-6));
%c3)
ent(i:(i+grid_size-1),j:(j+grid_size-1)) = entropy;
end
end
%d)
ent = (ent-min(ent(:)))/(max(ent(:))-min(ent(:)));
mask = im2bw(ent,0.5);
%d)
se = strel('disk', 20);
mask = imclose(mask, se);
mask = imopen(mask, se);
%f)
img = img .* uint8(mask);
figure
imshow(img)