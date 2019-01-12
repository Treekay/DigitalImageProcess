function [resultMat] = dilationMask2(originMat)
    [row, col] = size(originMat);
    resultMat = zeros(row, col);
    for i = 1:row
        for j = 1:col
            if originMat(i, j) == 1 || ...
                j - 1 > 0 && originMat(i, j - 1) == 1 || ...
                i + 1 <= row && originMat(i + 1, j) == 1
                resultMat(i, j) = 1;
            else
                resultMat(i, j) = 0;
            end
        end
    end
end