% ά���˲���ԭ��˹����ͼ��
function [wienerImg] = WienerFilter(noiseImg, H)
    [m, n] = size(noiseImg);
    [N, M] = meshgrid(1:n, 1:m);
    
    conjH = conj(H); %  H����
    squareH = conjH .* H;
    K = [0.01, 0.03, 0.05];
    % �Ƚ�����ͼ��תΪƵ��ͼ��
    centreNoise = noiseImg.*(-1).^(M + N); % ���Ļ�
    fourierNoise = fft2(centreNoise); % ����Ҷ�任
    for i = 1:length(K)
       wienerFilter = squareH ./ (H .* (squareH + K(i)));
       wienerImg = wienerFilter .* fourierNoise;
       % ��DFT�任��ȡʵ��
       wienerImg = real(ifft2(wienerImg));
       % �����Ļ�
       wienerImg = wienerImg .* (-1).^(M + N);
       % ��ʾͼ��
       subplot(length(K)/3, 3, i);
       imshow(wienerImg, []); title(sprintf('wiener filter K=%f', K(i)));
    end
    saveas(gcf, 'res/WienerComparison.jpg');
end