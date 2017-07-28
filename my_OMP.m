function [A] = my_OMP(D,X,L)

% ?入??: % D - ?完?字典，注意：必?字典的各列必???了?范化

% X - 信?

%L - 系?中非零元??的最大值（可?，默??D的列?，速度可能慢）

% ?出??: % A - 稀疏系?

if nargin==2

    L=size(D,2);

end

P=size(X,2);

K=size(D,2);

for k=1:1:P,

    a=[];

    x=X(:,k);

    residual=x;

    indx=zeros(L,1);

    for j=1:1:L,

        proj=D'*residual;

        [maxVal,pos]=max(abs(proj));

        pos=pos(1);

        indx(j)=pos;

        a=pinv(D(:,indx(1:j)))*x;

        residual=x-D(:,indx(1:j))*a;

        if sum(residual.^2) < 1e-6

            break;

        end

    end;

    temp=zeros(K,1);

    temp(indx(1:j))=a;

    A(:,k)=sparse(temp);

end;

return;

end