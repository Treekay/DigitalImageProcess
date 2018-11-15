% 读取原图像
originImg = imread('./src/sport car.pgm');
[M, N] = size(originImg);
figure;
subplot(2,2,1), imshow(originImg);title('origin image'); %显示原图

% 产生两个不同的随机矩阵
t1 = rand(M, N)*255;
t2 = rand(M, N)*255;
% 产生椒盐噪声图像
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
subplot(2,2,2), imshow(noisyImg);title('noisy image'); % 显示椒盐噪声图像
imwrite(noisyImg, './res/noisyImg.jpg'); % 保存图像

% 对椒盐噪声图像做zeros padding
extendImg = zeros(M+2, N+2);
extendImg(2:M+1, 2:N+1) = noisyImg;
% 中值滤波
medianImg = zeros(M, N);
for i = 1:M
    for j = 1:N
        F = extendImg(i:i+2, j:j+2); % 用3*3窗口实现中值滤波
        medianImg(i, j) = median(F(:)); % 将原图该像素替换为3*3领域内的中值
    end
end
subplot(2,2,4), imshow(medianImg);title('my median filter'); % 显示中值滤波后的图像
imwrite(medianImg, './res/medianImg.jpg'); % 保存图像

% 与matlab中的medfilt2比较
subplot(2,2,3), imshow(medfilt2(noisyImg)); title('matlab medfilt2'); % 显示MATLAB实现的效果
saveas(gcf,'./res/compare.jpg'); % 保存比较结果