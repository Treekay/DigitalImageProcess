% ������
addpath('func');
sourceImg = imread('src/book_cover.jpg'); % ��ȡԭͼ��
[blurredImg, H] = BlurFilter(sourceImg);  % �˶�ģ��
[noiseImg] = GaussianNoise(blurredImg);     % ��˹����
[inverseBlur, inverseNoise] = InverseFilter(blurredImg, noiseImg, H);   %���˲�
[wienerImg] = WienerFilter(noiseImg, H); % ά���˲�

% ���沢�����ʾͼ��
figure;
% ԭͼ��
subplot(231);
imshow(sourceImg); title('origin image');
% �˶�ģ��ͼ��
subplot(232);
imshow(blurredImg, []); title('blurringFilter image');
imwrite(uint8(blurredImg), 'res/BlurredImg.jpg');
% ��˹����ͼ��
subplot(233);
imshow(noiseImg, []); title("gaussianNoise image");
imwrite(uint8(noiseImg), 'res/NoiseImg.jpg');
% �˶�ģ��ͼ�����˲����
subplot(234);
imshow(inverseBlur, []); title('inverseFilter blur');
imwrite(uint8(inverseBlur), 'res/inverseBlur.jpg');
% ��˹����ͼ�����˲����
subplot(235);
imshow(inverseNoise, []); title('inverseFilter noise');
imwrite(uint8(inverseNoise), 'res/inverseNoise.jpg');
% ά���˲����
subplot(236);
imshow(wienerImg, []); title('wienerFilter image');
imwrite(uint8(wienerImg), 'res/wienerImg.jpg');
saveas(gcf, 'res/AllComparison.jpg');