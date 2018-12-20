% 对运动模糊图像和高斯噪声图像进行逆滤波
function [inverseBlur, inverseNoise] = InverseFilter(blurredImg, noiseImg, H)
    [m, n] = size(blurredImg);
    [N, M] = meshgrid(1:n, 1:m);
    
    % 对运动模糊图像作逆滤波处理
    % 中心化
    centreBlur = blurredImg .* (-1).^(M + N);
    % 傅里叶变换
    fourierBlur = fft2(centreBlur);
    % 逆滤波
    inverseBlur = fourierBlur ./ H;
    inverseBlur(abs(H) < 0.001)=0;
    % 反DFT并取实部
    inverseBlur = real(ifft2(inverseBlur)); 
    % 反中心化
    inverseBlur = inverseBlur .* (-1).^(M + N);
    
    % 对高斯噪声图像做逆滤波处理
    % 中心化
    centreNoise = noiseImg.*(-1).^(M + N);
    % 傅里叶变换
    fourierNoise = fft2(centreNoise);
    % 逆滤波
    inverseNoise = fourierNoise ./ H;
    inverseNoise(abs(H) < 0.001) = 0;
    inverseNoise = 1 ./ (1 + sqrt((M - m/2).^2 + (N - n/2).^2) ./ 20).^2 .* inverseNoise;
    % 反DFT并取实部
    inverseNoise = real(ifft2(inverseNoise));
    % 反中心化
    inverseNoise = inverseNoise .* (-1).^(M + N);
end