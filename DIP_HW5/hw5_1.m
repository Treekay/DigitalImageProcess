addpath('func');
% 原矩阵
originMat = [0, 0, 0, 0, 0, 0, 0;
             0, 0, 1, 1, 0, 0, 0;
             0, 0, 0, 1, 0, 0, 0;
             0, 0, 0, 1, 1, 0, 0;
             0, 0, 1, 1, 1, 1, 0;
             0, 0, 1, 1, 1, 0, 0;
             0, 1, 0, 1, 0, 1, 0;
             0, 0, 0, 0, 0, 0, 0];
% 行列数
[row, col] = size(originMat);
         
% dilation1
resultMat = dilationMask1(originMat);
fprintf('dialation_1\n');
disp(resultMat);

% erosion1
resultMat = erosionMask1(originMat);
fprintf('erosion_1\n');
disp(resultMat);

% dilation2
resultMat = dilationMask2(originMat);
fprintf('dilation_2\n');
disp(resultMat);

% erosion2
resultMat = erosionMask2(originMat);
fprintf('erosion_2\n');
disp(resultMat);

% opening1
% Mask1 [1, 1, 1]
tempMat = erosionMask1(originMat);
resultMat = dilationMask1(tempMat);
fprintf('opening_1\n');
disp(resultMat);

% opening2
% Mask1 [1, 1; 0, 1]
tempMat = erosionMask2(originMat);
resultMat = dilationMask2(tempMat);
fprintf('opening_2\n');
disp(resultMat);

% closing1
% Mask1 [1, 1, 1]
tempMat = dilationMask1(originMat);
resultMat = erosionMask1(tempMat);
fprintf('closing_1\n');
disp(resultMat);

% closing2
% Mask1 [1, 1; 0, 1]
tempMat = dilationMask2(originMat);
resultMat = erosionMask2(tempMat);
fprintf('closing_2\n');
disp(resultMat);