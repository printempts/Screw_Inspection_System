
I = imread('4.30.04.jpg'); % read the given image

try
    I1=rgb2gray(I);         %如果是rgb图，则转换成灰度图
catch
end
figure
imshow(I)
title('Orginal Image')

for K=1:10
    I1=wiener2(I1,[5 5]);   %滤波15次，把多余的点滤去
end
%I1=edge(I,'canny');       %边缘检测，得到螺纹的波形

% show image comparsion
figure (1),subplot(1, 3, 1),imshow(I),title('Original Image');          
subplot(1, 3, 2),imshow(I1),title('Grayscale of the original image');
subplot(1, 3, 3),imhist(I1),title('Gray histogram of the original image');colorbar;




