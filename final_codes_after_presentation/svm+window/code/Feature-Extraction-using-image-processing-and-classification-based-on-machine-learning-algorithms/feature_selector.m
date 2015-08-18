function [data_matrix ] = feature_selector(selected_pixels,bound_box,original_image,ws,num_fgnd,num_bgnd )

%rax pixel data
testvar=0;
cnt=0;
tp=1;
cnt1=0;
ms=ws; %window size is (2*ms+1)*(2*ms+1)
if(numel(selected_pixels)~=0)
    mincbx= min(selected_pixels(1,:));
    maxcbx= max(selected_pixels(1,:));
    mincby= min(selected_pixels(2,:));
    maxcby= max(selected_pixels(2,:));
    i=bound_box(1);
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
                    maskc= original_image(i-ms:i+ms,j-ms:j+ms,:);
%                     imshow(original_image);
%                      rectangle('position',[i j 5 5], 'Edgecolor' , 'r');
                    mask = rgb2gray(maskc);
                    data_matrix(cnt,:)= [reshape(mask,[1,(2*ms+1)^2]),1];
                end
                testvar=testvar+1;
            else
                tp=tp+1;
                if(mod(tp,num_bgnd)==1)
                    cnt=cnt+1;
                    mask= original_image(i-ms:i+ms,j-ms:j+ms);
                    data_matrix(cnt,:)= [reshape(mask,[1,(2*ms+1)^2]),-1];
                    
                end
%                 if((mincbx-i)>10)
%                     i=i+round((mincbx-i)/2)+10;
%                 end
%                 if((i-maxcbx)>10)
%                     i=i+ round((i-maxcbx)/2)+10;
%                 end
%                 if((mincby-j)>10)
%                     j=j+round((mincby-j)/2)+10;
%                 end
%                 if((j-maxcby)>10)
%                     j=j + round((j-maxcby)/2)+10 ;
%                 end
                
                
            end
            
        end
    end
else
    i=bound_box(1);
    while(i<bound_box(2))
        i=i+100;
        j=bound_box(3);
        while(j<bound_box(4))
            j=j+100;
            cnt=cnt+1;
            mask= original_image(i-ms:i+ms,j-ms:j+ms);
            data_matrix(cnt,:)= [reshape(mask,[1,(2*ms+1)^2]),0];
        end
    end
end
end