% ���˶�ģ��ͼ��͸�˹����ͼ��������˲�
function [inverseBlur, inverseNoise] = InverseFilter(blurredImg, noiseImg, H)
    [m, n] = size(blurredImg);
    [N, M] = meshgrid(1:n, 1:m);
    
    % ���˶�ģ��ͼ�������˲�����
    % ���Ļ�
    centreBlur = blurredImg .* (-1).^(M + N);
    % ����Ҷ�任
    fourierBlur = fft2(centreBlur);
    % ���˲�
    inverseBlur = fourierBlur ./ H;
    inverseBlur(abs(H) < 0.001)=0;
    % ��DFT��ȡʵ��
    inverseBlur = real(ifft2(inverseBlur)); 
    % �����Ļ�
    inverseBlur = inverseBlur .* (-1).^(M + N);
    
    % �Ը�˹����ͼ�������˲�����
    % ���Ļ�
    centreNoise = noiseImg.*(-1).^(M + N);
    % ����Ҷ�任
    fourierNoise = fft2(centreNoise);
    % ���˲�
    inverseNoise = fourierNoise ./ H;
    inverseNoise(abs(H) < 0.001) = 0;
    inverseNoise = 1 ./ (1 + sqrt((M - m/2).^2 + (N - n/2).^2) ./ 20).^2 .* inverseNoise;
    % ��DFT��ȡʵ��
    inverseNoise = real(ifft2(inverseNoise));
    % �����Ļ�
    inverseNoise = inverseNoise .* (-1).^(M + N);
end