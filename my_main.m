%{
fid = fopen('cp.txt', 'w');  
t = 1;
for i = 1:10
    fprintf(fid, 't = %d\n', t);
    t = t + i;
end
fclose(fid);

type cp.txt;

%}
clc
clear all
close all


profile on

% Set up Data
if(~exist('ClassNum'))
   if(exist('setupData.mat'))
    load('setupData.mat');
   else
    [ClassNum, train_sample, train_label, test_sample, test_label] = main_setupData();
   end
end
codebook_size = 19;
[Dictionary, coefficent] = my_MOD(train_sample, codebook_size);

%{
[eigenVectors_1,score_1,eigenValues_1,tsquare_1] = princomp(train_sample);
[eigenVectors_2,score_2,eigenValues_2,tsquare_2] = princomp(test_sample);
[arg_val, ind] = sort(eigenValues_1, 'descend');
W = eigenVectors_1(:,ind(1:300,:));
project = train_sample * W;




pca_dim = int32(size(train_sample,2)*0.95);
[train_W, train_project] = my_pca(train_sample, pca_dim);
[test_W, test_project] = my_pca(test_sample(:,1), pca_dim);

Euc_dist = [];
for i = 1:size(train_sample,2)
    q = train_project(:,i);
    temp = (norm(test_project - q))^2;
    Euc_dist = [Euc_dist temp];
end
OutputName = [];
[Euc_dist_min , Recognized_index] = sort(Euc_dist);
for i = 1:10
    OutputName = [OutputName Recognized_index(i)];
end
for i = 1:size(OutputName,2)
        fprintf('%d   ', OutputName(i));
end

%}
%{
OutputName = [];
for i = 1:size(test_sample,2)
    OutputName = [OutputName Recognition(test_sample(:,i), m, A, Eigenfaces)];
end
toc;

for i = 1:ClassNum - 2
    fprintf('query_img = %d \n result_img = \n', test_label(i));
    for j = 1:size(OutputName)
        fprintf('%d   ', OutputName(j,i));
    end
    fprintf('\n');
end
%}
% 查看樣本
%{
size = 50;
for i = 1:size
    Ipc = reshape(train_sample(:,i),200,180);
    figure, imshow(Ipc,[]);
end
%}
%[m, A, Eigenfaces] = EigenfaceCore(train_sample);
%{
%PCA降維
pca_dim = int32(size(train_sample,2)*0.95);
[Pro_Matrix,Mean_Image]=delete_my_pca(train_sample,pca_dim);
train_project=Pro_Matrix'*train_sample;
test_project=Pro_Matrix'*test_sample;

% 辨識率
tic;
[accuracy, xp, r, pre_label,ind] = computaccuracy(train_norm,ClassNum-2,train_label,test_norm,test_label);   
fprintf(2,'識別率為：%3.2f%%\n\n',accuracy*100);
fprintf('Accuracy of ');
toc;
fprintf('\n');

% 單張查詢
tic;
for i = 1:3
    tic;    
    query = i;% 查詢號碼
    query_image = test_norm(:,query);
    query_label = test_label(query);
    [result, query_xp, query_r, ind, query_accuracy] = my_search(train_norm, ClassNum-2, train_label, query_image, query_label, 1);
    fid = fopen('cp.txt', 'w');
    fprintf(fid, 'query = (%d), 查詢結果為：%d  ',query,result);
    fprintf(fid, '\n');
    fprintf(fid, '查詢類別：%3.2f%%\n\n',query_accuracy*100);
    fclose(fid);
    fprintf('query = (%d), 查詢結果為：%d  ',query,result);
    fprintf('\n');
    fprintf('查詢類別：%3.2f%%\n\n',query_accuracy*100);
    toc;    
end
fprintf('Query of ');
toc;
%}

%{
% 訓練集
%pca_dim = int32(size(train_sample,2)*0.95);
%train_project = my_pca(train_sample, pca_dim);
tic;
train_coeff = pca(train_sample);
train_project = train_sample * train_coeff;
fprintf('PCA of train_sample of ');
toc;
fprintf('\n');

% 測試集
%pca_dim = int32(size(test_sample,2)*0.95);
%test_project = my_pca(test_sample, pca_dim);
tic;
test_coeff = pca(test_sample);
test_project = test_sample * test_coeff;
fprintf('PCA of test_sample of ');
toc;
fprintf('\n');

%歸一化
tic;
train_norm = train_project/norm(train_project);
test_norm = test_project/norm(test_project);
fprintf('Normalization of ');
toc;
fprintf('\n');

% 辨識率
tic;
[accuracy, xp, r, pre_label,ind] = computaccuracy(train_norm,ClassNum-2,train_label,test_norm,test_label);   
fprintf(2,'識別率為：%3.2f%%\n\n',accuracy*100);
fprintf('Accuracy of ');
toc;
fprintf('\n');

% 單張查詢
tic;
for i = 1:3
    tic;    
    query = i;% 查詢號碼
    query_image = test_norm(:,query);
    query_label = test_label(query);
    [result, query_xp, query_r, ind, query_accuracy] = my_search(train_norm, ClassNum-2, train_label, query_image, query_label, 1);
    fid = fopen('cp.txt', 'w');
    fprintf(fid, 'query = (%d), 查詢結果為：%d  ',query,result);
    fprintf(fid, '\n');
    fprintf(fid, '查詢類別：%3.2f%%\n\n',query_accuracy*100);
    fclose(fid);
    fprintf('query = (%d), 查詢結果為：%d  ',query,result);
    fprintf('\n');
    fprintf('查詢類別：%3.2f%%\n\n',query_accuracy*100);
    toc;    
end
fprintf('Query of ');
toc;
%}
profile viewer




