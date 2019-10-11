clc;
clear all;

rgb = imread('1.bmp');
imshow(rgb)
hold on

gray_image = rgb2gray(rgb);
imshow(gray_image)

I=edge(gray_image,'canny');       %��Ե��⣬�õ����ƵĲ���

[centers,radii] = imfindcircles(I,[320 400],'ObjectPolarity','dark', ...
    'Sensitivity',0.97)


imshow(rgb)
h = viscircles(centers,radii);
