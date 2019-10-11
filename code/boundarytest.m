I = imread ('4.30.04.jpg');
imshow(I);
[B,L]=bwboundaries(I);
figure;imshow(I);hold on
for k = 1:lenghth(B),
    boundary = b{k};
    plot(bounary(:,2),boundary(:,1),'g','LineWidth',2);
end