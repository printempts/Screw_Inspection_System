close all
clear
clc

%% call the exteral camera and set the resoultion
%imaqhwinfo;
%imaqtool;
%创建视频对象
obj = videoinput('winvideo', [2]);

%% template match
I = getsnapshot(obj); % read the input image
I = rgb2gray(I);
%I = edge(I,'canny');
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
T = R(626:983,1397:1753);
T_abs = abs(T);
T_mean = mean(mean(T_abs));
%if (T_mean >= 0.2) && (T_mean <= 0.0)
    index = 0;
RGB = insertShape(I,'rectangle',[c r Oc Or],'LineWidth',5);%create a box around maximum match
figure(1);
subplot(1,2,2);
imshow(RGB)
title('Matched head');
%end
%if 0.0 < T_mean <0.4
%    index = 1;
%end



