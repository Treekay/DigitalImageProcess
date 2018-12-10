% ����ͼƬ
sourceImg = imread('./src/car.png'); 
targetImg = imread('./src/wheel.png');
[R,C] = size(sourceImg);
[M,N] = size(targetImg);

% ģ��ԭ��
rpad = floor(M/2)+1;
cpad = floor(N/2)+1;  
% ��ԭͼ��zero padding
extendImg = zeros(R+M-1, C+N-1); 
extendImg(rpad:(rpad+R-1), cpad:(cpad+C-1)) = sourceImg;

% ���ֵ���
G = zeros(R, C); % ���ֵ����
mask = double(targetImg);
for i = 1:R
    for j = 1:C
        % ƥ�䲿��
        F = double(extendImg(i:i+M-1, j:j+N-1));
        % ��һ���������ֵ
        numerator = sum(sum(mask .* F)); % ����
        denominator = sqrt(sum(sum(mask.^2) * sum(sum(F.^2)))); % ��ĸ
        G(i, j) = numerator / denominator;
    end
end

% ��ʾͼ������ֵ���
G = im2uint8(mat2gray(G));
figure, imshow(G);
imwrite(G, './res/CorrelationImg.jpg'); % ����ͼ��
% �г���ͼ���м�⵽������Ŀ���(x, y)����
[y, x] = find(G > 0.9 * max(G(:))); %  ���ص�������(row, col), ����������[y, x]
file = fopen('./res/target.txt', 'w');
for i = 1:length(x)
    fprintf(file, '(%d, %d)\n', x(i), y(i));
end
fclose(file);

% ��ԭͼ�б�ǳ���⵽������
figure,imshow(sourceImg);
for i = 1:length(x)
    line([x(i)-N/2, x(i)+N/2], [y(i)-M/2, y(i)-M/2]);
    line([x(i)-N/2, x(i)+N/2], [y(i)+M/2, y(i)+M/2]);
    line([x(i)+N/2, x(i)+N/2], [y(i)-M/2, y(i)+M/2]);
    line([x(i)-N/2, x(i)-N/2], [y(i)-M/2, y(i)+M/2]);
end
saveas(gcf, './res/DetectImg.jpg');