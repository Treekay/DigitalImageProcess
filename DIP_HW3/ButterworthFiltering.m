% 读取图片
sourceImg = imread('src/barb.png');
[m, n] = size(sourceImg);

% 中心变换
[N, M] = meshgrid(1:n, 1:m);
centreImg = double(sourceImg).*(-1).^(M + N);

% 傅里叶变换
fourierImg = fft2(centreImg);

% Butterworth低通滤波器进行频域滤波
D0 = [10, 20, 40, 80];
ButterworthFilter = zeros(m, n);
G = zeros(m, n);
for i = 1 : length(D0)
    % 生成巴特沃斯滤波器
    G = fourierImg;
    ButterworthFilter = 1./(1 + (sqrt((M - m/2).^2 + (N - n/2).^2)./D0(i)).^2);
    % 巴特沃斯滤波
    G = G .* ButterworthFilter;
    % 反DFT变换并取实部
    G = real(ifft2(G));
    % 反中心变换
    G = G.* (-1).^(M + N);
    % figure;
    subplot(2, 2, i);
    imshow(G, []);title(sprintf('D0 = %d', D0(i)));
    % saveas(gcf, sprintf('./res/res1/Butterworth_D0=%d.jpg', D0(i)));
end
 saveas(gcf, './res/res1/ButterworthComparison.jpg');
