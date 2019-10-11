%call the exteral camera and set the resoultion
imaqtool;
%创建视频对象
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

set(obj,'TriggerRepeat',Inf);%设定触发次数
set(obj,'FramesPerTrigger',1);%设定每次触发捕获帧数
set(obj,'FrameGrabInterval',1);%设定捕获帧的时间间隔（默认的是1，即每一帧都抓取；如果设置为3，则每3帧取一帧）
objres=get(obj,'VideoResolution');%得到视频分辨率
nBands=get(obj,'NumberOfBands');%得到色彩数目（rgb是相当于是三通道）
hImage=image(zeros(objres(2),objres(1),nBands));
preview(obj,hImage);;%预览
t=clock;
n=1;
tic;
while n<2%提取图片的个数
if etime(clock,t)>=1; %电脑时间循环提取图片，还有cputime函数也可完成时间循环，用法相同，只不过它是根据CPU主频计算的
t=clock;
frame=getsnapshot(obj);
a=ycbcr2rgb(frame);
str=['capture',num2str(n),'.jpg'];
imwrite(a,str,'jpg');
n=n+1;
end
end
toc;
