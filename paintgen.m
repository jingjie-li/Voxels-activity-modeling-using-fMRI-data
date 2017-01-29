function pic=paintgen(projavged,dataTrnS1,posi,i)
    [h,~,~,~,~,~]  = inittrain(projavged,dataTrnS1,i);
    pic=zeros(128,128);
    for k=1:233
        gf=gabor_field(posi(3,k),posi(1,k),posi(2,k));% make RF map
        pic=pic+gf*abs(h(k+1));
    end
    pic=pic/233;
end