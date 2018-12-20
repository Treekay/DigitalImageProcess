% 主程序
addpath('func');
sourceImg = imread('src/book_cover.jpg'); % 读取原图像
[blurredImg, H] = BlurFilter(sourceImg);  % 运动模糊
[noiseImg] = GaussianNoise(blurredImg);     % 高斯噪声
[inverseBlur, inverseNoise] = InverseFilter(blurredImg, noiseImg, H);   %逆滤波
[wienerImg] = WienerFilter(noiseImg, H); % 维纳滤波

% 保存并输出显示图像
figure;
% 原图像
subplot(231);
imshow(sourceImg); title('origin image');
% 运动模糊图像
subplot(232);
imshow(blurredImg, []); title('blurringFilter image');
imwrite(uint8(blurredImg), 'res/BlurredImg.jpg');
% 高斯噪声图像
subplot(233);
imshow(noiseImg, []); title("gaussianNoise image");
imwrite(uint8(noiseImg), 'res/NoiseImg.jpg');
% 运动模糊图像逆滤波结果
subplot(234);
imshow(inverseBlur, []); title('inverseFilter blur');
imwrite(uint8(inverseBlur), 'res/inverseBlur.jpg');
% 高斯噪声图像逆滤波结果
subplot(235);
imshow(inverseNoise, []); title('inverseFilter noise');
imwrite(uint8(inverseNoise), 'res/inverseNoise.jpg');
% 维纳滤波结果
subplot(236);
imshow(wienerImg, []); title('wienerFilter image');
imwrite(uint8(wienerImg), 'res/wienerImg.jpg');
saveas(gcf, 'res/AllComparison.jpg');