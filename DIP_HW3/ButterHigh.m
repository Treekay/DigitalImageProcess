% 读取图片
sourceImg = imread('src/office.jpg');

% 将图片转换成灰度图像
grayImg = double(rgb2gray(sourceImg));

% 取对数
logImg = log(grayImg + 1);
[m, n] = size(logImg);
[N, M] = meshgrid(1:n, 1:m);

% 傅里叶变换
fourierImg = fft2(logImg);

% Butterworth低通滤波器进行频域滤波
D0 = [10, 20, 40, 80, 100, 150];
ButterworthFilter = zeros(m, n);
G = zeros(m, n);
for i = 1 : length(D0)
    % 生成巴特沃斯滤波器
    G = fourierImg;
    ButterworthFilter = 1./(1 + D0(i) ./ (sqrt((M - m/2).^2 + (N - n/2).^2))).^2;
    % 巴特沃斯滤波
    G = G .* ButterworthFilter;
    % 反DFT变换并取实部
    G = real(ifft2(G));
   % 先取指数再取实部
    G = real(exp(G))-1;
    % 将图像像素值映射到 [0,255]
    G = uint8(255.*(G-min(min(G)))./(max(max(G))-min(min(G))));
    % figure;
    subplot(2, 3, i);
    imshow(G, []);title(sprintf('D0 = %d', D0(i)));
    % saveas(gcf, sprintf('./res/res2/ButterHigh_D0=%d.jpg', D0(i)));
end
 saveas(gcf, './res/res2/ButteHighComparison.jpg');