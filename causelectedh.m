%h=zeros(1865,3706);
%for i=2823:3706
    %[h(:,i),deviaf,deviresaf]  = inittrain(proj,dataTrnS1,sv(i));
    %fprintf('num:%d devi in stop set:%.4f devi:%.4f\n',i,deviaf,deviresaf);
%end
%% select
R2=[R2;1:25915];
R2=-1*R2';
sortR2=-1*sortrows(R2,1);
selR2=sortR2(1:500,2)';
%% train in detail
hsums=zeros(1864,500);
RMSEre_500=zeros(1,500);
R2_500=zeros(1,500);
for i=1:500
    j=selR2(i);
    [hsums(:,i),~,RMSEre_500(i),R2_500(i),~,~]  = inittrain(proj,dataTrnS1,j);
    fprintf('num:%d voxel:%d\n',i,j)
end