function [ Iftpn,Ig,Ic,matf ] = classifier(training_structure,ms,rbf1,C1)
% function [ matf ] = classifier(training_structure,ms)
%UNTITLED2 Summary of this function goes here

%1 - foreground %2- background
%'1' - foreground %'0'- background

%   Detailed explanation goes here
% load('data3.mat');
cnt=0;
% % % ms=35;
srcFiles1 = dir('C:\Users\ndy102\Desktop\thesis\notochord5dpf\*.jpg'); % the folder in which ur images exists
srcFiles2 = dir('C:\Users\ndy102\Desktop\thesis\notochord5dpfOriginal\*.jpg');
% z=55;
tp=0;
tn=0;
fp=0;
fn=0;
matf=[];
lf=1920; %last file
sf=993;
z=sf;
while(z< lf)
    cnt1=0;
    filename1 = strcat('C:\Users\ndy102\Desktop\thesis\notochord5dpf\',srcFiles1(z).name);
    filename2 = strcat('C:\Users\ndy102\Desktop\thesis\notochord5dpfOriginal\',srcFiles2(z).name);
    I = imread(filename1);
    I1 = imread(filename2);
    Ig = rgb2gray(I1);
    Ic =Ig;
    Iftpn = Ig;
    %     displayimages(I);
    %     displayimages(I1);
    idl=I;
    [ imb,m,n ] = preprocessing( idl );
    displayimages(imb);
    [ bbc ] = bbcalc(imb,m,n);
    displayimages(idl,bbc,m,n);
    [ idl,m,n ] = preprocessing( idl,'colour' );
    [ bbcol ] = bbcalc(idl,bbc);
    displayimages(idl,bbcol,m,n);
    [retimg ,selected_pixels ] = pixelselector( idl,bbcol );
    if(numel(selected_pixels)~=0)
        mincbx= min(selected_pixels(1,:));
        maxcbx= max(selected_pixels(1,:));
        mincby= min(selected_pixels(2,:));
        maxcby= max(selected_pixels(2,:));
        images_save{7}=bbcol;
    end
    i=bbc(1);
    if(bbc(1)< ms+2)
        i= ms+1;
    end
    j=bbc(3);
    while(i<bbc(2))
        j=bbc(3);
        i=i+1;
        
        while(j < bbc(4) && i<bbc(2))
            j=j+1;
            maskc= I1(i-ms:i+ms,j-ms:j+ms,:);
            mask = rgb2gray(maskc);
            data_point=double(reshape(mask,[1,(2*ms+1)^2]));
            p= svmclassify(training_structure,data_point);
            if(numel(selected_pixels)~=0)
                temp=((i-selected_pixels(1,:)).^2)+((j-selected_pixels(2,:)).^2);
            else
                temp= 50; %random number not equal to 0
            end
            if (numel(find(temp==0))~=0)
                %             if(p>0)
                if(str2num(p)==1)
                    tp=tp+1;
                    %                     I1c(i,j,3)=255;
                    %                     I1c(i,j,2)=0;
                    %                     I1c(i,j,1)=0;
                    %                         I1c(i,j)=1;
                    Ig(i,j)=1;
                    Ic(i,j)=1;
                    Iftpn(i,j)=1;
                    
                else
                    %                     I1c(i,j,3)=0;
                    %                     I1c(i,j,2)=0;
                    %                     I1c(i,j,1)=255;
                    fp=fp+1;
                    %                      I1c(i,j)=2;
                    Ig(i,j)=1;
                    Ic(i,j)=2;
                    Iftpn(i,j)=2;
                end
            else
                %             if(p<=0)
                if(str2num(p)==0)
                    tn=tn+1;
                    %                     I1c(i,j,3)=255;
                    %                     I1c(i,j,2)=0;
                    %                     I1c(i,j,1)=0;
                    %                      I1c(i,j)=2;
                    Ig(i,j)=2;
                    Ic(i,j)=2;
                    Iftpn(i,j)=3;
                else
                    fn=fn+1;
                    %                     I1c(i,j,3)=0;
                    %                     I1c(i,j,2)=255;
                    %                     I1c(i,j,1)=0;
                    %                          I1c(i,j)=1;
                    Ig(i,j)=2;
                    Ic(i,j)=1;
                    Iftpn(i,j)=4;
                end
            end
            %             if(numel(selected_pixels)~=0)
            %                 if((mincbx-i)>10)
            %                     i=i+round((mincbx-i)/2)+5;
            %                 end
            %                 if((i-maxcbx)>10)
            %                     i=i+ round((i-maxcbx)/2)+5;
            %                 end
            %                 if((mincby-j)>10)
            %                     j=j+round((mincby-j)/2)+5;
            %                 end
            %                 if((j-maxcby)>10)
            %                     j=j + round((j-maxcby)/2)+5 ;
            %                 end
            %             else
            %                 i=i+1;
            %                 j=j+1;
            %             end
            
        end
        
    end
    %
    %     z=z+5000;
    
    mat = [tp, tn, fp, fn, tp+tn+fp+fn ];
    
    matf=[mat;matf];
    
    z=z+6450;
end
filesavename= ['classifiedimage','_',num2str(rbf1),'_',num2str(C1),'_',num2str(ms),'_',num2str(z-6450)];
images_save{1}=Ig;
images_save{2}=Ic;
images_save{3}=Iftpn;
images_save{4}=Iftpn;
images_save{5}=bbc;
images_save{6}=matf;
save(filesavename,'images_save');
end

