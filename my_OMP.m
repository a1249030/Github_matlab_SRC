function [A] = my_OMP(D,X,L)

% ?�J??: % D - ?��?�r��A�`�N�G��?�r�媺�U�C��???�F?�S��

% X - �H?

%L - �t?���D�s��??���̤j�ȡ]�i?�A�q??D���C?�A�t�ץi��C�^

% ?�X??: % A - �}���t?

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