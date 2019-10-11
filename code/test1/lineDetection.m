clc
clear
close all

%% Load example
%% call the exteral camera and set the resoultion
%imaqhwinfo;
%imaqtool;
%创建视频对象
% obj = videoinput('winvideo', [2]);
% 
% I = getsnapshot(obj); % read the given image
I = imread ('010.jpg');
a = rgb2gray(I);
figure(1);
subplot(1,2,1);
imshow(a);
title('Orginal thread');

%% Preprocess
frameNoOrange = blockOrangeCones(a);
subplot(1,2,2);
imshow(frameNoOrange);

BW = createLineMaskHSV(frameNoOrange);
figure(2)
subplot(1,2,1)
imshow(BW)
title('Lines');

BM = imclose(BW, strel('disk',10));
subplot(1,2,2)
imshow(BM)
title ('Continuous Lines')

BMSkel = bwmorph(BM,'skel',Inf);
figure (3)
imshow(BMSkel)
title('Skeletonized Lines')


%% Detect Lines
% Perform Hough
[H,T,R]= hough (BMSkel);

% Identify Peaks in Hough Transform
hPeaks = houghpeaks(H,10,'NHoodSize',[55 11]);

%Extract lines from hough transform and peaks
hLines = houghlines(BMSkel,T,R,hPeaks,...
    'FillGap',100,'MinLength',100);

%% View results
% Overlay lines
[linePos, markerPos] = getVizPosArray(hLines);

lineFrame = insertShape(a,'Line',linePos,...
    'Color','blue','LineWidth',5);
outFrame = insertObjectAnnotation(lineFrame,'circle',markerPos,...
    '','Color','yellow','LineWidth',5);

% View image
figure (4)
imshow(outFrame)
title('DetectedLines')
