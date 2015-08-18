% function [mu, sigma] = new_gaussian_densities_calculator_supervised()
clc;
clear all;
close all;
%UNTITLED Summary of this function goes here
%{{
%supervised gaussian density assignment
num_images=3;
num_classes=2;
value=[1:num_classes];
coordinates_of_roi(1,:,:) = [1,1,1,1;1,77,1,250]; %13 image
coordinates_of_roi(2,:,:) = [160,200,250,266 ;300,650,1,520]; %993 image
coordinates_of_roi(3,:,:) = [188,252,92,99 ;264,577,1,210]; %1863 image
%  coordinates_of_roi(4,:,:) = [1,1,1,1;10,77,10,240]; %780 image


filename{1} = ['C:\Users\ndy102\Desktop\thesis\notochord5dpfOriginal\5dpf-noto-original00',num2str(13),'.jpg'];
filename{2} = ['C:\Users\ndy102\Desktop\thesis\notochord5dpfOriginal\5dpf-noto-original0',num2str(993),'.jpg'];
filename{3} = ['C:\Users\ndy102\Desktop\thesis\notochord5dpfOriginal\5dpf-noto-original',num2str(1863),'.jpg'];
% filename4 = ['C:\Users\ndy102\Desktop\thesis\notochord5dpfOriginal\5dpf-noto-original0',num2str(780),'.jpg'];

mu= zeros(1,num_classes);
mu = double(mu);
mu=mu';
count=zeros(1,num_classes);
for it=1:num_images
  f= filename{it}
idl = imread(f);
[ imb,m,n ] = preprocessing( idl,'color'  ); 
[ bbc ] = bbcalc(imb,m,n);
final=idl(bbc(1):bbc(2),bbc(3):bbc(4),:);
x=final;
% figure,imshow(x);
x=rgb2gray(x);
x=double(x);
% figure,imshow(x);
num_classes=numel(value);
[m n]= size(x);
 %for grayscale image
for i=1:m
    for j=1:n
%         for temp=1:num_classes
            temp=1;
            if( i>=coordinates_of_roi(it,temp,1) && i<=coordinates_of_roi(it,temp,2) && j>=coordinates_of_roi(it,temp,3) && j<=coordinates_of_roi(it,temp,4))
                mu(temp)= x(i,j)+mu(temp);
                count(temp)=count(temp)+1;
                X{temp,count(temp)}= x(i,j);
             else
                 count(2)=count(2)+1;
                 mu(2)= x(i,j)+mu(2);
%                 if(mod(count(2),60)==0)
%                    X{2,count(2)}= 0;
%                    count(2)=count(2)+1;
%                 end
                X{2,count(2)}= x(i,j);
            end
%         end
    end
end
end
for temp=1:num_classes
    mu(temp) = mu(temp)/count(temp);
    Xt=cell2mat(X(temp,1:count(temp)));    
    Xtm = (Xt - repmat(mu(temp),[size(Xt,1),1]));
    sigma(temp) =sum(Xtm.*Xtm)/(count(temp)-1);
end
   filen=['gaussian_training_data_',num2str(num_images),'images_training'];
save(filen,'mu','sigma')
