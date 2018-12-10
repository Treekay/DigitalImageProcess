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
D0 = [100, 200, 300, 500, 800, 1000];
rh = 2.0;
rl = 0.25;
C = 1.0;
HomomorhicFilter = zeros(m, n);
G = zeros(m, n);
for i = 1 : length(D0)
    G = fourierImg;
    % 生成同态滤波器
    HomomorphicFilter = (rh-rl).*(1-exp((-C).*(((M - m/2).^2+(N - n/2).^2)./D0(i).^2)))+rl;
    % 同态滤波
    G = G .* HomomorphicFilter;
     % 反DFT变换
    G = real(ifft2(G));
    % 先取指数再取实部
    G=real(exp(G))-1;
    % 将图像像素值映射到 [0,255]
    G = uint8(255.*(G-min(min(G)))./(max(max(G))-min(min(G))));
    % figure;
    subplot(2, 3, i);
    imshow(G);title(sprintf('D0 = %d', D0(i)));
    % saveas(gcf, sprintf('./res/Homomorphic_%d.jpg', D0(i)));
end
saveas(gcf, './res/Homorphic.jpg');
