clear
clc
close all

%% show the figure
I=load('4.30.03.jpg');   

% if it is rgb, turn rgb to gray
try
    I=rgb2gray(I);        
catch
end
figure
imshow(I)
title('Orginal Screw')

%% filter the external small parts
for K=1:15
    I=wiener2(I,[5 10]);  
end
%
[m,n]=size(I);

I=edge(I,'canny');       %边缘检测，得到螺纹的波形
[m,n]=size(I);           %计算图像的尺寸

I=I(20:m-20,20:n-20);    %把图像的边角去掉，留下有用的部分
[m,n]=size(I);           %计算去掉边角之后的图像尺寸
figure
imshow(I)                %显示去掉边角之后的图像
title('螺纹波形')

%把白色像素点的位置得到（像素为1的点的坐标）
N=1;   %计数器
for i=1:m               
    for j=1:n
        if I(i,j)==1      
            x(N)=i;     %保存白色像素的横坐标x
            y(N)=j;     %保存白色像素的纵坐标y
            N=N+1;      %计数器+1
        end
    end
end

[x,IX]=sort(x);   %将x按升序排列
y=y(IX);          %对应的y顺序依次和x对应
figure
plot(x,y)         %绘制出螺纹线
xlabel('横轴x')   %标注横轴x
ylabel('纵轴y')   %标注纵轴y
title('计算结果')
view([90 90])
hold on
axis equal
axis([1 m 1 n])

% x=find(x<200);
% y = find(y>75 & y<165);

M=7;    %设置波峰和波谷的个数
lengthxy=length(x);     %计算x和y数据点个数
dlength=floor(lengthxy/M);  %将x和y等分M段，计算每一段的长度

for K=1:M
    xx{K}=x((K-1)*dlength+1:K*dlength);   %保存每一段x的值
    yy{K}=y((K-1)*dlength+1:K*dlength);   %保存每一段y的值
end


for K=1:M
    [bofengy(K),index1]=max(yy{K});   %寻找每一段y里的最大值
    bofengx(K)=xx{K}(index1);         %得到与波峰对应的横坐标x
    [boguy(K),index2]=min(yy{K});     %寻找每一段y里的最小值
    bogux(K)=xx{K}(index2);           %得到与波谷对应的横坐标x
end

scatter(bofengx,bofengy)              %绘制出波峰的点
scatter(bogux,boguy,'k')              %绘制出波谷的点


% %所有的波峰进行直线拟合，计算出直线的斜率k1和截距b1
% A1=[bofengx',ones(length(bofengx),1)];  
% kb1=A1\bofengy';
% k1=kb1(1);
% b1=kb1(2);
% %绘制出波峰拟合得到的直线
% x0=[1 m];
% Y1=k1*x0+b1; 
% plot(x0,Y1,'m');
% 
% %所有的波谷进行直线拟合，计算出直线的斜率k2和截距b2
% A2=[bogux',ones(length(bogux),1)];
% kb2=A2\boguy';
% k2=kb2(1);
% b2=kb2(2);
% %绘制出波谷拟合得到的直线
% x0=[1 m];
% Y2=k2*x0+b2; 
% plot(x0,Y2,'r');




