clear;
reource_p = imread('1.bmp');
%reource_p = getsnapshot(obj); % read the given image
reource_p = rgb2gray(reource_p);
reource_p_sub=imread('1s.bmp');
reource_p_sub = rgb2gray(reource_p_sub);
%reource_p_sub=imread('02.jpg');
[m,n]=size(reource_p);
[m0,n0]=size(reource_p_sub);
result=zeros(m-m0+1,n-n0+1);
vec_sub = double( reource_p_sub(:) );
norm_sub = norm( vec_sub );
for i=1:m-m0+1
    for j=1:n-n0+1
        subMatr=reource_p(i:i+m0-1,j:j+n0-1);
        vec=double( subMatr(:) );
        result(i,j)=vec'*vec_sub / (norm(vec)*norm_sub+eps);
    end
end
%�ҵ�������λ��
[iMaxPos,jMaxPos]=find( result==max( result(:)));
result_mean = mean(mean(result));
figure,
subplot(121);imshow(reource_p_sub),title('ƥ��ģ����ͼ��');
subplot(122);
imshow(reource_p);
title('��ǳ�ƥ�������ԭͼ'),
hold on
plot(jMaxPos,iMaxPos,'*');%���������ص�
 %�þ��ο��ǳ�ƥ������
plot([jMaxPos,jMaxPos+n0-1],[iMaxPos,iMaxPos]);
plot([jMaxPos+n0-1,jMaxPos+n0-1],[iMaxPos,iMaxPos+m0-1]);
plot([jMaxPos,jMaxPos+n0-1],[iMaxPos+m0-1,iMaxPos+m0-1]);
plot([jMaxPos,jMaxPos],[iMaxPos,iMaxPos+m0-1]);
