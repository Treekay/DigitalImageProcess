% ��ȡԭͼ��
originImg = imread('./src/sport car.pgm');
[M, N] = size(originImg);
figure;
subplot(2,2,1), imshow(originImg);title('origin image'); %��ʾԭͼ

% ����������ͬ���������
t1 = rand(M, N)*255;
t2 = rand(M, N)*255;
% ������������ͼ��
noisyImg = zeros(M, N);
for i = 1:M
    for j =1:N
        if originImg(i, j) > t1(i, j)
            noisyImg(i, j) = 255;
        elseif originImg(i, j) < t2(i, j)
            noisyImg(i, j) = 0;
        else
            continue;
        end
    end
end
subplot(2,2,2), imshow(noisyImg);title('noisy image'); % ��ʾ��������ͼ��
imwrite(noisyImg, './res/noisyImg.jpg'); % ����ͼ��

% �Խ�������ͼ����zeros padding
extendImg = zeros(M+2, N+2);
extendImg(2:M+1, 2:N+1) = noisyImg;
% ��ֵ�˲�
medianImg = zeros(M, N);
for i = 1:M
    for j = 1:N
        F = extendImg(i:i+2, j:j+2); % ��3*3����ʵ����ֵ�˲�
        medianImg(i, j) = median(F(:)); % ��ԭͼ�������滻Ϊ3*3�����ڵ���ֵ
    end
end
subplot(2,2,4), imshow(medianImg);title('my median filter'); % ��ʾ��ֵ�˲����ͼ��
imwrite(medianImg, './res/medianImg.jpg'); % ����ͼ��

% ��matlab�е�medfilt2�Ƚ�
subplot(2,2,3), imshow(medfilt2(noisyImg)); title('matlab medfilt2'); % ��ʾMATLABʵ�ֵ�Ч��
saveas(gcf,'./res/compare.jpg'); % ����ȽϽ��