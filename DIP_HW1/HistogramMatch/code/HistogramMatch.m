%读取图片
testImg=imread('../test_img/EightAM.png');
goalImg=imread('../test_img/LENA.png');
%目标直方图
targetHist=imhist(goalImg);
%输出处理前的图片和直方图
figure
subplot(2,3,1),imshow(testImg);title('origin img');%待处理图像
subplot(2,3,4),imhist(testImg);title('origin histogram');%原图的直方图
subplot(2,3,3),imshow(goalImg);title('target img');%目标图像
subplot(2,3,6),imhist(goalImg);title('target histogram');%目标图像的直方图

%matlab自带histeq直方图匹配
matlabImg=histeq(testImg,targetHist);

%求给定图像的直方图均衡
[counts,values1]=imhist(testImg);
[M1,N1]=size(testImg);
H=zeros(M1,N1);%过程矩阵
T=zeros(length(values1),1);%直方图均衡化函数
CDF=0;%累积分布函数
%求给定图像的直方图均衡变换函数T(x)
for i=1:length(values1)
    CDF=CDF+counts(i);%求取当前灰度值的累积分布频数
    T(i)=round((length(values1)-1)*CDF/(M1*N1));%求出每个离散点的函数值
end
%对原图进行直方图均衡化
for i=1:length(values1)
    P=find(testImg==values1(i));%获取该灰度值的所有像素
    H(P)=T(i);
end
%用均衡化之后的直方图生成图片
testImg=uint8(H);

%求目标图像的直方图均衡变换函数G(z)
[counts2,values2]=imhist(goalImg);
[M2,N2]=size(goalImg);
G=zeros(length(values2),1);%直方图均衡化函数
CDF=0;
for i=1:length(values2)
    CDF=CDF+counts2(i);
    G(i)=round((length(values2)-1)*CDF/(M2*N2));
end

%对每个灰度值s=T(x)映找到最接近的G(z)并返回z，构造s->z映射表
matchTable=zeros(length(values1),1);%s->z的映射表
for i=1:length(T)
    k=256;%要大于最大的函数差值
    val=0;
    for j=1:length(G)
        %找到最接近的映射值
        if abs(T(i)-G(j)) < k
            k=abs(T(i)-G(j));
            val=j-1;%下标是1-256, 灰度值是0-255, 所以要减一
        end
    end
    matchTable(i)=val;
end

%利用s->z映射表将均衡化后的给定图匹配到目标直方图, 完成直方图规定化
I=zeros(M1,N1);%过程矩阵
for i=1:length(T)
    P=find(testImg==T(i));%获取均衡化给定图像中灰度值等于s的像素
    I(P)=matchTable(i);%将相关像素的灰度值s变换成z
end
matchImg=uint8(I);

%输出直方图匹配后的图片和直方图
subplot(2,3,2),imshow(matchImg);title('match img');%匹配后的图像
subplot(2,3,5),imhist(matchImg);title('match histogram');%匹配后的图像的直方图
saveas(gcf,'..\result_img\comparision1.jpg');%保存比较结果
imwrite(matchImg,'..\result_img\myMatch.jpg');%保存自己实现的直方图均衡化的结果

%与matlab自带histeq效果比较
figure
subplot(2,2,1),imshow(matchImg);title('match img');%匹配后的图像
subplot(2,2,3),imhist(matchImg);title('match histogram');%匹配后的图像的直方图
subplot(2,2,2),imshow(matlabImg);title('matlab img');%matlab自带histeq匹配后的图片
subplot(2,2,4),imhist(matlabImg);title('matlab histogram');%matlab自带histeq匹配后的直方图
saveas(gcf,'..\result_img\comparision2 .jpg');%保存比较结果