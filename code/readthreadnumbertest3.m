clear;clc;close all
I=imread('4.30.02.JPG');   %读入螺纹图片
%I=imread('5.2.JPG');

try
    I=rgb2gray(I);         %如果是rgb图，则转换成灰度图
catch
end
figure
imshow(I)
title('Orginal Image')
for K=1:10
    I=wiener2(I,[5 5]);   %滤波15次，把多余的点滤去
end

I=edge(I,'canny');       %边缘检测，得到螺纹的波形
[row,column]=size(I);           %计算图像的尺寸

I=I(20:row-20,10:column-10);    %把图像的边角去掉，留下有用的部分
[row,column]=size(I);           %计算去掉边角之后的图像尺寸
figure
imshow(I)                %显示去掉边角之后的图像
title('Edge of Screw')

%把白色像素点的位置得到（像素为1的点的坐标）
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

[x,Ix]=sort(x);   %将x按升序排列
y=y(Ix);          %对应的y顺序依次和x对应
figure
plot(x,y)         %绘制出螺纹线
xlabel('Axis x')   %标注横轴x
ylabel('Axis y')   %标注纵轴y
title('Result Image')
view([90 90])
hold on
axis equal
axis([1 row 1 column])

M=10;    %设置波峰和波谷的个数
lengthx=length(x);     %计算x和y数据点个数
slength=floor(lengthx/M);  %将x和y等分M段，计算每一段的长度

for K=1:M
    xx{K}=x((K-1)*slength+1:K*slength);   %保存每一段x的值
    yy{K}=y((K-1)*slength+1:K*slength);   %保存每一段y的值
end

for K=1:M
    [pitchy1(K),index1]=max(yy{K});   %寻找每一段y里的最大值
    pitchx1(K)=xx{K}(index1);         %得到与波峰对应的横坐标x
    [pitchy2(K),index2]=min(yy{K});     %寻找每一段y里的最小值
    pitchx2(K)=xx{K}(index2);           %得到与波谷对应的横坐标x
end
scatter(pitchx1,pitchy1)              %绘制出波峰的点
scatter(pitchx2,pitchy2,'k')              %绘制出波谷的点


%所有的波峰进行直线拟合，计算出直线的斜率k1和截距b1
A1=[pitchx1',ones(length(pitchx1),1)];  
kb1=A1\pitchy1';
k1=kb1(1);
b1=kb1(2);
%k1 = (bofengy(M)-bofengy(1))/(bofengx(M)-bofengx(1));
%绘制出波峰拟合得到的直线
x0=[1 row];
Y1=k1*x0+b1; 
plot(x0,Y1,'m');


%所有的波谷进行直线拟合，计算出直线的斜率k2和截距b2
A2=[pitchx2',ones(length(pitchx2),1)];
kb2=A2\pitchy2';
k2=kb2(1);
b2=kb2(2);
%绘制出波谷拟合得到的直线
x0=[1 row];
Y2=k2*x0+b2; 
plot(x0,Y2,'r');




