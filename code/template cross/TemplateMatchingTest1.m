close all
clear
clc

%% call the exteral camera and set the resoultion
% get the cameras information
%imaqhwinfo;
% show the imaqtool interface
%imaqtool;
% create a object to set the using camera
obj = videoinput('winvideo', [2],'resolution','2048*1536');

%% template match
I = getsnapshot(obj); % read the input image
I = rgb2gray(I);
%I = double( I(:) );
[Ir Ic] = size(I);
figure (1)
subplot(1,2,1);
imshow(I)
title('Orginal head');
O = imread ('1s.bmp');%read template
O = rgb2gray(O);
%O = edge(O,'canny');
%O = double( O(:) );
[Or Oc]=size(O);
figure(2)
imshow(O)
R = normxcorr2(O,I);% find normalize cross correlation
R = imcrop(R,[Oc Or Ic Ir]);%crop the extra pixels
[r c v] = find (R==(max(max(R))))%find the coordinates where maximum correation exists

RGB = insertShape(I,'rectangle',[c r Oc Or],'LineWidth',3);%create a box around maximum match
figure(1);
subplot(1,2,2);
imshow(RGB)
title('Matched head');