function[g] = segmentation(originImg)
    f = originImg;
    %ȫ����ֵ�ָ�
    count = 0;
    T = mean2(f);
    done = false;
    while ~done
        count = count + 1;
        g = f > T;
        Tnext = 0.5 * (mean(f(g)) + mean(f(~g)));
        done = abs(T - Tnext)<0.5;
        T = Tnext;
    end
    g = imbinarize(f, T/255);
    figure; subplot(2, 2, 1); imshow(f);title('ԭͼ��');
    subplot(2, 2, 2); imhist(f); title('fֱ��ͼ');
    subplot(2, 2, 3); imshow(g); title('��ֵ��ͼ��');
end
