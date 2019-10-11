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

I=edge(I,'canny');       %��Ե��⣬�õ����ƵĲ���
[m,n]=size(I);           %����ͼ��ĳߴ�

I=I(20:m-20,20:n-20);    %��ͼ��ı߽�ȥ�����������õĲ���
[m,n]=size(I);           %����ȥ���߽�֮���ͼ��ߴ�
figure
imshow(I)                %��ʾȥ���߽�֮���ͼ��
title('���Ʋ���')

%�Ѱ�ɫ���ص��λ�õõ�������Ϊ1�ĵ�����꣩
N=1;   %������
for i=1:m               
    for j=1:n
        if I(i,j)==1      
            x(N)=i;     %�����ɫ���صĺ�����x
            y(N)=j;     %�����ɫ���ص�������y
            N=N+1;      %������+1
        end
    end
end

[x,IX]=sort(x);   %��x����������
y=y(IX);          %��Ӧ��y˳�����κ�x��Ӧ
figure
plot(x,y)         %���Ƴ�������
xlabel('����x')   %��ע����x
ylabel('����y')   %��ע����y
title('������')
view([90 90])
hold on
axis equal
axis([1 m 1 n])

% x=find(x<200);
% y = find(y>75 & y<165);

M=7;    %���ò���Ͳ��ȵĸ���
lengthxy=length(x);     %����x��y���ݵ����
dlength=floor(lengthxy/M);  %��x��y�ȷ�M�Σ�����ÿһ�εĳ���

for K=1:M
    xx{K}=x((K-1)*dlength+1:K*dlength);   %����ÿһ��x��ֵ
    yy{K}=y((K-1)*dlength+1:K*dlength);   %����ÿһ��y��ֵ
end


for K=1:M
    [bofengy(K),index1]=max(yy{K});   %Ѱ��ÿһ��y������ֵ
    bofengx(K)=xx{K}(index1);         %�õ��벨���Ӧ�ĺ�����x
    [boguy(K),index2]=min(yy{K});     %Ѱ��ÿһ��y�����Сֵ
    bogux(K)=xx{K}(index2);           %�õ��벨�ȶ�Ӧ�ĺ�����x
end

scatter(bofengx,bofengy)              %���Ƴ�����ĵ�
scatter(bogux,boguy,'k')              %���Ƴ����ȵĵ�


% %���еĲ������ֱ����ϣ������ֱ�ߵ�б��k1�ͽؾ�b1
% A1=[bofengx',ones(length(bofengx),1)];  
% kb1=A1\bofengy';
% k1=kb1(1);
% b1=kb1(2);
% %���Ƴ�������ϵõ���ֱ��
% x0=[1 m];
% Y1=k1*x0+b1; 
% plot(x0,Y1,'m');
% 
% %���еĲ��Ƚ���ֱ����ϣ������ֱ�ߵ�б��k2�ͽؾ�b2
% A2=[bogux',ones(length(bogux),1)];
% kb2=A2\boguy';
% k2=kb2(1);
% b2=kb2(2);
% %���Ƴ�������ϵõ���ֱ��
% x0=[1 m];
% Y2=k2*x0+b2; 
% plot(x0,Y2,'r');




