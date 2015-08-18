clc;
clear all;
close all;
% warning('off','all');
%%{
 addpath('N:\thesis\new_code\final_markov-2015-07-08\final_markov');

% addpath('C:\Users\ndy102\Downloads\markov_random_fields_with_ICS-2015-05-19\');
% addpath('C:\Users\ndy102\Downloads\markov_random_fields_with_ICM_6_4_2015-2015-06-04\markov_random_fields_with_ICM_6_4_2015\');
% idl = imread('C:\Users\ndy102\Downloads\markov_random_fields_with_ICS-2015-05-19\test1.jpg');
% idl = imread('E:\thesis\thesis\noto_data\Box Sync\new_5df_original\coronal\5dpf-noto_coronal-img0278.jpg');
idl = imread('N:\thesis\noto_data\Box Sync\new_5df_original\coronal\5dpf-noto_coronal-img0278.jpg');

[ imb,m,n ] = preprocessing( idl );
% displayimages(imb);
[ bbc ] = bbcalc(imb,m,n);
%  displayimages(idl,bbc,m,n);
final=idl(bbc(1):bbc(2),bbc(3):bbc(4),:);
x=final;
num_classes = 2;
value=[1:num_classes];

[m n k] = size(x);
y= zeros(m,n);
% initial random assignment
for i=1:m
    for j=1:n
        r= rand(1);
        for temp=1:num_classes
            if(r<temp*1/num_classes)
                y(i,j)=value(temp);
                break;
            end
        end
        
    end
end
% x=rgb2gray(x); 
x= im2double(x);
[ mu, sigma ] =new_gaussian_densities_calculator( num_classes,x,y,m,n,value );
termss=[];
%}
max_num_iterations=10;
x1= reshape(x,[m*n,1]);
y1= reshape(y,[m*n,1]); %for semisupervised image segmentation
% data = [x1,y1];
c1= -1;
c2=(10^-1)*1/16;

% class= kmeans(x1,num_classes);
% te= value(class);
te=y1;
y= reshape(te,[m,n]);
for i=1:max_num_iterations
    
    y=ICM(c1,c2,value,m,n,y,x);
    
end


% t(:,:,1)=y;t(:,:,2)=y;t(:,:,3)=y;
% for i=1:num_classes
%     [r(i,:),c(i,:)]= find(y==value(i));
%     t(r(i,:),c(i,:),1)=i*255/num_classes;
%     t(r(i,:),c(i,:),2)=i*20;
%     t(r(i,:),c(i,:),3)=i*40;
% end
         
  RGB= label2rgb(y);
figure,imshow(RGB);   
% z = (y+1 )/2;
% figure,imshow(z,[]);