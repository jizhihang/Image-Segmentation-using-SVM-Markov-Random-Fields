function [data_matrix,class_matrix ] = feature_selector_hog(selected_pixels,bound_box,original_image,num_fgnd,num_bgnd,cs,bs,ob,fs,choice )
original_image=rgb2gray(original_image);
%rax pixel data
testvar=0;
cnt=0;
tp=1;
cnt1=0;
% fs=16;
ms=fs; %pixels taken will be inside the cell sized boundary of the image
if(numel(selected_pixels)~=0)
    mincbx= min(selected_pixels(1,:));
    maxcbx= max(selected_pixels(1,:));
    mincby= min(selected_pixels(2,:));
    maxcby= max(selected_pixels(2,:));
    i=bound_box(1)+ms+1;
    while( i<bound_box(2))
        i=i+1;
        j=bound_box(3);
        while(j<bound_box(4) && i<bound_box(2))
            j=j+1;
            p=((i-selected_pixels(1,:)).^2)+((j-selected_pixels(2,:)).^2);
            if (numel(find(p==0))~=0)
                if(mod(testvar,num_fgnd)==1 )
                    cnt=cnt+1;
                    cnt1=cnt1+1;
                    mask= original_image(i-fs:i+fs,j-fs:j+fs);
                    [data1] = feature_selector_method( mask,choice,cs,bs,ob );
                    data_matrix(cnt,:)=[data1,1];
                    class_matrix(cnt)='1';
                end
                testvar=testvar+1;
            else
                if(mod(tp,num_bgnd)==1)
                    cnt=cnt+1;
                    mask= original_image(i-fs:i+fs,j-fs:j+fs);
                    [data1] = feature_selector_method( mask,choice,cs,bs,ob );
                    data_matrix(cnt,:)=[data1,-1];
                    class_matrix(cnt)='0';
                end
                if((mincbx-i)>10)
                    i=i+round((mincbx-i)/2)+10;
                end
                if((i-maxcbx)>10)
                    i=i+ round((i-maxcbx)/2)+10;
                end
                if((mincby-j)>10)
                    j=j+round((mincby-j)/2)+10;
                end
                if((j-maxcby)>10)
                    j=j + round((j-maxcby)/2)+10 ;
                end
            end
        end
    end
else
    i=bound_box(1)+ms+1;
    while(i<bound_box(2))
        i=i+100;
        j=bound_box(3);
        while(j<bound_box(4))
            j=j+100;
            cnt=cnt+1;
            mask= original_image(i-fs:i+fs,j-fs:j+fs);
            [data1] = feature_selector_method( mask,choice,cs,bs,ob );
            data_matrix(cnt,:)=[data1,-1];
            class_matrix(cnt)='0';
        end
    end
end
end