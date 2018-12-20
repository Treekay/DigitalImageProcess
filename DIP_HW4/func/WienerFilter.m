% 维纳滤波复原高斯噪声图像
function [wienerImg] = WienerFilter(noiseImg, H)
    [m, n] = size(noiseImg);
    [N, M] = meshgrid(1:n, 1:m);
    
    conjH = conj(H); %  H共轭
    squareH = conjH .* H;
    K = [0.01, 0.03, 0.05];
    % 先将噪声图像转为频域图像
    centreNoise = noiseImg.*(-1).^(M + N); % 中心化
    fourierNoise = fft2(centreNoise); % 傅里叶变换
    for i = 1:length(K)
       wienerFilter = squareH ./ (H .* (squareH + K(i)));
       wienerImg = wienerFilter .* fourierNoise;
       % 反DFT变换并取实部
       wienerImg = real(ifft2(wienerImg));
       % 反中心化
       wienerImg = wienerImg .* (-1).^(M + N);
       % 显示图像
       subplot(length(K)/3, 3, i);
       imshow(wienerImg, []); title(sprintf('wiener filter K=%f', K(i)));
    end
    saveas(gcf, 'res/WienerComparison.jpg');
end