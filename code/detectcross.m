
rgb = imread('3.22.06.jpg');
imshow(rgb)
hold on

gray_image = rgb2gray(rgb);
imshow(gray_image)

I=edge(gray_image,'canny');       %±ßÔµ¼ì²â£¬µÃµ½ÂÝÎÆµÄ²¨ÐÎ
imshow(I);
hold on;

[centers,radii] = imfindcircles(I,[40 50],'ObjectPolarity','dark', ...
    'Sensitivity',0.95)


imshow(rgb)
h = viscircles(centers,radii);
