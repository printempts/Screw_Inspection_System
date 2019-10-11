%call the exteral camera and set the resoultion
imaqtool;
%������Ƶ����
obj = videoinput('winvideo', 2, 'RGB24_2048x1536');

% src = getselectedsource(obj);

%preview(obj);

%adjust the frames per trigger, which can also set as infinite
% vid.FramesPerTrigger = 10000;
%vid.FramesPerTrigger = Inf;
%returned the color space including rbg/grayscale/YCbCr
% vid.ReturnedColorspace = 'rgb';
%set the brightness
% src.Brightness = 5;

set(obj,'TriggerRepeat',Inf);%�趨��������
set(obj,'FramesPerTrigger',1);%�趨ÿ�δ�������֡��
set(obj,'FrameGrabInterval',1);%�趨����֡��ʱ������Ĭ�ϵ���1����ÿһ֡��ץȡ���������Ϊ3����ÿ3֡ȡһ֡��
objres=get(obj,'VideoResolution');%�õ���Ƶ�ֱ���
nBands=get(obj,'NumberOfBands');%�õ�ɫ����Ŀ��rgb���൱������ͨ����
hImage=image(zeros(objres(2),objres(1),nBands));
preview(obj,hImage);;%Ԥ��
t=clock;
n=1;
tic;
while n<2%��ȡͼƬ�ĸ���
if etime(clock,t)>=1; %����ʱ��ѭ����ȡͼƬ������cputime����Ҳ�����ʱ��ѭ�����÷���ͬ��ֻ�������Ǹ���CPU��Ƶ�����
t=clock;
frame=getsnapshot(obj);
a=ycbcr2rgb(frame);
str=['capture',num2str(n),'.jpg'];
imwrite(a,str,'jpg');
n=n+1;
end
end
toc;
