function gabpara=gabpara()
% for generate gabor parament of this projection
% a single colnume corresponding to the parament of a single colnume of the
% projection martix
%the first row is the angle
%secound...FOV..of sf
%...x posi
%...y posi
%...numbers
    gabpara=zeros(5,1864);
    count=1;
    for i=1:5
        %pause();
        FOV=2^(i-1);
        lambda=128/FOV;
        if FOV==2
            x0=-32;
            y0=x0;
        elseif FOV==4
            x0=-48;
            y0=x0;
        elseif FOV==8
            x0=-56;
            y0=-56;
        elseif FOV==1
            x0=0;
            y0=0;
        else
            x0=-60;
            y0=-60;
        end
        for angle=0:22.5:7*22.5
            pp=1;
            for j=0:FOV-1
                for k=0:FOV-1
                    temp=sqrt((x0+j*lambda)^2+(y0+k*lambda)^2);
                    if temp>60
                        %projaf=[projaf(:,1:count-1),projaf(:,count+1:end)];
                    else
                        %x0+j*lambda
                        %y0+k*lambda
                        gabpara(1,count)=angle;
                        gabpara(2,count)=FOV;
                        gabpara(3,count)=x0+j*lambda;
                        gabpara(4,count)=y0+k*lambda;
                        gabpara(5,count)=pp;
                        count=count+1;
                        pp=pp+1;
                    end
                end
            end
        end
    end
end