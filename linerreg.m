function [ h,RMSEaf,RMSEresaf,R2,R2st,count ] = linerreg( X,Y,Xst,Yst )
%liner regression function with the early stopping gradint descent
%   Y=Xh...Xst,Yst is the stopping set
    count=0;
    p=size(X,1);
    q=size(X,2);
    h=zeros(q,1);
    g=zeros(q,1);
    RMSE=100;
    RMSEaf=99;
    RMSEres=100;
    RMSEresaf=99;
    R2=0;
    R2st=0;
while(RMSEaf<RMSE&&RMSEresaf<RMSEres)
    RMSE=RMSEaf;
    RMSEres=RMSEresaf;
    %h=h-0.001*g;
    g=(X'*(X*h-Y))/norm(X'*(X*h-Y))+0.9*g;%eraly stopping grandint descent
    %g=(X'*(X*h-Y));
    h=h-0.001*g;
    Ystp=Xst*h;
    Yrep=X*h;
    [R2,RMSEaf]=rsquare(Yst,Ystp);
    [R2st,RMSEresaf]=rsquare(Y,Yrep);
    count=count+1;
    if count>1500
        break
    end
    %fprintf('num:%d devist:%.4f devi :%.4f R2:%.4f R2st:%.4f\n',count,RMSEaf,RMSEresaf,R2,R2st);%display the num&devi
end
end

