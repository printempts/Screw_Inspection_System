clear;

rgb=imread('23.jpg');

figure(1)

imshow(rgb);

for i=200:1200

    for j=1600:1950

        if((rgb(i,j,1)>50&rgb(i,j,2)<140&rgb(i,j,3)<180)==0)

            rgb(i,j,1)=0;

            rgb(i,j,2)=0;

            rgb(i,j,3)=0;

        end

    end

end

%figure(2)

%imshow(rgb);

SE=strel('rectangle',[3 3]);

I2=imerode(rgb,SE);

figure(3);

I3=imdilate(I2,SE);

imshow(I3);


% g=edge(I3,'sobel');
% [B,L] = bwboundaries(I3,'noholes');
% hold on
% for k = 1:length(B)    % ±ê¼Ç±ß½ç
%   boundary = B{k};
%   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2)
% end
figure(4);
f_gray=rgb2gray(I3);
BW1 = ~im2bw(f_gray, graythresh(f_gray));
g=edge(BW1,'sobel');
imshow(rgb)

