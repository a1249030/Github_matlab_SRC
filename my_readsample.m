% Sampling comleted %

% 函數用來讀取樣本
% 輸入：
%   address：要讀取的樣本路徑
%   ClassNum：代表要讀取樣本的類別數
%   data：樣本索引
%   rows：樣本行數
%   cols：樣本列數
%   image_fmt：圖片格式
% 輸出：
%   sample：樣本矩陣，每列為一個樣本，每行為一類特徵
%   label：樣本標籤

function [sample,label]=my_readsample(address, folder, index, size, image_fmt)

allsamples=[];
label=[];
%ImageSize=rows*cols;

for i = 1:size
    if(~isequal(address, 'faces94\gotone\'))
        %fprintf('ClassNum: %d size: %d \n', index, i);
        %fprintf('%s\n\n', strcat(address, '\', folder, '\', folder,'.',num2str(i),image_fmt));
        img=imresize(rgb2gray(imread(strcat(address, '\', folder, '\', folder,'.',num2str(i),image_fmt))), 0.5);
        %[rows, cols] = size(img,1);
        img = double(img);
        % PCA
        %coeff = pca(img);
        %newMatrix = img * coeff;
        %[c, r] = size(newMatrix);
        
        resize_img = reshape(img,  9000, 1);
        %Ipc = reshape(resize_img,200,180);
        %figure, imshow(Ipc,[]);        
        allsamples=[allsamples,resize_img];
        label=[label,index];        
    else
        %fprintf('%s\n', strcat(address, folder));
        img = imresize(rgb2gray(imread(strcat(address, folder))), 0.5);
        %[rows, cols] = size(img);
        img = double(img);
        % PCA
        %coeff = pca(img);
        %newMatrix = img * coeff;
        %[c, r] = size(newMatrix);
        
        resize_img = reshape(img, 9000, 1);
        %Ipc = reshape(resize_img,200,180);
        %figure, imshow(Ipc,[]);        
        allsamples=[allsamples,resize_img];
        label=[label,index];        
    end
end

sample=allsamples;