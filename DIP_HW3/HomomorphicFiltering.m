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
D0 = [100, 200, 300, 500, 800, 1000];
rh = 2.0;
rl = 0.25;
C = 1.0;
HomomorhicFilter = zeros(m, n);
G = zeros(m, n);
for i = 1 : length(D0)
    G = fourierImg;
    % ����̬ͬ�˲���
    HomomorphicFilter = (rh-rl).*(1-exp((-C).*(((M - m/2).^2+(N - n/2).^2)./D0(i).^2)))+rl;
    % ̬ͬ�˲�
    G = G .* HomomorphicFilter;
     % ��DFT�任
    G = real(ifft2(G));
    % ��ȡָ����ȡʵ��
    G=real(exp(G))-1;
    % ��ͼ������ֵӳ�䵽 [0,255]
    G = uint8(255.*(G-min(min(G)))./(max(max(G))-min(min(G))));
    % figure;
    subplot(2, 3, i);
    imshow(G);title(sprintf('D0 = %d', D0(i)));
    % saveas(gcf, sprintf('./res/Homomorphic_%d.jpg', D0(i)));
end
saveas(gcf, './res/Homorphic.jpg');
