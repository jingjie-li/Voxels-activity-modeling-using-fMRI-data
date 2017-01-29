function [ projavged ] = avg8angles( gabpara,proj )
%avg8angles function for average 8 angles of the gabor projection
%   No Detailed explanation 
projavged=zeros(1750,233);
p=proj';
for i=1:8
    projavged(:,1)=sum(p(1:8,:))';
end
for i=9:40
    projavged(:,1+gabpara(5,i))=projavged(:,1+gabpara(5,i))+p(i,:)';
end
for i=41:136
    projavged(:,5+gabpara(5,i))=projavged(:,5+gabpara(5,i))+p(i,:)';
end
for i=137:488
    projavged(:,17+gabpara(5,i))=projavged(:,17+gabpara(5,i))+p(i,:)';
end
for i=489:1864
    projavged(:,61+gabpara(5,i))=projavged(:,61+gabpara(5,i))+p(i,:)';
end
projavged=projavged/8;%average
end