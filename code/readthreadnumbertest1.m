
I = imread('4.30.04.jpg'); % read the given image

try
    I1=rgb2gray(I);         %�����rgbͼ����ת���ɻҶ�ͼ
catch
end
figure
imshow(I)
title('Orginal Image')

for K=1:10
    I1=wiener2(I1,[5 5]);   %�˲�15�Σ��Ѷ���ĵ���ȥ
end
%I1=edge(I,'canny');       %��Ե��⣬�õ����ƵĲ���

% show image comparsion
figure (1),subplot(1, 3, 1),imshow(I),title('Original Image');          
subplot(1, 3, 2),imshow(I1),title('Grayscale of the original image');
subplot(1, 3, 3),imhist(I1),title('Gray histogram of the original image');colorbar;




