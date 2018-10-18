%读取图片
testImg=imread('..\test_img\EightAM.png');
goalImg=imread('..\test_img\LENA.png');
%输出处理前的图片和直方图
figure
subplot(2,3,1),imshow(testImg);title('origin img');%待处理图像
subplot(2,3,4),imhist(testImg);title('origin histogram');%原图的直方图
subplot(2,3,3),imshow(goalImg);title('target img');%目标图像
subplot(2,3,6),imhist(goalImg);title('target histogram');%目标图像的直方图

%对原图片进行直方图均衡化
[counts,values]=imhist(testImg);
[M,N]=size(testImg);
H=zeros(M,N);
accumulate=0;
for i=1:length(values)
    P=find(testImg==values(i));
    accumulate=accumulate+counts(i);
    H(P)=(length(values)-1)*accumulate/(M*N);
end
testImg=uint8(H);

%对目标图片进行直方图均衡化
[counts,values]=imhist(goalImg);
[M,N]=size(goalImg);
H=zeros(M,N);
accumulate=0;
for i=1:length(values)
    P=find(goalImg==values(i));
    accumulate=accumulate+counts(i);
    H(P)=(length(values)-1)*accumulate/(M*N);
end
tempImg=uint8(H);

%构造目标图像直方图均衡化的反函数
mappingTable=1:256;
for i=1:256
    for j=1:length(tempImg)
        if tempImg(j)==i
            mappingTable(i)=goalImg(j);
            break;
        end
    end
end

%通过反函数映射表将直方图均衡化后的图片映射到目标图片
[M,N]=size(testImg);
H=zeros(M,N);
for i=1:256
    P=find(testImg==values(i));%获取该灰度值的所有像素
    H(P)=mappingTable(i);
end
testImg=uint8(H);

%输出直方图匹配后的图片和直方图
subplot(2,3,2),imshow(testImg);title('match img');%匹配后的图像
subplot(2,3,5),imhist(testImg);title('match histogram');%匹配后的图像的直方图