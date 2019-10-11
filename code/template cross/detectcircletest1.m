close all
clear
clc

%% call the exteral camera and set the resoultion
%imaqhwinfo;
%imaqtool;
%build the object
%obj = videoinput('winvideo', [3]);

%% circle detection
%rgb = getsnapshot(obj); % read the given image
rgb = imread('Camera MV-U300#189D046E-3-Snapshot-20190423221840-1668237861442.BMP');
%rgb = imread('4.jpg');
figure (1),subplot(2, 2, 1),imshow(rgb), title('Original Image')
hold on
% turn rgb image to gray image
gray_image = rgb2gray(rgb);
figure (1),subplot(2, 2, 2),imshow(gray_image),title('Gray Image')
% edge detection with Canny method.
I=edge(gray_image,'canny');  
figure (1),subplot(2, 2, 3),imshow(I),title('Edge detection with Canny method')
% circle detection 
[centers,radii] = imfindcircles(I,[140 200],'ObjectPolarity','dark', ...
    'Sensitivity',0.97)
figure (1),subplot(2, 2, 4),imshow(rgb),title('Image with circle detection')
figure (3),subplot(1, 2, 1),imshow(rgb),title('Image with circle detection by dark')
h = viscircles(centers,radii); % show the circle
[centers,radii] = imfindcircles(I,[80 100],'ObjectPolarity','bright', ...
    'Sensitivity',0.97)
figure (3),subplot(1, 2, 2),imshow(rgb),title('Image with circle detection by bright')
h = viscircles(centers,radii); % show the circle
% calculation the real circle radii
radii_real = radii/10;
