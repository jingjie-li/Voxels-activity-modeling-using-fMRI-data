function h=travoxmdl(proj,dataTrnS1,i)
% proj--->x
% dataTrnS1(i,1:1400)----->Y
% dataTrnS1(i,1401:1750)---->Yst
% i---->num of the target voxel
% for a single voxels
    p=1400;
    q=size(proj,2);
    Y=dataTrnS1(i,1:1400);
    Ycnannum=[];
    for k=1:1400
        if ~isnan(Y(k))
            Ycnannum=[Ycnannum,k];
        end
    end
    Y=Y(Ycnannum);
    X=proj;
    Xst=X(1401:1750,:);
    Xst=[ones(350,1),Xst];
    X=X(1:p,:);
    h=zeros(q+1,1); 
    Ys=Y-mean(Y);
    Ys=Ys';
    Xp=zeros(1400,q);
    for j=1:q
        Xp(:,j)=(X(:,j)-mean(X(:,j)))/std(X(:,j));
    end
    Xp(isnan(Xp))=0;
    Xp=[ones(1400,1),Xp];
    Xp=Xp(Ycnannum,:);   
    h=zeros(q+1,1);
    g=zeros(q+1,1);
    devi=100;
    deviaf=99;
    devires=100;
    deviresaf=99;
    Yst=dataTrnS1(i,1401:1750);
    count=0;
    Ystcnannum=[];
    for k=1:350
        if ~isnan(Yst(k))
            Ystcnannum=[Ystcnannum,k];
        end
    end
    Yst=Yst(Ystcnannum);
    Xst=Xst(Ystcnannum,:);
while(abs(deviaf-devi)>10^-4&&abs(deviresaf-devires)>10^-4)
    devi=deviaf;
    devires=deviresaf;
    %h=h-0.001*g;
    g=(Xp'*(Xp*h-Ys))/norm(Xp'*(Xp*h-Ys))+0.9*g;%eraly stopping grandint descent
    %g=(Xp'*(Xp*h-Ys));
    h=h-0.001*g;
    Ystp=Xst*h;
    Yrep=Xp*h;
    deviaf=sqrt((Yst'-Ystp)'*(Yst'-Ystp));
    deviresaf=sqrt((Ys-Yrep)'*(Ys-Yrep));
    count=count+1;
    fprintf('num:%d devi in stop:%.4f devi set:%.4f\n',count,deviaf,deviresaf);
end
    h(2:end)=h(2:end)./std(X)';
    h(isnan(h))=0;
end