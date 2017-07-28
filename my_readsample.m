% Sampling comleted %

% ��ƥΨ�Ū���˥�
% ��J�G
%   address�G�nŪ�����˥����|
%   ClassNum�G�N��nŪ���˥������O��
%   data�G�˥�����
%   rows�G�˥����
%   cols�G�˥��C��
%   image_fmt�G�Ϥ��榡
% ��X�G
%   sample�G�˥��x�}�A�C�C���@�Ӽ˥��A�C�欰�@���S�x
%   label�G�˥�����

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