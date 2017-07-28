function [A,x]= my_MOD(y,codebook_size,errGoal)

%==============================

%input parameter

%   y - input signal

%   codebook_size - count of atoms

%output parameter

%   A - dictionary

%   x - coefficent

%==============================

if(size(y,2)<codebook_size)

    disp('codebook_size is too large or training samples is too small');

    return;

end

% initialization

[rows,cols]=size(y);

r=randperm(cols);

A=y(:,r(1:codebook_size));

A=A./repmat(sqrt(sum(A.^2,1)),rows,1);

mod_iter=10;

% main loop
tic;
for k=1:mod_iter

    % sparse coding

    if nargin==2

        x=my_OMP(A,y,5.0/6*rows);

    elseif nargin==3

        x=OMPerr(A,y,errGoal);

    end

    % update dictionary

    A=y*x'/(x*x');

    sumdictcol=sum(A,1);

    zeroindex=find(abs(sumdictcol)<eps);

    A(zeroindex)=randn(rows,length(zeroindex));

    A=A./repmat(sqrt(sum(A.^2,1)),rows,1);

    if(sum((y-A*x).^2,1)<=1e-6)

        break;

    end
    t = toc;
    fprintf('MOD is %d, time is %s\n', k, t);

end