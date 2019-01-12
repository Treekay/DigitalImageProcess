addpath('func');
%¶ÁÈëÍ¼Ïñ
res1 = segmentation(imread('./src/blobz1.png'));
imwrite(res1, './res/res1.jpg'); 
res2 = segmentation(imread('./src/blobz2.png'));
imwrite(res2, './res/res2.jpg');