%读入图片
originImg=imread('..\test_img\river.jpg');
%输出处理前的图片和直方图
figure;
subplot(2,3,1),imshow(originImg);title('origin img');%原图
subplot(2,3,4),imhist(originImg);title('origin histogram');%原图的直方图

%用函数histeq（）进行直方图均衡化处理
matlabHisteqImg=histeq(originImg,256);
%输出用histeq()进行处理的图片和直方图
subplot(2,3,3),imshow(matlabHisteqImg);title('matlab histeq img');%matlab histeq()函数直方图均衡化的图像
subplot(2,3,6),imhist(matlabHisteqImg);title('matlab histogram');%matlab histeq()函数直方图均衡化的直方图

%自己实现的直方图均衡化处理
[counts,values]=imhist(originImg);%values是灰度值向量, counts是每个灰度值对应的频数(像素的个数)
[M,N]=size(originImg);%M是原图像的行数, N是原图像的列数

%求直方图均衡化函数
H=zeros(M,N);%过程矩阵
T=1:length(values);%直方图均衡化函数
CDF=0;%累积分布函数
for i=1:length(values)
    CDF=CDF+counts(i);%求取当前灰度值的累积分布频数
    T(i)=(length(values)-1)*CDF/(M*N);%求出每个离散点的函数值
end
%对原图进行直方图均衡化
for i=1:length(values)
    P=find(originImg==values(i));%获取该灰度值的所有像素
    H(P)=T(i);
end
%用均衡化之后的直方图生成图片
myHisteqImg=uint8(H);

%输出自己实现的直方图均衡化处理后的图片和直方图
subplot(2,3,2),imshow(myHisteqImg);title('my histeq img');%自己实现的直方图均衡化的图像
subplot(2,3,5),imhist(myHisteqImg);title('my histogram');%自己实现的直方图均衡化的直方图
saveas(gcf,'..\result_img\comparision.jpg');%保存比较结果
imwrite(myHisteqImg,'..\result_img\myHisteq.jpg');%保存自己实现的直方图均衡化的结果