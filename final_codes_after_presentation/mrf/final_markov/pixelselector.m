function [retimg,selected_pixels] = pixelselector( image,bbcol )
%UNTITLED5 Summary of this function goes here
%   the only problem with this code is that it wont extract pixels if there
%   were 3 blue boundary points in a row
if(numel(bbcol)~=0)
    img=image(bbcol(1):bbcol(2),bbcol(3):bbcol(4),:);
    [m1 n1 k1]= size(img);
    pc=[];
    retimg=img;
    initi = 5;  %this is because there are some boundary errors, pixels in the top and bottom rows are somehow included n the analysis. Right now, we are excluding those pixels,we will see about that later. The problem is maybe with the pixel values...the condition in the loop is getting interpreted wrongly
    for i=initi:m1-initi
        cnt=0;
        j=0;
        while(j<n1-1)
            j=j+1;
            if( (img(i,j,3)>200) && (img(i,j,2)>200) && (img(i,j,1)<100) )
                cnt=cnt+1;
                while( ((img(i,j,3)>200) && (img(i,j,2)>200) && (img(i,j,1)<100)) && (j<n1-1))
                    j=j+1;
                end
            end
            if(mod(cnt,2))
                pc = [pc,[i;j]];
                retimg(i,j,3)=255;
                retimg(i,j,1)=255;
            end
        end
    end
    selected_pixels = [bbcol(1)+pc(1,:);bbcol(3)+pc(2,:)];
    
else
    retimg=image;
    selected_pixels=[];
end
end