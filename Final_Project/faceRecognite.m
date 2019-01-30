global trainNum testNum;
global height width;
global K; % ����ά��
global T; % ���Դ���
trainNum = 7 * 40; % ѵ��ͼƬ����
testNum = 3 * 40; % ����ͼƬ����
height = 112; % ͼƬ�߶�
width = 92; % ͼƬ���
xlspath = 'res/testRes.xlsx';

% ��¼��������ά������ȷ��
accuracy = zeros(100, 10);
% ÿ������ά������ʮ��ȡƽ��
for T = 1 : 10
    % �Դ� 50 �� 100 �� ����ά���ֱ���в���
    for K = 50 : 100
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
        meanMatrix = mean(centralizationMatrix, 2);
        % X ��ÿ�м�ȥ��ֵ�����������Ļ�
        for i = 1: trainNum
           centralizationMatrix(:, i) = centralizationMatrix(:, i) - meanMatrix; 
        end
        % ��� X ��ת�ú� X �ľ���˻��õ�Э�������
        covarianceMatrix = centralizationMatrix' * centralizationMatrix;
        % �� matlab �� eig ���������������
        [featureVector, temp] = eig(covarianceMatrix);
        % ѡ��ǰ K �������ֵ��Ӧ���������� W
        featureVector = featureVector(:, trainNum - K + 1: trainNum);
        % �����Ļ����� X ���� W ӳ��õ����������� V
        basisVector = centralizationMatrix * featureVector;
        % ������������ V ��ÿһ��������Ϊ����ӳ���ϵ��һ�������(������)
        % �����Ļ����� X ÿһ�ж�ͨ������������ V ӳ�䵽��Ӧ�������ռ���
        eigenfaces = basisVector' * centralizationMatrix;

        % ����ÿ������ͼ��Ҳת������������ȥ��ֵ���������Ļ�
        % Ȼ���û���������ӳ�䵽�����ռ���
        matchNum = 0;
        for i = 1 : 40
            for j = 8 : 10
                % ��ȡ����ͼ��
                testImg = imread(['src/s' num2str(i) '/' num2str(randomSeq(i, j)) '.pgm']);
                % ���Ļ�
                testImg = double(reshape(testImg, [height * width, 1])) - meanMatrix;
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
                if matchImg == i
                    matchNum = matchNum + 1;
                end
            end
        end
        accuracy(K, T) = double(matchNum / testNum);
    end
end
xlswrite(xlspath, accuracy);
meanAccuracy = mean(accuracy, 2);
plot(meanAccuracy);
xlabel('����ά�� K');
ylabel('��ȷ��');
axis([50 100 0.8 1]);
saveas(gcf, 'res/testRes.jpg');