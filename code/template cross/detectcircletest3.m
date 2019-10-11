%global Img;

%% image preprocessing
obj = videoinput('winvideo', [3]);
Img = getsnapshot(obj); % read the given image

%Img = imread('1.bmp'); % read the given image
ImgGray = rgb2gray(Img); % Convert to grayscale image

% show image comparsion
figure (1),subplot(1, 3, 1),imshow(Img),title('Original Image');          
subplot(1, 3, 2),imshow(ImgGray),title('Grayscale of the original image');
subplot(1, 3, 3),imhist(ImgGray),title('Gray histogram of the original image');colorbar;

% Grayscale image enhancement
%GrayA1 = imadjust(ImgGray, [], [0.25, 0.75], 2);      
% Grayscale image homogenization    
GrayA = histeq(ImgGray);              
figure(2) 
% subplot(2, 2, 1), imshow(GrayA1);title('Image after enhancement');
% subplot(2, 2, 2), imhist(GrayA1);title('Histogram after enhancement');
subplot(1, 2, 1), imshow(GrayA);title('Image after honogenization');
subplot(1, 2, 2), imhist(GrayA);title('Histogram after honogenization');

%Edge Detection
    GrayA = imfilter(GrayA, fspecial('average', 3));      % Image after mean enhancement
    pictureOut = edge(GrayA, 'canny');     
    figure,imshow(pictureOut), title('Image after edge detection');
    
%% Circle detection 
[centers,radii] = imfindcircles(pictureOut,[120 180],'ObjectPolarity','dark', ...
    'Sensitivity',0.97)
imshow(Img)
h = viscircles(centers,radii);
% whether the diameter of screw head proper
% if not / the matrix is empty, Send message to Arduino
if isempty(centers)
    a = 1;
end
%if proper, continue detection 
if ~isempty(centers)
    a = 0;
end

% if a == 1;   
%     close all;
% end
 
