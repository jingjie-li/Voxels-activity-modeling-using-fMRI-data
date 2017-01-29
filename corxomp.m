accurancy=zeros(1,10);
load('EstimatedResponses.mat')
load('500comp.mat')
load('selectr2.mat')
for amount=50:50:500
%% make prediction
load('projVal.mat')
%amount=300;
projVal=[ones(120,1),projVal];
YpredictS1=projVal*hsums(:,1:amount);
YpredictS1=YpredictS1';
Ytrue=dataValS1(selR2(1:amount),:);
%% noise ceiling
Ytrue(isnan(Ytrue))=0;
for i=1:amount
    Ytrue(i,:)=Ytrue(i,:)-bootstrape(Ytrue(i,:),120);
    YpredictS1(i,:)=YpredictS1(i,:)-bootstrape(YpredictS1(i,:),120);
end
%% comp cor
cormax=ones(120,120);
for i=1:120
    for j=1:120
    Ycnannum=[];
    Y=Ytrue(:,i);
    X=YpredictS1(:,j);
    for k=1:amount
        if ~isnan(Y(k))
            Ycnannum=[Ycnannum,k];
        end
    end
    Y=Y(Ycnannum);
    X=X(Ycnannum);
    corvox=corrcoef(X,Y);
    cormax(i,j)=corvox(2,1);%ith true signal vs j th predict signal
    end
    fprintf('processing......%d\n',i);
end
%imshow(kron(cormax,ones(2,2)),[]);colormap('default')
%% count
count=0;
for i=1:120
    if max(cormax(i,:))==cormax(i,i);
        count=count+1;
    end
end
acc=count/120;
accurancy(amount/50)=acc;
fprintf('accuracy:%.4f amount:%.4f \n',acc,amount)
end