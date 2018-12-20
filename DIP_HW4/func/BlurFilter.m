% 生成运动模糊图像
function [blurredImg, H] = BlurFilter(sourceImg)
    % 读取原图片
    [m, n] = size(sourceImg);

    % 中心变换
    [N, M] = meshgrid(1:n, 1:m);
    centreImg = double(sourceImg).*(-1).^(M + N);
    u = M - 1 - m / 2;
    v = N - 1 - n / 2;

    % 傅里叶变换
    F = fft2(centreImg);

    % 生成 blurring filter
    T = 1.0;
    a = 0.1;
    b = 0.1;
    k = u .* a + v .* b;
    H = T ./ (pi .* k) .* sin(pi .* k) .* exp((-1i * pi) .* k);
    H(k == 0) = T;

    % 图像退化
    G = H .* F;

    % 反DFT变换并取实部
    realG = real(ifft2(G));

    % 反中心变换
    blurredImg = realG .* (-1).^(M + N);
end