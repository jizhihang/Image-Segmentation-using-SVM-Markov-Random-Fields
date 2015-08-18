 function [ data_gmm_mrf_ver ] = verify_gmm_markov(  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
num_images=3;
filename{1}='C:\Users\ndy102\Desktop\thesis\final_markov-2015-07-26\final_markov\classifiedimage_10_0_9_13.mat'; %it's actually the 12'th image
filename{2}='C:\Users\ndy102\Desktop\thesis\final_markov-2015-07-26\final_markov\classifiedimage_10_0_9_993.mat';%it's actually the 992'th image
filename{3}='C:\Users\ndy102\Desktop\thesis\final_markov-2015-07-26\final_markov\classifiedimage_10_0_9_1836.mat';%it's actually the 1835'th image

for it=1:num_images
f=filename{it};
load(f);
img_save=images_save;
matc=img_save{6};
clm(1,1)=matc(1)/(matc(1)+matc(3)); %tp
clm(1,2)=matc(3)/(matc(1)+matc(3)); %fp
clm(2,1)=matc(2)/(matc(2)+matc(4)); %tn
clm(2,2)=matc(4)/(matc(2)+matc(4)); %fn

ifptn=img_save{3};
Ig= img_save{1};
Ic= img_save{2};
bbox= img_save{5};
border=5;
if(it==3) %for %image 1836
    border=20;
end

ifptn1= ifptn(bbox(1)+border:bbox(2)-border,bbox(3)+border:bbox(4)-border);
Ig1= Ig(bbox(1)+border:bbox(2)-border,bbox(3)+border:bbox(4)-border);
[r4,c4]=find(ifptn1==4);
indices = sub2ind(size(Ig1), r4, c4);
Ig1(indices)=2;
% figure,imshow(Ig1,[]);
data_gmm_mrf_ver{it,1} = border;
data_gmm_mrf_ver{it,2} = bbox;
data_gmm_mrf_ver{it,3} = Ig1;
end
fs=['data_gmm_mrf_verifcation',num2str(num_images)];
save(fs,'data_gmm_mrf_ver');
