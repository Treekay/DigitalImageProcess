K = 81;
trainNum = 7 * 40; % ѵ��ͼƬ����
testNum = 3 * 40; % ����ͼƬ����
height = 112; % ͼƬ�߶�
width = 92; % ͼƬ���
xlspath = 'res/testRes.xlsx';

% ��¼��������ά������ȷ��
randomSeq = zeros(trainNum, 10);
trainImgs = zeros(trainNum, height, width);
for i = 1 : 40
    % ����һ��������е�1-10����
    % ����ǰ 7 λ���ֶ�Ӧ��ͼ������ѵ��
    % ���к� 3 λ���ֶ�Ӧ��ͼ����������
    randomSeq(i, :) = randperm(10);
    imgs = zeros(7, height, width);
    for j = 1 : 7
        imgs(j, :, :) = uint8(imread(['src/s' num2str(i) '/' num2str(randomSeq(i, j)) '.pgm']));
    end
    trainImgs((i - 1) * 7 + 1 : i * 7, :, :) = imgs;
end
trainImgs = uint8(trainImgs);

% �� 280 ��ѵ��ͼ�������1ά��������ƴ��
% ÿ��ͼ�����ظ���Ϊ 112 * 92 = 10304
% �õ� 10304 * 280 �����ݾ��� X
centralizationMatrix = zeros(height * width, trainNum);
for i = 1 : trainNum
    centralizationMatrix(:, i) = reshape(trainImgs(i, :, :), [height * width, 1]);
end
% ���������ݾ��������ֵ����
meanImg = mean(centralizationMatrix, 2);
% X ��ÿ�м�ȥ��ֵ�����������Ļ�
for i = 1: trainNum
   centralizationMatrix(:, i) = centralizationMatrix(:, i) - meanImg; 
end
% ��� X ��ת�ú� X �ľ���˻��õ�Э�������
meanMatrix = centralizationMatrix' * centralizationMatrix;
% �� matlab �� eig ���������������
[featureVector, temp] = eig(meanMatrix);
% ѡ��ǰ K �������ֵ��Ӧ���������� W
featureVector = featureVector(:, trainNum - K + 50 + 1: trainNum);
% �� X ���� W ӳ��õ� V
basisVector = centralizationMatrix * featureVector;
% �� V ��ÿһ��������Ϊ����ӳ���ϵ��һ�������(������)
% �� X ÿһ�ж�ͨ������������ V ӳ�䵽��Ӧ�������ռ���
eigenfaces = basisVector' * centralizationMatrix;

% ����ÿ������ͼ��Ҳת������������ȥ��ֵ���������Ļ�
% Ȼ���û���������ӳ�䵽�����ռ���
for i = 1 : 40
    mkdir('res/', num2str(i));
    for j = 8 : 10
        % ��ȡ����ͼ��
        testImg = imread(['src/s' num2str(i) '/' num2str(randomSeq(i, j)) '.pgm']);
        imwrite(testImg, ['res/' num2str(i) '/' num2str(j) '.jpg']);
        % ���Ļ�
        testImg = double(reshape(testImg, [height * width, 1])) - meanImg;
        % �����ʶ��ͼ���ͶӰ
        testImg = basisVector' * testImg;
        [~, trainNum] = size(eigenfaces);
        % �����ʶ��ͼ���ͶӰ����ʮ��ѵ��ͼ���������ռ������Ķ�����
        % �������������ҵ���������С��ͼ��Ϊʶ��ƥ�����ͼ��
        maxDist = Inf;
        matchImg = 0;
        for k = 1 : trainNum
            currentDist = norm(double(testImg) - eigenfaces(:, k), 2);
            if maxDist > currentDist
                matchImg = k;
                maxDist = currentDist;
            end
        end
        matchImg = floor((matchImg - 1) / 7) + 1;
        imwrite(imread(['src/s' num2str(matchImg) '/' num2str(randomSeq(matchImg, rem(matchImg - 1, 7) + 1)) '.pgm']), ['res/' num2str(i) '/' num2str(j) '_match.jpg']);
    end
end