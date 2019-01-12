function [resultMat] = dilationMask1(originMat)
    [row, col] = size(originMat);
    resultMat = zeros(row, col);
    for i = 1:row
        for j = 1:col
            if originMat(i, j) == 1 || ...
                j + 1 <= col && originMat(i, j + 1) == 1 || ...
                j + 2 <= col && originMat(i, j + 2) == 1
                resultMat(i, j) = 1;
            else
                resultMat(i, j) = 0;
            end
        end
    end
end