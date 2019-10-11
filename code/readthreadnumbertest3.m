clear;clc;close all
I=imread('4.30.02.JPG');   %��������ͼƬ
%I=imread('5.2.JPG');

try
    I=rgb2gray(I);         %�����rgbͼ����ת���ɻҶ�ͼ
catch
end
figure
imshow(I)
title('Orginal Image')
for K=1:10
    I=wiener2(I,[5 5]);   %�˲�15�Σ��Ѷ���ĵ���ȥ
end

I=edge(I,'canny');       %��Ե��⣬�õ����ƵĲ���
[row,column]=size(I);           %����ͼ��ĳߴ�

I=I(20:row-20,10:column-10);    %��ͼ��ı߽�ȥ�����������õĲ���
[row,column]=size(I);           %����ȥ���߽�֮���ͼ��ߴ�
figure
imshow(I)                %��ʾȥ���߽�֮���ͼ��
title('Edge of Screw')

%�Ѱ�ɫ���ص��λ�õõ�������Ϊ1�ĵ�����꣩
Counter=1;   
for i=1:row               
    for j=1:column
        if I(i,j)==1      
            x(Counter)=i;     
            y(Counter)=j;     
            Counter=Counter+1;      
        end
    end
end

[x,Ix]=sort(x);   %��x����������
y=y(Ix);          %��Ӧ��y˳�����κ�x��Ӧ
figure
plot(x,y)         %���Ƴ�������
xlabel('Axis x')   %��ע����x
ylabel('Axis y')   %��ע����y
title('Result Image')
view([90 90])
hold on
axis equal
axis([1 row 1 column])

M=10;    %���ò���Ͳ��ȵĸ���
lengthx=length(x);     %����x��y���ݵ����
slength=floor(lengthx/M);  %��x��y�ȷ�M�Σ�����ÿһ�εĳ���

for K=1:M
    xx{K}=x((K-1)*slength+1:K*slength);   %����ÿһ��x��ֵ
    yy{K}=y((K-1)*slength+1:K*slength);   %����ÿһ��y��ֵ
end

for K=1:M
    [pitchy1(K),index1]=max(yy{K});   %Ѱ��ÿһ��y������ֵ
    pitchx1(K)=xx{K}(index1);         %�õ��벨���Ӧ�ĺ�����x
    [pitchy2(K),index2]=min(yy{K});     %Ѱ��ÿһ��y�����Сֵ
    pitchx2(K)=xx{K}(index2);           %�õ��벨�ȶ�Ӧ�ĺ�����x
end
scatter(pitchx1,pitchy1)              %���Ƴ�����ĵ�
scatter(pitchx2,pitchy2,'k')              %���Ƴ����ȵĵ�


%���еĲ������ֱ����ϣ������ֱ�ߵ�б��k1�ͽؾ�b1
A1=[pitchx1',ones(length(pitchx1),1)];  
kb1=A1\pitchy1';
k1=kb1(1);
b1=kb1(2);
%k1 = (bofengy(M)-bofengy(1))/(bofengx(M)-bofengx(1));
%���Ƴ�������ϵõ���ֱ��
x0=[1 row];
Y1=k1*x0+b1; 
plot(x0,Y1,'m');


%���еĲ��Ƚ���ֱ����ϣ������ֱ�ߵ�б��k2�ͽؾ�b2
A2=[pitchx2',ones(length(pitchx2),1)];
kb2=A2\pitchy2';
k2=kb2(1);
b2=kb2(2);
%���Ƴ�������ϵõ���ֱ��
x0=[1 row];
Y2=k2*x0+b2; 
plot(x0,Y2,'r');




