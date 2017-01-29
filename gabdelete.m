function projaf=gabdelete(proj)
% delete the gabor patch that out of the boundary of the vision field
    projaf=proj;
    count=1;
    for i=1:5
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
            for j=0:FOV-1
                for k=0:FOV-1
                    temp=sqrt((x0+j*lambda)^2+(y0+k*lambda)^2);% the distance from the center
                    if temp>60%delete the gabor patch that out of this
                        projaf=[projaf(:,1:count-1),projaf(:,count+1:end)];
                    else
                        count=count+1%display the process
                    end
                end
            end
        end
    end
end