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
figure (1),subplot(2, 2, 1),imshow(rgb), title('Original Image')
hold on
% turn rgb image to gray image
gray_image = rgb2gray(rgb);
%% edge detection with Sobel (default) method.
I=edge(gray_image,'Sobel');  
figure (2),subplot(4, 4, 1),imshow(I),title('Edge detection with Sobel (default) method')
figure (3),subplot(4, 4, 1),imshow(I),title('Edge detection with Sobel (default) method')
% circle detection 
[centers,radii] = imfindcircles(I,[120 160],'ObjectPolarity','dark', ...
    'Sensitivity',0.97)
figure (2),subplot(4, 4, 2),imshow(rgb),title('Image with circle detection by dark')
h = viscircles(centers,radii); % show the circle

[centers,radii] = imfindcircles(I,[80 100],'ObjectPolarity','bright', ...
    'Sensitivity',0.97)
figure (3),subplot(4, 4, 2),imshow(rgb),title('Image with circle detection by bright')
h = viscircles(centers,radii); % show the circle
% calculation the real circle radii
radii_real1 = radii/44;

%% edge detection with Prewitt method.
I=edge(gray_image,'Prewitt');  
figure (2),subplot(4, 4, 3),imshow(I),title('Edge detection with Prewitt method')
figure (3),subplot(4, 4, 3),imshow(I),title('Edge detection with Prewitt method')
% circle detection 
[centers,radii] = imfindcircles(I,[120 160],'ObjectPolarity','dark', ...
    'Sensitivity',0.97)
figure (2),subplot(4, 4, 4),imshow(rgb),title('Image with circle detection by dark')
h = viscircles(centers,radii); % show the circle

[centers,radii] = imfindcircles(I,[80 100],'ObjectPolarity','bright', ...
    'Sensitivity',0.97)
figure (3),subplot(4, 4, 4),imshow(rgb),title('Image with circle detection by bright')
h = viscircles(centers,radii); % show the circle
% calculation the real circle radii
radii_real2 = radii/44;

%% edge detection with Roberts method.
I=edge(gray_image,'Roberts');  
figure (2),subplot(4, 4, 5),imshow(I),title('Edge detection with Roberts method')
figure (3),subplot(4, 4, 5),imshow(I),title('Edge detection with Roberts method')
% circle detection 
[centers,radii] = imfindcircles(I,[120 160],'ObjectPolarity','dark', ...
    'Sensitivity',0.97)
figure (2),subplot(4, 4, 6),imshow(rgb),title('Image with circle detection by dark')
h = viscircles(centers,radii); % show the circle

[centers,radii] = imfindcircles(I,[80 100],'ObjectPolarity','bright', ...
    'Sensitivity',0.97)
figure (3),subplot(4, 4, 6),imshow(rgb),title('Image with circle detection by bright')
h = viscircles(centers,radii); % show the circle
% calculation the real circle radii
radii_real3 = radii/44;

%% edge detection with log method.
I=edge(gray_image,'log');  
figure (2),subplot(4, 4, 7),imshow(I),title('Edge detection with log method')
figure (3),subplot(4, 4, 7),imshow(I),title('Edge detection with log method')
% circle detection 
[centers,radii] = imfindcircles(I,[120 160],'ObjectPolarity','dark', ...
    'Sensitivity',0.97)
figure (2),subplot(4, 4, 8),imshow(rgb),title('Image with circle detection by dark')
h = viscircles(centers,radii); % show the circle

[centers,radii] = imfindcircles(I,[80 100],'ObjectPolarity','bright', ...
    'Sensitivity',0.97)
figure (3),subplot(4, 4, 8),imshow(rgb),title('Image with circle detection by bright')
h = viscircles(centers,radii); % show the circle
% calculation the real circle radii
radii_real4 = radii/44;

%% edge detection with zerocross method.
I=edge(gray_image,'zerocross');  
figure (2),subplot(4, 4, 9),imshow(I),title('Edge detection with zerocross method')
figure (3),subplot(4, 4, 9),imshow(I),title('Edge detection with zerocross method')
% circle detection 
[centers,radii] = imfindcircles(I,[120 160],'ObjectPolarity','dark', ...
    'Sensitivity',0.97)
figure (2),subplot(4, 4, 10),imshow(rgb),title('Image with circle detection by dark')
h = viscircles(centers,radii); % show the circle

[centers,radii] = imfindcircles(I,[80 100],'ObjectPolarity','bright', ...
    'Sensitivity',0.97)
figure (3),subplot(4, 4, 10),imshow(rgb),title('Image with circle detection by bright')
h = viscircles(centers,radii); % show the circle
% calculation the real circle radii
radii_real5 = radii/44;

%% edge detection with Canny method.
I=edge(gray_image,'Canny');  
figure (2),subplot(4, 4, 11),imshow(I),title('Edge detection with Canny method')
figure (3),subplot(4, 4, 11),imshow(I),title('Edge detection with Canny method')
% circle detection 
[centers,radii] = imfindcircles(I,[120 160],'ObjectPolarity','dark', ...
    'Sensitivity',0.97)
figure (2),subplot(4, 4, 12),imshow(rgb),title('Image with circle detection by dark')
h = viscircles(centers,radii); % show the circle

[centers,radii] = imfindcircles(I,[80 100],'ObjectPolarity','bright', ...
    'Sensitivity',0.97)
figure (3),subplot(4, 4, 12),imshow(rgb),title('Image with circle detection by bright')
h = viscircles(centers,radii); % show the circle
% calculation the real circle radii
radii_real6 = radii/44;

%% edge detection with approxcanny method.
I=edge(gray_image,'approxcanny');  
figure (2),subplot(4, 4, 13),imshow(I),title('Edge detection with approxcanny method')
figure (3),subplot(4, 4, 13),imshow(I),title('Edge detection with approxcanny method')
% circle detection 
[centers,radii] = imfindcircles(I,[120 160],'ObjectPolarity','dark', ...
    'Sensitivity',0.97)
figure (2),subplot(4, 4, 14),imshow(rgb),title('Image with circle detection by dark')
h = viscircles(centers,radii); % show the circle


[centers,radii] = imfindcircles(I,[80 100],'ObjectPolarity','bright', ...
    'Sensitivity',0.97)
figure (3),subplot(4, 4, 14),imshow(rgb),title('Image with circle detection by bright')
h = viscircles(centers,radii); % show the circle
% calculation the real circle radii
radii_real7 = radii/44;