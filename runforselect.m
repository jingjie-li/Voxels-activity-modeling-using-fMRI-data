%% FOR SELECT THE 'GOOD' VOXELS
%%initilize
hsums=zeros(234,25915);
selectedvoxels=[];
%%run
for i=1:26329
    ehisnan=dataTrnS1(i,:);
    ehisnan=ehisnan(1,1:200);
    ehisnan(isnan(ehisnan))=0;
    if sum(ehisnan)==0
        continue
    end
    hsums(:,i)  = inittrain(projavged,dataTrnS1,i);
    h=hsums(:,i);
    pic=zeros(128,128);
    for k=1:233
        gf=gabor_field(posi(3,k),posi(1,k),posi(2,k));
        pic=pic+gf*abs(h(k+1));
    end
    pic=pic/233;
    [ field,~ ] = gaufitcomp( pic );
    if field<=110&&field>5 %the therahold  of the gausses field
        selectedvoxels=[selectedvoxels,i];
    end
    fprintf('num: %d\n',i);%display the processing
end