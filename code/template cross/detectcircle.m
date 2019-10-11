
close all
clear
clc

%% call the exteral camera and set the resoultion
%imaqhwinfo;
%imaqtool;
%build the object
obj = videoinput('winvideo', [3]);

%% circle detection 
rgb = getsnapshot(obj); % read the given image
figure(1)
imshow(rgb)
I = rgb2gray(rgb);
I=edge(I,'canny');

%[A,B,C]=hough_circle(I,200,360,500,600,0.95)

%I=edge(gray_image,'canny');       %±ßÔµ¼ì²â£¬µÃµ½ÂÝÎÆµÄ²¨ÐÎ

[centers,radii] = imfindcircles(I,[100 160],'ObjectPolarity','dark', ...
    'Sensitivity',0.95)

figure (2)
imshow(rgb)
h = viscircles(centers,radii);
