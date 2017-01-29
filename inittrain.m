function [ h,RMSEaf,RMSEresaf,R2,R2st,count ] = inittrain(proj,dataTrnS1,i)
%UNTITLED Summary of this function goes here
% proj--->x
% dataTrnS1(i,1:1400)----->Y
% dataTrnS1(i,1401:1750)---->Yst
% i---->num of the target voxel
% for a single voxels
    p=1550;
    q=size(proj,2);
    Y=dataTrnS1(i,1:p);
    Ycnannum=[];
    for k=1:p
        if ~isnan(Y(k))
            Ycnannum=[Ycnannum,k];% figure out the nan element
        end
    end
    Y=Y(Ycnannum);%exclude the nan element
    X=proj;
    Xst=X(p+1:size(proj,1),:);
    Xst=[ones(size(proj,1)-p,1),Xst];
    X=X(1:p,:);
    h=zeros(q+1,1); 
    Ys=Y-mean(Y);
    Ys=Ys';
    Xp=zeros(p,q);
    for j=1:q
        Xp(:,j)=(X(:,j)-mean(X(:,j)))/std(X(:,j));
    end
    Xp(isnan(Xp))=0;
    Xp=[ones(p,1),Xp];
    Xp=Xp(Ycnannum,:);   
    Yst=dataTrnS1(i,p+1:size(proj,1));
    Ystcnannum=[];
    for k=1:size(proj,1)-p
        if ~isnan(Yst(k))
            Ystcnannum=[Ystcnannum,k];
        end
    end
    Yst=Yst(Ystcnannum)';
    Xst=Xst(Ystcnannum,:);
    [ h,RMSEaf,RMSEresaf,R2,R2st,count ]=linerreg(Xp,Ys,Xst,Yst);% liner regression function
    %fprintf('num:%d devist:%.4f devi :%.4f R2:%.4f R2st:%.4f\n',count,RMSEaf,RMSEresaf,R2,R2st);
    h(2:end)=h(2:end)./std(X)';
    h(isnan(h))=0;
end

