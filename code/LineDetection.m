% try the sobel one
% T=100;
% f=zeros(128,128);
% f(32:96,32:96)=255;
% [g1, t1]=edge(f, 'sobel', 'vertical');
% imshow(g1);
% t1

% try the canny one
sigma=1;
f=zeros(128,128);
f(32:96,32:96)=255;
[g3, t3]=edge(f, 'canny', [0.04 0.10], sigma);
figure,imshow(g3);
t3