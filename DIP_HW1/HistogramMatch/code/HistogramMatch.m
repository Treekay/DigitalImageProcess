%��ȡͼƬ
testImg=imread('../test_img/EightAM.png');
goalImg=imread('../test_img/LENA.png');
%Ŀ��ֱ��ͼ
targetHist=imhist(goalImg);
%�������ǰ��ͼƬ��ֱ��ͼ
figure
subplot(2,3,1),imshow(testImg);title('origin img');%������ͼ��
subplot(2,3,4),imhist(testImg);title('origin histogram');%ԭͼ��ֱ��ͼ
subplot(2,3,3),imshow(goalImg);title('target img');%Ŀ��ͼ��
subplot(2,3,6),imhist(goalImg);title('target histogram');%Ŀ��ͼ���ֱ��ͼ

%matlab�Դ�histeqֱ��ͼƥ��
matlabImg=histeq(testImg,targetHist);

%�����ͼ���ֱ��ͼ����
[counts,values1]=imhist(testImg);
[M1,N1]=size(testImg);
H=zeros(M1,N1);%���̾���
S=1:length(values);%ֱ��ͼ���⻯����
CDF=0;%�ۻ��ֲ�����
for i=1:length(values)
    CDF=CDF+counts(i);%��ȡ��ǰ�Ҷ�ֵ���ۻ��ֲ�Ƶ��
    S(i)=round((length(values)-1)*CDF/(M*N));%���ÿ����ɢ��ĺ���ֵ
end
%��ԭͼ����ֱ��ͼ���⻯
for i=1:length(values)
    P=find(originImg==values(i));%��ȡ�ûҶ�ֵ����������
    H(P)=S(i);
end
%�þ��⻯֮���ֱ��ͼ����ͼƬ

%��Ŀ��ͼ���ֱ��ͼ����G(z)
[counts2,values2]=imhist(goalImg);
[M2,N2]=size(goalImg);
G=zeros(length(values2),1);%ֱ��ͼ���⻯����
CDF=0;
for i=1:length(values2)
    CDF=CDF+counts2(i);
    G(i)=round((length(values2)-1)*CDF/(M2*N2));
end

%��S�ϵĻҶ�ֵӳ�䵽 G(z) �϶�Ӧ�ĻҶ�ֵ,��������ͼƬ��Ӧ���صĻҶ�ֵ�޸�
I=zeros(M1,N1);%���̾���
for i=1:length(S)
    k=256;%Ҫ�������ĺ�����ֵ
    val=0;
    for j=1:length(G)
        %�ҵ���ӽ���ӳ��ֵ
        if abs(S(i)-G(j)) < k
            k=abs(S(i)-G(j));
            val=j-1;%�±���1-256, �Ҷ�ֵ��0-255, ����Ҫ��һ
        end
    end
    match=find(testImg==S(i));%��ȡ���⻯����ͼ������ͬ�Ҷ�ֵ������
    I(match)=val;%��������صĻҶ�ֵӳ�䵽Ŀ��ͼ���ϵ�ֵ
end
matchImg=uint8(I);

%���ֱ��ͼƥ����ͼƬ��ֱ��ͼ
subplot(2,3,2),imshow(matchImg);title('match img');%ƥ����ͼ��
subplot(2,3,5),imhist(matchImg);title('match histogram');%ƥ����ͼ���ֱ��ͼ
saveas(gcf,'..\result_img\comparision1.jpg');%����ȽϽ��
imwrite(testImg,'..\result_img\myMatch.jpg');%�����Լ�ʵ�ֵ�ֱ��ͼ���⻯�Ľ��

%��matlab�Դ�histeqЧ���Ƚ�
figure
subplot(2,2,1),imshow(matchImg);title('match img');%ƥ����ͼ��
subplot(2,2,3),imhist(matchImg);title('match histogram');%ƥ����ͼ���ֱ��ͼ
subplot(2,2,2),imshow(matlabImg);title('matlab img');%matlab�Դ�histeqƥ����ͼƬ
subplot(2,2,4),imhist(matlabImg);title('matlab histogram');%matlab�Դ�histeqƥ����ֱ��ͼ
saveas(gcf,'..\result_img\comparision2 .jpg');%����ȽϽ��