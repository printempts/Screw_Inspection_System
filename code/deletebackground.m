im=imread('1.jpg');
im=rgb2gray(im);
imm=double(im);
figure,imagesc(imm),colormap(gray)
hist(imm);figure(gcf);
im1=imm<=100;
figure,imagesc(im1),colormap(gray);
im2=im1.*imm;
figure,imagesc(im2),colormap(gray)