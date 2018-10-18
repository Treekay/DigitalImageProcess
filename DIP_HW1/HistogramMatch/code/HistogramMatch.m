%��ȡͼƬ
testImg=imread('..\test_img\EightAM.png');
goalImg=imread('..\test_img\LENA.png');
%�������ǰ��ͼƬ��ֱ��ͼ
figure
subplot(2,3,1),imshow(testImg);title('origin img');%������ͼ��
subplot(2,3,4),imhist(testImg);title('origin histogram');%ԭͼ��ֱ��ͼ
subplot(2,3,3),imshow(goalImg);title('target img');%Ŀ��ͼ��
subplot(2,3,6),imhist(goalImg);title('target histogram');%Ŀ��ͼ���ֱ��ͼ

%��ԭͼƬ����ֱ��ͼ���⻯
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

%��Ŀ��ͼƬ����ֱ��ͼ���⻯
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

%����Ŀ��ͼ��ֱ��ͼ���⻯�ķ�����
mappingTable=1:256;
for i=1:256
    for j=1:length(tempImg)
        if tempImg(j)==i
            mappingTable(i)=goalImg(j);
            break;
        end
    end
end

%ͨ��������ӳ���ֱ��ͼ���⻯���ͼƬӳ�䵽Ŀ��ͼƬ
[M,N]=size(testImg);
H=zeros(M,N);
for i=1:256
    P=find(testImg==values(i));%��ȡ�ûҶ�ֵ����������
    H(P)=mappingTable(i);
end
testImg=uint8(H);

%���ֱ��ͼƥ����ͼƬ��ֱ��ͼ
subplot(2,3,2),imshow(testImg);title('match img');%ƥ����ͼ��
subplot(2,3,5),imhist(testImg);title('match histogram');%ƥ����ͼ���ֱ��ͼ