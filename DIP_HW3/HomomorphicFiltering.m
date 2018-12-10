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

P = m / 2;
Q = n / 2;
D0 = [100, 300, 500, 800, 1000, 1500, 2000];
rank = 1;
rh = 2.0;
rl = 0.25;
C = 1.0;
HomomorhicFilter = zeros(m, n);
G = zeros(m, n);
for i = 1 : length(D0)
    G = fourierImg;
    % ����̬ͬ�˲���
    HomomorphicFilter = (rh-rl).*(1-exp((-C).*(((M-P).^2+(N-Q).^2)./D0(i).^2)))+rl;
    % ̬ͬ�˲�
    G = G .* HomomorphicFilter;
     % DFT ���任��ȡʵ��
    G = real(ifft2(G));
    % ��ȡָ������ȡʵ�������-1����Ϊ�������ʱ��+1
    G=real(exp(G))-1;
    % ��ͼ������ֵӳ�䵽 [0,255]
    G = uint8(255.*(G-min(min(G)))./(max(max(G))-min(min(G))));
    figure;
    imshow(G);title(sprintf('D0 = %d', D0(i)));
    saveas(gcf, sprintf('./res/Butterworth_%d.jpg', D0(i)));
end
