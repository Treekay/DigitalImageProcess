% �����˶�ģ��ͼ��
function [blurredImg, H] = BlurFilter(sourceImg)
    % ��ȡԭͼƬ
    [m, n] = size(sourceImg);

    % ���ı任
    [N, M] = meshgrid(1:n, 1:m);
    centreImg = double(sourceImg).*(-1).^(M + N);
    u = M - 1 - m / 2;
    v = N - 1 - n / 2;

    % ����Ҷ�任
    F = fft2(centreImg);

    % ���� blurring filter
    T = 1.0;
    a = 0.1;
    b = 0.1;
    k = u .* a + v .* b;
    H = T ./ (pi .* k) .* sin(pi .* k) .* exp((-1i * pi) .* k);
    H(k == 0) = T;

    % ͼ���˻�
    G = H .* F;

    % ��DFT�任��ȡʵ��
    realG = real(ifft2(G));

    % �����ı任
    blurredImg = realG .* (-1).^(M + N);
end