close all
clear
clc

% 1. Image with two dots
a = zeros(50);
a(20,20) = 1; a(40,10) = 1;
figure;
subplot(2,2,1)
imshow(a)
title('Image with 2 dots')

[H,T,R]= hough(a);
subplot (2,2,2);
houghMatviz(H,T,R)

hPeaks = houghpeaks(H);
x = T(hPeaks(:,2));
y = R(hPeaks(:,1));
plot(x,y,'gs');


% 2. Image with a line
b = eye(150);
subplot(2,2,3)
imshow(b)
title('Image with a line')

[H,T,R]= hough(b);
subplot (2,2,4);
houghMatviz(H,T,R)

hPeaks = houghpeaks(H);
x = T(hPeaks(:,2));
y = R(hPeaks(:,1));
plot(x,y,'gs');

hlines = houghlines(b,T,R,hPeaks);

xy = [hlines.point1;hlines.point2];
figure;
imshow(b)
hold on
plot(xy(:,1),xy(:,2),'g--','LineWidth',5)
title('Detected Line')