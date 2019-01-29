global trainNum testNum;
global height width;
global K; % ����ά��
trainNum = 7 * 40; % ѵ��ͼƬ����
testNum = 3 * 40; % ����ͼƬ����
height = 112; % ͼƬ�߶�
width = 92; % ͼƬ���

% ��¼��������ά������ȷ��
accuracy = zeros(100);
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
    X = zeros(height * width, trainNum);
    for i = 1 : trainNum
        X(:, i) = reshape(trainImgs(i, :, :), [height * width, 1]);
    end
    % ���������ݾ��������ֵ����
    meanImg = mean(X, 2);
    % X ��ÿ�м�ȥ��ֵ�����������Ļ�
    for i = 1: trainNum
       X(:, i) = X(:, i) - meanImg; 
    end
    % ��� X ��ת�ú� X �ľ���˻��õ�Э�������
    L = X' * X;
    % �� matlab �� eig ���������������
    [W, D] = eig(L);
    % ѡ��ǰ K �������ֵ��Ӧ���������� W
    W = W(:, trainNum - K + 1 : trainNum);
    % �� X ���� W ӳ��õ� V
    V = X * W;
    % �� V ��ÿһ��������Ϊ����ӳ���ϵ��һ�������(������)
    % �� X ÿһ�ж�ͨ������������ V ӳ�䵽��Ӧ�������ռ���
    eigenfaces = V' * X;
    
    % ����ÿ������ͼ��Ҳת������������ȥ��ֵ���������Ļ�
    % Ȼ���û���������ӳ�䵽�����ռ���
    for i = 1 : 40
        for j = 8 : 10
            % ��ȡ����ͼ��
            f = imread(['src/s' num2str(i) '/' num2str(randomSeq(i, j)) '.pgm']);
            % ���Ļ�
            f = double(reshape(f, [height * width, 1])) - meanImg;
            % �����ʶ��ͼ���ͶӰ
            f = V' * f;
            [~, trainNum] = size(eigenfaces);
            % �����ʶ��ͼ���ͶӰ����ʮ��ѵ��ͼ���������ռ������Ķ�����
            % �������������ҵ���������С��ͼ��Ϊʶ��ƥ�����ͼ��
            maxDist = Inf;
            matchImg = 0;
            for k = 1 : trainNum
                currentDist = norm(double(f) - eigenfaces(:, k), 2);
                if maxDist > currentDist
                    matchImg = k;
                    maxDist = currentDist;
                end
            end
            matchImg = floor((matchImg - 1) / 7) + 1;
            if matchImg == i
                accuracy(K) = accuracy(K) + 1;
            end
        end
    end
    accuracy(K) = double(accuracy(K) / (testNum));
end
plot(accuracy);
axis([50 100 0.8 1]);