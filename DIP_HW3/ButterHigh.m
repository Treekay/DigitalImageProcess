% ��ȡͼƬ
sourceImg = imread('src/office.jpg');

% ��ͼƬת���ɻҶ�ͼ��
grayImg = double(rgb2gray(sourceImg));

% ȡ����
logImg = log(grayImg + 1);
[m, n] = size(logImg);
[N, M] = meshgrid(1:n, 1:m);

% ����Ҷ�任
fourierImg = fft2(logImg);

% Butterworth��ͨ�˲�������Ƶ���˲�
D0 = [10, 20, 40, 80, 100, 150];
ButterworthFilter = zeros(m, n);
G = zeros(m, n);
for i = 1 : length(D0)
    % ���ɰ�����˹�˲���
    G = fourierImg;
    ButterworthFilter = 1./(1 + D0(i) ./ (sqrt((M - m/2).^2 + (N - n/2).^2))).^2;
    % ������˹�˲�
    G = G .* ButterworthFilter;
    % ��DFT�任��ȡʵ��
    G = real(ifft2(G));
   % ��ȡָ����ȡʵ��
    G = real(exp(G))-1;
    % ��ͼ������ֵӳ�䵽 [0,255]
    G = uint8(255.*(G-min(min(G)))./(max(max(G))-min(min(G))));
    % figure;
    subplot(2, 3, i);
    imshow(G, []);title(sprintf('D0 = %d', D0(i)));
    % saveas(gcf, sprintf('./res/res2/ButterHigh_D0=%d.jpg', D0(i)));
end
 saveas(gcf, './res/res2/ButteHighComparison.jpg');