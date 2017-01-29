%% DO NOT RUN THIS SCRIPT DIRECTLY!! RUN IT SECTIONALLY
%% for computing proj martix
proj=zeros(1750,2728);
for i=1:1750
    for j=1:2:5456
        a=reshape(stimTrn(i,:,:),[1,16384]);
        b=reshape(gab(:,:,j),[16384,1]);
        c=reshape(gab(:,:,j+1),[16384,1]);
        t1=(a*b)/sqrt(b'*b);
        t2=(a*c)/sqrt(c'*c);
        proj(i,(j+1)/2)=sqrt(t1^2+t2^2);
    end
    t1=i%looking process
end
%% for computing proj martix for the test set
projVal=zeros(120,2728);
for i=1:120
    for j=1:2:5456
        a=reshape(stimVal(i,:,:),[1,16384]);
        b=reshape(gab(:,:,j),[16384,1]);
        c=reshape(gab(:,:,j+1),[16384,1]);
        t1=(a*b)/sqrt(b'*b);
        t2=(a*c)/sqrt(c'*c);
        projVal(i,(j+1)/2)=sqrt(t1^2+t2^2);
    end
    t1=i%looking process
end
%% visualize gabor image
for i=1:5456
    test=(gab(:,:,i));%+0.5*reshape(stimTrn(10,:,:),[128,128]))./1.5;
    imshow(test,[-1,1])
    title(sprintf('num:%d',i));
    pause()
end
%% identification the trainnning model
%i=1;
%h=travoxmdl(proj,dataTrnS1,i);%get h
Y=dataTrnS1(1,1:1400);
Ycnannum=0;
for k=1:1400
    if isnan(Y(k))
        Ycnannum=[Ycnannum,k];
    end
end
X=[ones(1400,1),proj(1:1400,:)];
Yest=X*h;
Yest=Yest(Ycnannum);
corrcoef(Y(Ycnannum),Yest(Ycnannum))
sqrt(Y(Ycnannum)'*Yest(Ycnannum))
%% for computing 233 diff posi
    posi=zeros(3,233);
    posi(1,1)=gabpara(3,1);
    posi(2,1)=gabpara(4,1);
    posi(3,1)=128;
    posi(1,2:5)=gabpara(3,9:12);
    posi(2,2:5)=gabpara(4,9:12);
    posi(3,2:5)=64;
    posi(1,6:17)=gabpara(3,41:52);
    posi(2,6:17)=gabpara(4,41:52);
    posi(3,6:17)=32;
    posi(1,18:61)=gabpara(3,137:180);
    posi(2,18:61)=gabpara(4,137:180);
    posi(3,18:61)=16;
    posi(1,62:233)=gabpara(3,489:660);
    posi(2,62:233)=gabpara(4,489:660);
    posi(3,62:233)=8;
%% make orientation and spatial frequency
osfmar=zeros(5,8);
h=hsums(:,1);
osfmar(5,1:8)=h(2:9);
%h  = inittrain(proj,dataTrnS1,21672);
for i=1:8
    osfmar(4,i)=mean(h(10+4*(i-1):13+4*(i-1)));
    osfmar(3,i)=mean(h(42+12*(i-1):53+12*(i-1)));
    osfmar(2,i)=mean(h(138+44*(i-1):181+44*(i-1)));
    osfmar(1,i)=mean(h(490+172*(i-1):661+172*(i-1)));
end
imshow(kron(osfmar,ones(30,30)),[]);colormap('default');
%% make prediction
projVal=[ones(120,1),projVal];
YpredictS1=projVal*h;
YpredictS1=YpredictS1';
Ytrue=dataValS1(sv,:);
%% show img
for i=1:1109
    subplot(1,2,1)
    imshow(ppic(:,:,i),[]);
    field=fieldmax(i);
    [ fielda,other,res ] = gaufitcomp( ppic(:,:,i) );
    if roiS1(i)==0
        title(sprintf('voxel:other aera,num:%d field1:%.3f field2:%.3f',i,field,fielda));
    elseif roiS1(i)==1
        title(sprintf('voxel:V1,num:%d field:%.3f field2:%.3f',i,field,fielda));
    elseif roiS1(i)==2
        title(sprintf('voxel:V2,num:%d field:%.3f field2:%.3f',i,field,fielda));
    elseif roiS1(i)==3
        title(sprintf('voxel:V3,num:%d field:%.3f field2:%.3f',i,field,fielda));
    elseif roiS1(i)==4
        title(sprintf('voxel in V3A,num:%d field:%.3f field2:%.3f',i,field,fielda));
    elseif roiS1(i)==5
        title(sprintf('voxel in V3B,num:%d field:%.3f field2:%.3f',i,field,fielda));
    elseif roiS1(i)==6;
        title(sprintf('voxel in V4,num:%d field:%.3f field2:%.3f',i,field,fielda));
    else
        title(sprintf('voxel in LatOcc,num:%d field:%.3f field2:%.3f',i,field,fielda)); 
    end
    subplot(1,2,2)
    imshow(res,[])
    title(sprintf('sita: %.4f',other(4)));
    pause()
    fprintf('num: %d\n',i);
end
%%
for i=1:1109
    %subplot(1,2,1)
    
    field=fieldmax(i);
    [ fielda,other,res ] = gaufitcomp( ppic(:,:,i) );
    if roiS1(i)==0
        title(sprintf('voxel:other aera,num:%d field:%.3f',selectedvoxels(i),field));
    elseif roiS1(i)==1
        imshow(ppic(:,:,i),[]);
        title(sprintf('voxel:V1,num:%d field:%.3f',selectedvoxels(i),field));        
        pause()
    elseif roiS1(i)==2
        imshow(ppic(:,:,i),[]);
        title(sprintf('voxel:V2,num:%d field:%.3f',selectedvoxels(i),field));
        pause()
    elseif roiS1(i)==3
        title(sprintf('voxel:V3,num:%d field:%.3f',selectedvoxels(i),field));
    elseif roiS1(i)==4
        title(sprintf('voxel in V3A,num:%d field:%.3f',selectedvoxels(i),field));
    elseif roiS1(i)==5
        title(sprintf('voxel in V3B,num:%d field:%.3f',selectedvoxels(i),field));
    elseif roiS1(i)==6;
        title(sprintf('voxel in V4,num:%d field:%.3f',selectedvoxels(i),field));
    else
        imshow(ppic(:,:,i),[]);
        title(sprintf('voxel in LatOcc,num:%d field:%.3f',selectedvoxels(i),field)); 
        pause()    
    end
    %subplot(1,2,2)
    %imshow(res,[])
    %title(sprintf('sita: %.4f',other(4)));
    fprintf('num: %d\n',selectedvoxels(i));
end
%% test set
X=10*rand([500,200]);
X=[ones(500,1),X];
h=[rand([1,11]),zeros(1,190)]';
Y=X*h+10*rand();
Xst=X(351:500,:);
Yst=Y(351:500);
X=X(1:350,:);
Y=Y(1:350);
%% show img gaufit new
[x,y]=meshgrid(1:128);
for i=1:1109
    subplot(1,2,1)
    imshow(ppic(:,:,i),[]);
    field=fieldmax(i);
    [ ~,other,~] = gaufitcomp( ppic(:,:,i) );
    [ A ] = GaussianFit( ppic(:,:,i),other(2),other(3) );
    res=A(1)*exp( -((x-A(2)).^2/(2*A(3)^2) + (y-A(4)).^2/(2*A(3)^2)) );
    fielda=A(3);
    if roiS1(i)==0
        title(sprintf('voxel:other aera,num:%d field1:%.3f field2:%.3f',i,field,fielda));
    elseif roiS1(i)==1
        title(sprintf('voxel:V1,num:%d field:%.3f field2:%.3f',i,field,fielda));
    elseif roiS1(i)==2
        title(sprintf('voxel:V2,num:%d field:%.3f field2:%.3f',i,field,fielda));
    elseif roiS1(i)==3
        title(sprintf('voxel:V3,num:%d field:%.3f field2:%.3f',i,field,fielda));
    elseif roiS1(i)==4
        title(sprintf('voxel in V3A,num:%d field:%.3f field2:%.3f',i,field,fielda));
    elseif roiS1(i)==5
        title(sprintf('voxel in V3B,num:%d field:%.3f field2:%.3f',i,field,fielda));
    elseif roiS1(i)==6;
        title(sprintf('voxel in V4,num:%d field:%.3f field2:%.3f',i,field,fielda));
    else
        title(sprintf('voxel in LatOcc,num:%d field:%.3f field2:%.3f',i,field,fielda)); 
    end
    subplot(1,2,2)
    imshow(res,[])
    title('new');
    pause()
    fprintf('num: %d\n',i);
end
%% gausses fit test
[x,y]=meshgrid(1:128); X=zeros(128,128,2);
 X(:,:,1)=x; X(:,:,2)=y;
 A = [1,32,25,72];
 z1=A(1)*exp( -((X(:,:,1)-A(2)).^2/(2*A(3)^2) + (X(:,:,2)-A(4)).^2/(2*A(3)^2)) );
 z1=z1+rand(128,128);
 A=GaussianFit( z1,0,0 );
 z2=A(1)*exp( -((X(:,:,1)-A(2)).^2/(2*A(3)^2) + (X(:,:,2)-A(4)).^2/(2*A(3)^2)) );
 subplot(1,2,1)
 contour(z1)
 subplot(1,2,2)
 contour(z2);
%% count how many v1?2?3
amount=500;
other_aera=0;
V1=0;
V2=0;
V3=0;
V3A=0;
V3B=0;
V4=0;
LatOcc=0;
for j=1:amount
    i=selR2(j);
    if roiS1(i)==0
        other_aera=other_aera+1;
    elseif roiS1(i)==1
        V1=V1+1;
    elseif roiS1(i)==2
        V2=V2+1;
    elseif roiS1(i)==3
        V3=V3+1;
    elseif roiS1(i)==4
        V3A=V3A+1;
    elseif roiS1(i)==5
        V3B=V3B+1;
    elseif roiS1(i)==6;
        V4=V4+1;
    else
        LatOcc=LatOcc+1; 
    end
end
figpie=[other_aera,V1,V2,V3,V3A,V3B,V4,LatOcc];
labels = {'Other Aera','V1','V2','V3','V3A','V3B','V4','LatOcc' };
pie(figpie,labels);
%% random select
v = [0:0.1:100];
indx = randperm(101);
N = 20;
rv = v(indx);