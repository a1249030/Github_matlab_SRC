
function [ClassNum, train_sample, train_label, test_sample, test_label] = main_setupData();

% �V�m��Ʈw���|
train_database = 'faces94\female';
% �V�m�˥���Ƨ�
train_folder = dir(train_database);
cd(train_database);
for i =3:length(train_folder)
    if(~exist('files'))
        files = [dir(train_folder(i).name)];
    else
        files = [files, dir(train_folder(i).name)];
    end
end
cd ..%
cd ..%

% ���ո�Ʈw���|
test_database = 'faces94\gotone\*jpg';
test_files = dir(test_database);

%{
% ���ռ˥���Ƨ�
t_f = dir(test_database);
for i = 1:length(t_f)
    if(isequal(t_f(i).name, 'gotone'))
        test_folder = t_f(i).name;
    end
end
%}


image_fmt = '.jpg';
% ���O�ƶq
ClassNum = length(train_folder);% �٨S�h���h�l����Ƨ�
% �C�����V�m�B���ռ˥���
train_sample_size = 1;%size(files, 1)-2;
test_sample_size = 1;
% �Ϥ����B�e
%[cols rows] = size(rgb2gray(imread(strcat(train_database, '\', train_folder(3).name, '\', train_folder(3).name,'.',num2str(1),image_fmt))));

%train_tol = size(files,1) * size(files,2);


%�V�m�˥���
index = 1;
for i = 1:ClassNum% �C�Ӹ�Ƨ�
    % readsample(��Ʈw���| ��Ƨ� ���O���� �C�����V�m�˥��� row column fmt)
    if( ~isequal(train_folder(i).name, '.')&&...
            ~isequal(train_folder(i).name, '..'))        
        if(~exist('train_sample') && ~exist('train_label'))            
            [train_sample, train_label] = my_readsample(train_database, train_folder(i).name, index, train_sample_size, image_fmt);
            index = index + 1;
        else            
            [ts, tl] = my_readsample(train_database, train_folder(i).name, index, train_sample_size, image_fmt);
            train_sample = [train_sample ts];
            train_label = [train_label tl];
            index = index + 1;
            %tl = unique(train_label);% ���O���޸��X
            %tn = histc(train_label, tl);% ���Ʀ���
        end
    end    
end
%clear tl;
%clear tn;
% ���ռ˥�
%test_files = dir(strcat(test_database, '\', test_folder, '\*jpg'));
for i =1:length(test_files)    
    if(~exist('test_sample') && ~exist('test_label'))        
        [test_sample, test_label] = my_readsample('faces94\gotone\', test_files(i).name, i, test_sample_size, image_fmt);
    else       
        [ts, tl] = my_readsample('faces94\gotone\', test_files(i).name, i, test_sample_size, image_fmt);
        test_sample = [test_sample ts];
        test_label = [test_label tl];
        index = index + 1;
        %tl = unique(test_label);% ���O���޸��X
        %tn = histc(test_label, tl);% ���Ʀ���
    end
end

save setupData.mat ClassNum train_sample train_label test_sample test_label;
