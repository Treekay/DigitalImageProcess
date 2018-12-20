% ���ɸ�˹����ͼ��ͼ��
function [noiseImg] = GaussianNoise(blurredImg)
    % ��ȡ�˶�ģ��ͼ��
    [m, n] = size(blurredImg);

    % ���ɸ�˹����
    mean = 0; 
    derivation = sqrt(500);
    gaussianNoise = normrnd(mean, derivation, m, n);

    % ��Ӹ�˹����
    noiseImg = blurredImg + gaussianNoise;
end