clear;clc;close all
obj = videoinput('winvideo', [2]);

% read the input image
I = getsnapshot(obj);   

k1 =1;
k2 =1;
try
    I=rgb2gray(I);         %convert rgb to grayscale
catch
end
figure
imshow(I)
title('Orginal Image')
for K=1:10
    I=wiener2(I,[5 5]);   %filter
end

I=edge(I,'canny');       %edge detection
[row,column]=size(I);           %obtain image size

I=I(20:row-40,10:column-10);    %Remove the edges and corners of image
[row,column]=size(I);          
figure
imshow(I)                %display
title('Edge of Screw')

%Obtain the position of each pixel point in white color
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

[x,Ix]=sort(x);   % Put the x in ascending order
y=y(Ix);          % y correspond to the x in that order
figure
plot(x,y)         
xlabel('Axis x')   
ylabel('Axis y')   
title('Result Image')
view([90 90])
hold on
axis equal
axis([1 row 1 column])

M=10;    % set the number of pitches
lengthx=length(x);    
slength=floor(lengthx/M);  % divide x and y into M segments and calculate the length of each segment

for K=1:M
    xx{K}=x((K-1)*slength+1:K*slength);   % save the value of each segment of x
    yy{K}=y((K-1)*slength+1:K*slength);   % save the value of each segment of y
end

for K=1:M
    [pitchy1(K),index1]=max(yy{K});   % find the maximum value in each y segment
    pitchx1(K)=xx{K}(index1);         % get corresponding x value
    [pitchy2(K),index2]=min(yy{K});     %find the minimum value in each y segment
    pitchx2(K)=xx{K}(index2);           %get corresponding x value
end
scatter(pitchx1,pitchy1)              %plot the points
scatter(pitchx2,pitchy2,'k')              


%Carry out line fitting for all wave peaks, and calculate the slope k1 and intercept b1 of the line
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


while k1 < -0.04 && k2>0.04
    I=I(10:row,1:column);    %��ͼ��ı߽�ȥ�����������õĲ���
[row,column]=size(I);           %����ȥ���߽�֮���ͼ��ߴ�
% figure
% imshow(I)                %��ʾȥ���߽�֮���ͼ��
% title('Edge of Screw')

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
% figure
% plot(x,y)         %���Ƴ�������
% xlabel('Axis x')   %��ע����x
% ylabel('Axis y')   %��ע����y
% title('Result Image')
% view([90 90])
% hold on
% axis equal
% axis([1 row 1 column])

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
% scatter(pitchx1,pitchy1)              %���Ƴ�����ĵ�
% scatter(pitchx2,pitchy2,'k')              %���Ƴ����ȵĵ�


%���еĲ������ֱ����ϣ������ֱ�ߵ�б��k1�ͽؾ�b1
A1=[pitchx1',ones(length(pitchx1),1)];  
kb1=A1\pitchy1';
k1=kb1(1);
b1=kb1(2);
%k1 = (bofengy(M)-bofengy(1))/(bofengx(M)-bofengx(1));
%���Ƴ�������ϵõ���ֱ��
x0=[1 row];
Y1=k1*x0+b1; 
% plot(x0,Y1,'m');


%���еĲ��Ƚ���ֱ����ϣ������ֱ�ߵ�б��k2�ͽؾ�b2
A2=[pitchx2',ones(length(pitchx2),1)];
kb2=A2\pitchy2';
k2=kb2(1);
b2=kb2(2);
%���Ƴ�������ϵõ���ֱ��
x0=[1 row];
Y2=k2*x0+b2; 
% plot(x0,Y2,'r');
end

row = row/43.3;
column = column/43.3;
thickness = 7.85-row;
