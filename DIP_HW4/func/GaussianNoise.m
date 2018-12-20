% 生成高斯噪声图像图像
function [noiseImg] = GaussianNoise(blurredImg)
    % 读取运动模糊图像
    [m, n] = size(blurredImg);

    % 生成高斯噪声
    mean = 0; 
    derivation = sqrt(500);
    gaussianNoise = normrnd(mean, derivation, m, n);

    % 添加高斯噪声
    noiseImg = blurredImg + gaussianNoise;
end