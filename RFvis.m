%% visualize RF posi&caculate
hsums=zeros(234,25915);
RMSEres=zeros(1,25915);
R2=zeros(1,25915);
ifplot=1;%if plot?
for i=23189:25915
    ehisnan=dataTrnS1(i,:);
    ehisnan1=ehisnan(1,1600:1750);
    ehisnan=ehisnan(1,1:200);
    ehisnan(isnan(ehisnan))=0;
    ehisnan1(isnan(ehisnan1))=0;
    if sum(ehisnan)==0||sum(ehisnan1)==0
        continue%exclude the nan elements
    end
    [hsums(:,i),~,RMSEres(i),R2(i),~,~]  = inittrain(projavged,dataTrnS1,i);
    if ifplot==1
    h=hsums(:,i);
    pic=zeros(128,128);
    for k=1:233
        gf=gabor_field(posi(3,k),posi(1,k),posi(2,k));% make RF map
        pic=pic+gf*abs(h(k+1));
    end
    pic=pic/233;
    [ field,~,~ ] = gaufitcomp( pic );% using gausses function to fit the RF map
    imshow(pic,[])
    if roiS1(i)==0
        title(sprintf('voxel:other aera,num:%d field:%.3f',i,field));
    elseif roiS1(i)==1
        title(sprintf('voxel:V1,num:%d field:%.3f',i,field));
    elseif roiS1(i)==2
        title(sprintf('voxel:V2,num:%d field:%.3f',i,field));
    elseif roiS1(i)==3
        title(sprintf('voxel:V3,num:%d field:%.3f',i,field));
    elseif roiS1(i)==4
        title(sprintf('voxel in V3A,num:%d field:%.3f',i,field));
    elseif roiS1(i)==5
        title(sprintf('voxel in V3B,num:%d field:%.3f',i,field));
    elseif roiS1(i)==6;
        title(sprintf('voxel in V4,num:%d field:%.3f',i,field));
    else
        title(sprintf('voxel in LatOcc,num:%d field:%.3f',i,field)); 
    end
    pause()
    end
    fprintf('num: %d\n',i);
end