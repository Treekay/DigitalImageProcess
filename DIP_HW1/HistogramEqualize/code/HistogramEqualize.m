%����ͼƬ
originImg=imread('..\test_img\river.jpg');
%�������ǰ��ͼƬ��ֱ��ͼ
figure;
subplot(2,3,1),imshow(originImg);title('origin img');%ԭͼ
subplot(2,3,4),imhist(originImg);title('origin histogram');%ԭͼ��ֱ��ͼ

%�ú���histeq��������ֱ��ͼ���⻯����
matlabHisteqImg=histeq(originImg,256);
%�����histeq()���д����ͼƬ��ֱ��ͼ
subplot(2,3,3),imshow(matlabHisteqImg);title('matlab histeq img');%matlab histeq()����ֱ��ͼ���⻯��ͼ��
subplot(2,3,6),imhist(matlabHisteqImg);title('matlab histogram');%matlab histeq()����ֱ��ͼ���⻯��ֱ��ͼ

%�Լ�ʵ�ֵ�ֱ��ͼ���⻯����
[counts,values]=imhist(originImg);%values�ǻҶ�ֵ����, counts��ÿ���Ҷ�ֵ��Ӧ��Ƶ��(���صĸ���)
[M,N]=size(originImg);%M��ԭͼ�������, N��ԭͼ�������

%��ֱ��ͼ���⻯����
H=zeros(M,N);%���̾���
T=1:length(values);%ֱ��ͼ���⻯����
CDF=0;%�ۻ��ֲ�����
for i=1:length(values)
    CDF=CDF+counts(i);%��ȡ��ǰ�Ҷ�ֵ���ۻ��ֲ�Ƶ��
    T(i)=(length(values)-1)*CDF/(M*N);%���ÿ����ɢ��ĺ���ֵ
end
%��ԭͼ����ֱ��ͼ���⻯
for i=1:length(values)
    P=find(originImg==values(i));%��ȡ�ûҶ�ֵ����������
    H(P)=T(i);
end
%�þ��⻯֮���ֱ��ͼ����ͼƬ
myHisteqImg=uint8(H);

%����Լ�ʵ�ֵ�ֱ��ͼ���⻯������ͼƬ��ֱ��ͼ
subplot(2,3,2),imshow(myHisteqImg);title('my histeq img');%�Լ�ʵ�ֵ�ֱ��ͼ���⻯��ͼ��
subplot(2,3,5),imhist(myHisteqImg);title('my histogram');%�Լ�ʵ�ֵ�ֱ��ͼ���⻯��ֱ��ͼ
saveas(gcf,'..\result_img\comparision.jpg');%����ȽϽ��
imwrite(myHisteqImg,'..\result_img\myHisteq.jpg');%�����Լ�ʵ�ֵ�ֱ��ͼ���⻯�Ľ��