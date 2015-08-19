function [data ] = feature_selector_method( mask,choice,cs,bs,ob )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

if (choice==1)
    [Gmag,Gdir] = imgradient(mask);
    data= [reshape(Gmag,[1,numel(mask)])];
end
if(choice==2)
    [Gmag,Gdir] = imgradient(mask);
    edgesmag = (1:255);
    Nmag = histc(mask(:),edgesmag);
    data= [Nmag'];
end
if(choice==3)
    [Gmag,Gdir] = imgradient(mask);
    data= [reshape(Gdir,[1,numel(mask)])];
end
if(choice==4 )
    [Gmag,Gdir] = imgradient(mask);
    edgesdir=(-180:180);
    Ndir = histc(mask(:),edgesdir);
    data= [Ndir'];
end
if(choice==5)
    [Gmag,Gdir] = imgradient(mask);
    edgesdir=(-180:180);
    Ndir = histc(mask(:),edgesdir);
    edgesmag = (1:255);
    Nmag = histc(mask(:),edgesmag);
    data= [Nmag',Ndir'];
end
if(choice==6)
    data= [extractHOGFeatures(mask,'Cellsize',[cs cs],'Blocksize', [bs bs],'NumBins',ob)];
end
if(choice==7)
    [f,d] = vl_dsift(single(mask));
    data= d;
end
end

