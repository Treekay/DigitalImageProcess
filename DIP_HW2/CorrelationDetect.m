% 读入图片
sourceImg = imread('./src/car.png'); 
targetImg = imread('./src/wheel.png');
[R,C] = size(sourceImg);
[M,N] = size(targetImg);

% 模板原点
rpad = floor(M/2)+1;
cpad = floor(N/2)+1;  
% 对原图做zero padding
extendImg = zeros(R+M-1, C+N-1); 
extendImg(rpad:(rpad+R-1), cpad:(cpad+C-1)) = sourceImg;

% 相关值检测
G = zeros(R, C); % 相关值矩阵
mask = double(targetImg);
for i = 1:R
    for j = 1:C
        % 匹配部分
        F = double(extendImg(i:i+M-1, j:j+N-1));
        % 归一化并求相关值
        numerator = sum(sum(mask .* F)); % 分子
        denominator = sqrt(sum(sum(mask.^2) * sum(sum(F.^2)))); % 分母
        G(i, j) = numerator / denominator;
    end
end

% 显示图像的相关值结果
G = im2uint8(mat2gray(G));
figure, imshow(G);
imwrite(G, './res/CorrelationImg.jpg'); % 保存图像
% 列出在图像中检测到的所有目标的(x, y)坐标
[y, x] = find(G > 0.9 * max(G(:))); %  返回的坐标是(row, col), 所以这里是[y, x]
file = fopen('./res/target.txt', 'w');
for i = 1:length(x)
    fprintf(file, '(%d, %d)\n', x(i), y(i));
end
fclose(file);

% 在原图中标记出检测到的像素
figure,imshow(sourceImg);
for i = 1:length(x)
    line([x(i)-N/2, x(i)+N/2], [y(i)-M/2, y(i)-M/2]);
    line([x(i)-N/2, x(i)+N/2], [y(i)+M/2, y(i)+M/2]);
    line([x(i)+N/2, x(i)+N/2], [y(i)-M/2, y(i)+M/2]);
    line([x(i)-N/2, x(i)-N/2], [y(i)-M/2, y(i)+M/2]);
end
saveas(gcf, './res/DetectImg.jpg');