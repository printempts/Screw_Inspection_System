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
I = rgb2gray(I);  % turn rbg image to gray image
[Ir, Ic] = size(I); % obtain the size of image
figure (1),subplot(1,3,1),imshow(I),title('Orginal Image');
T = imread ('1s.bmp');% read the template image
T = rgb2gray(T); % turn rbg image to gray image
[Tr, Tc]=size(T); % obtain the size of template image
figure (1),subplot(1,3,2),imshow(T),title('Template Image');
R = normxcorr2(T,I);% find normalize cross correlation
R = imcrop(R,[Tc Tr Ic Ir]);%crop the extra pixels
[r, c, v] = find (R==(max(max(R))));%find the coordinates where maximum correation exists
T_R = R(r:r+Tr-1,c:c+Tc-1);% obtain the matching matrix value
% T_RF = T_R(:)'; % expand the matrix to a column, and then transpose it to a row.
% Map_T_RF = mapminmax(T_RF, 0, 1); % normalization
% Map_T = reshape(Map_T_RF, size(T_R)); % back to the original matrix
T_T = im2double(T); % turn the template image from uint8 to double
% T_TF = T_T(:)'; % expand the matrix to a column, and then transpose it to a row
% Map_T_TF = mapminmax(T_TF, 0, 1); % normalization
% Map_T2 = reshape(Map_T_TF, size(T_T)); % back to the original matrix
T_abs = abs(T_R/T_T); % compare these two value 
T_Tabs = T_abs(:)'; % expand the matrix to a column, and then transpose it to a row
Map_T_abs = mapminmax(T_Tabs, 0, 1); % normalization
Map_T3 = reshape(Map_T_abs, size(T_abs)); % back to the original matrix
T_mean = mean(mean(T_abs));% obtain a average ratio value
% if matching ratio larger than 0.7, continue detection process
if T_mean >= 0.7
    index = 0;
RGB = insertShape(I,'rectangle',[c r Tc Tr],'LineWidth',10);%create a box around maximum match
figure(1),subplot(1,3,3),imshow(RGB),title('Matched Image');
end
% if not, ON the DC motor
if T_mean <0.7
    index = 1;
end



