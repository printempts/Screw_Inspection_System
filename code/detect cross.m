
rgb = imread('4.1.02.jpg');
imshow(rgb)
hold on

gray_image = rgb2gray(rgb);
imshow(gray_image)

[A,B,C]=hough_circle(gray_image,200,360,500,600,0.95)

I=edge(gray_image,'canny');       %±ßÔµ¼ì²â£¬µÃµ½ÂÝÎÆµÄ²¨ÐÎ

[centers,radii] = imfindcircles(I,[60 160],'ObjectPolarity','dark', ...
    'Sensitivity',0.95)


imshow(rgb)
h = viscircles(centers,radii);
