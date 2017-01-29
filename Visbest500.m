%% visualize RF posi&caculate
%clear all
%load('selectr2.mat')
%load('projavged.mat')
%load('EstimatedResponses.mat')
%load('posi.mat')
ifplot=1;%if plot?
for j=1:10
    i=selR2(j);
    subplot(2,5,j)
    pic=paintgen(projavged,dataTrnS1,posi,i);
    imshow(kron(pic,ones(3,3)),[]);
    if roiS1(i)==0
        title(sprintf('voxel:other aera,num:%d',i));
    elseif roiS1(i)==1
        title(sprintf('voxel:V1,num:%d',i));
    elseif roiS1(i)==2
        title(sprintf('voxel:V2,num:%d',i));
    elseif roiS1(i)==3
        title(sprintf('voxel:V3,num:%d',i));
    elseif roiS1(i)==4
        title(sprintf('voxel in V3A,num:%d',i));
    elseif roiS1(i)==5
        title(sprintf('voxel in V3B,num:%d',i));
    elseif roiS1(i)==6;
        title(sprintf('voxel in V4,num:%d',i));
    else
        title(sprintf('voxel in LatOcc,num:%d',i)); 
    end
    pause()
    fprintf('num: %d\n',j);
    end
    