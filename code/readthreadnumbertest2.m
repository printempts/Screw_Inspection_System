
I=imread('3.21.01.JPG');   %∂¡»Î¬›Œ∆Õº∆¨
figure (1);
imshow(I);
h = drawrectangle('Position',[x1,y1,bb(3),bb(4)],'StripeColor','r');
%position = images.roi.Rectangle(h);
figure (2);
I2 = imcrop(I,[x1,y1,bb(3),bb(4)]);
imshow(I2)
% 
% points = round(matchedTarget.Location);
% left = min(points(:, 1));
% right = max(points(:, 1));
% top = min(points(:, 2));
% bottom = max(points(:, 2));
% croppedImage = target(top:bottom, left:right, :);