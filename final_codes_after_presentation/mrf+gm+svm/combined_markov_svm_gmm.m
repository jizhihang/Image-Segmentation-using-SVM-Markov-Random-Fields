% function [ RGB,x,en ] = combined_markov_svm(  img_save )
%1 is foreground , 2 is background
%  addpath('N:\thesis\new_code\final_markov-2015-07-08\final_markov');
clear all;
clc;
close all;
load('C:\Users\ndy102\Desktop\thesis\final_markov-2015-07-26\final_markov\classifiedimage_10_0_9_993.mat');%it's actually images 12992,1835
N=19 ; C=0 ; rbf = 10; imagenum=992;% [ RGB,x,en ] = combined_markov_svm(images_save );
addpath('C:\Users\ndy102\Desktop\thesis');
% addpath('C:\Users\ndy102\Downloads\markov_random_fields_with_ICS-2015-05-19\');
% addpath('C:\Users\ndy102\Downloads\markov_random_fields_with_ICM_6_4_2015-2015-06-04\markov_random_fields_with_ICM_6_4_2015\');
% idl = imread('C:\Users\ndy102\Downloads\markov_random_fields_with_ICS-2015-05-19\test1.jpg');
% idl = imread('E:\thesis\thesis\noto_data\Box Sync\new_5df_original\coronal\5dpf-noto_coronal-img0278.jpg');
% idl = imread('N:\thesis\noto_data\Box Sync\new_5df_original\coronal\5dpf-noto_coronal-img0278.jpg');
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
if(imagenum==1836)
    border=20;
end

ifptn1= ifptn(bbox(1)+border:bbox(2)-border,bbox(3)+border:bbox(4)-border);
Ig1= Ig(bbox(1)+border:bbox(2)-border,bbox(3)+border:bbox(4)-border);
Ic1= Ic(bbox(1)+border:bbox(2)-border,bbox(3)+border:bbox(4)-border);
[r4,c4]=find(ifptn1==4);
indices = sub2ind(size(Ig1), r4, c4);
Ig1(indices)=2;
Ic1(indices)=1;
figure,imshow(Ig1,[]);
figure,imshow(Ic1,[]);
load('C:\Users\ndy102\Desktop\thesis\mrf+gmm\gaussian_training_data_3images_training.mat')
for q1=-10:2:10
for q=-10:2:10
c2=q;
c1= 1;
c3=q1; %keep this as 1 %not compulsary , just because this term has a big range(max,min)
% c2=0.5
img_data=Ic1;
% x=im2double(img_data);
x=double(img_data);
num_classes = 2;
value=[1:num_classes];  %1- foreground 2- background
[m n k] = size(x);
termss=[];
%}
max_num_iterations=40;
x1= reshape(x,[m*n,1]);
count1=0;
for i=1:max_num_iterations
    
    [en1,x]=ICM_gmm_mrf_svm(c1,c2,c3,value,m,n,x,clm,mu,sigma);
    en(i)=en1;
    if(i>max_num_iterations-10)
        count1=count1+1;
        data{count1}=x ;
        endecis(count1)=en1;
        
    end
    
end
[M,I] = min(endecis);
x =  data{I(1)};


% analysis
x1=double(x);
[r11,c11] = find(x==1);
indices1 = sub2ind(size(x), r11, c11);
x1(indices1)=10;
[r12,c13] = find(x==2);
indices2 = sub2ind(size(x), r12, c13);
x1(indices2)=20;
Ig11=double(Ig1);
diff=Ig11-x1;
tp = numel(find(diff==-9));
tn = numel(find(diff==-18));
fp = numel(find(diff==-19));
fn = numel(find(diff==-8));
clf =[ tp ,tn, fp,fn, tp+tn+fp+fn ];



%printing
img_save{7}=x;
img_save{8}=clf;
TP =100* tp/(tp+fp);
TN = 100*tn/(tn+fn);
FP = 100*fp/(tp+fp);
FN = 100*fn/(tn+fn);
Accuracy =100* (tp+tn)/(tp+tn+fp+fn);
formatSpec = ' %d & %d &%2.2f &%2.2f &%2.4f &%2.4f &%2.1f &%2.1f &%2.1f &%2.1f &%2.2f &%d ';

fprintf(formatSpec, i,N, C, rbf , c2,c3,TP ,TN,FP,FN,Accuracy,imagenum)
% sprintf('%2.1f & %2.2f &%2.2f &%2.2f &%2.1f &%2.1f &%2.1f &%2.1f &%2.1f &%2.1f', i,N, C, rbf , c2 ,TP ,TN,FP,FN,Accuracy);
disp('\\ \hline');
sprintf('\n');
filesave=['data_param_',num2str(rbf),'_',num2str(C),'_',num2str(c2*10),'_',num2str(c3*10),'_',num2str(imagenum)];
 save(filesave,'img_save');
%   RGB= label2rgb(x1);
% figure,imshow(RGB);

% stem(en);

% end

end
end