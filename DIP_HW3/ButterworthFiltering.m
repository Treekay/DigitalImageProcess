% 读取图片
sourceImg = imread('src/barb.png');
[m, n] = size(sourceImg);
[N, M] = meshgrid(1:n, 1:m);

% 中心变换
centreImg = double(sourceImg).*(-1).^(M + N);

% 傅里叶变换
fourierImg = fft2(centreImg);

% Butterworth低通滤波器进行频域滤波
P = m / 2;
Q = n / 2;
rank = 1;
D0 = [10, 20, 40, 80];
ButterworthFilter = zeros(m, n);
G = zeros(m, n);
for i = 1 : length(D0)
    % 生成巴特沃斯滤波器
    G = fourierImg;
    ButterworthFilter = 1./(1 + (sqrt((M-P).^2 + (N-Q).^2) ./D0(i)).^(2 * rank));
    % 巴特沃斯滤波
    G = G .* ButterworthFilter;
    % DFT 反变换并取实部
    G = real(ifft2(G));
    % 反中心变换
    G = G.* (-1).^(M + N);
    % 处理得到的图像
    figure;
    imshow(G);title(sprintf('D0 = %d', D0(i)));
    saveas(gcf, sprintf('./res/Butterworth_%d.jpg', D0(i)));
end
