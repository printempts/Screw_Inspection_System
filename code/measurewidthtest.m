clc;    % Clear the command window.
workspace;  % Make sure the workspace panel is showing.
fontSize = 20;
% read the input image
rgbImage = imread('04.bmp');
%rgbImage = imread('010.jpg');
% Display the original color image.
subplot(2, 3, 1),imshow(rgbImage),title('Original Image');
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]); % Maximize figure
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off') 
% Using the filters of red channel, green channel and blue channel
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :,3);
subplot(2, 3, 2),imshow(redChannel),title('Red Channel Image');
subplot(2, 3, 3),imshow(greenChannel),title('Green Channel Image');
subplot(2, 3, 4),imshow(blueChannel),title('Blue Channel Image');
% Combine channels to show the screw shape only
screw = blueChannel < 200 & redChannel > 200 & greenChannel < 200 & greenChannel > 50;
%screw = blueChannel < 50 ;
% Ignore blobs less than 5000 in pixel area.
screw = bwareaopen(screw, 90000);
subplot(2, 3, 5),imshow(screw);
% Label each part with 8-connectivity to measure it
[labeledImage, numberOfParts] = bwlabel(screw, 8);
% Apply a variety of colors to the regions.
coloredLabelsImage = label2rgb (labeledImage, 'hsv', 'k', 'shuffle'); 
imshow(coloredLabelsImage);axis on;title('Screw with Elimination of Background');
% Get all the parts properties.
screwMeasurements = regionprops(labeledImage, 'area', 'BoundingBox');   
numberOfParts = size(screwMeasurements, 1);
area = [screwMeasurements.Area];
% Get the bounding box.
bb = [screwMeasurements.BoundingBox]; 
x1 = bb(1);
x2 = x1 + bb(3);
y1 = bb(2);
y2 = y1 + bb(4);
% Plot screw with box around it.
subplot(2, 3, 6);imshow(coloredLabelsImage);axis on;title('Screw with Measurement Box');hold on;
plot([x1 x2 x2 x1 x1], [y1 y1 y2 y2 y1], 'y-', 'LineWidth', 2);
% Display message
message = sprintf('Done with demo!\nWidth = %f\nHeight = %f', bb(3)/112, bb(4)/112);
%message = sprintf('Done with demo!\nWidth = %f\nHeight = %f', bb(3), bb(4));
msgbox(message);
%% extract ROI
figure (2);
imshow(rgbImage);
h = drawrectangle('Position',[x1,y1,bb(3),bb(4)],'StripeColor','r');
figure (3);
I2 = imcrop(rgbImage,[x1,y1,bb(3),bb(4)]);
imshow(I2)