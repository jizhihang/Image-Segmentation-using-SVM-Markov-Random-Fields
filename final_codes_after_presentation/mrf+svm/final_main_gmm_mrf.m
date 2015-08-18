clc;
clear all;
close all;
% warning('off','all');
%%{
% addpath('C:\Users\ndy102\Downloads\markov_random_fields_with_ICS-2015-05-19\');
% addpath('C:\Users\ndy102\Downloads\markov_random_fields_with_ICM_6_4_2015-2015-06-04\markov_random_fields_with_ICM_6_4_2015\');
% idl = imread('C:\Users\ndy102\Downloads\markov_random_fields_with_ICS-2015-05-19\test1.jpg');
% idl = imread('E:\thesis\thesis\noto_data\Box Sync\new_5df_original\coronal\5dpf-noto_coronal-img0278.jpg');
% idl = imread('N:\thesis\noto_data\Box Sync\new_5df_original\coronal\5dpf-noto_coronal-img0993.jpg');
imagenumber=12;
imno=1; %1-12 2-992 3-1835
filename = ['C:\Users\ndy102\Desktop\thesis\notochord5dpfOriginal\5dpf-noto-original00',num2str(imagenumber),'.jpg'];
idl = imread(filename);

[ data_gmm_mrf_ver ] = verify_gmm_markov(  );
border=data_gmm_mrf_ver{imno,1} ;
bbox=data_gmm_mrf_ver{imno,2} ;
Ig=data_gmm_mrf_ver{imno,3};
final= idl(bbox(1)+border:bbox(2)-border,bbox(3)+border:bbox(4)-border,:);

x=final;
num_classes = 2;
value=[1:num_classes];

[m n k] = size(x);
y= zeros(m,n);
x=rgb2gray(x);
x= double(x);
%  [mu, sigma] = new_gaussian_densities_calculator_supervised()
load('C:\Users\ndy102\Desktop\thesis\mrf+gmm\gaussian_training_data_3images_training.mat');

for q=-5:1:5
    % c2=1/8;
    c2=q;
    c1= 1;
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
    
    termss=[];
    %}
    max_num_iterations=30;
    x1= reshape(x,[m*n,1]);
    y1= reshape(y,[m*n,1]); %for semisupervised image segmentation
    % data = [x1,y1];
    
    te=y1;
    y= reshape(te,[m,n]);
    for i=1:max_num_iterations
        y=ICM(c1,c2,value,m,n,y,x,mu, sigma);
    end
    
    %analysis
    y1=double(y);
    [r11,c11] = find(y==1);
    indices1 = sub2ind(size(y), r11, c11);
    y1(indices1)=10;
    [r12,c13] = find(y==2);
    indices2 = sub2ind(size(y), r12, c13);
    y1(indices2)=20;
    Ig11=double(Ig);
    diff=Ig11-y1;
    tp = numel(find(diff==-9));
    tn = numel(find(diff==-18));
    fp = numel(find(diff==-19));
    fn = numel(find(diff==-8));
    clf =[ tp ,tn, fp,fn, tp+tn+fp+fn ];
    
    
    
    %printing
    
    TP =100* tp/(tp+fp);
    TN = 100*tn/(tn+fn);
    FP = 100*fp/(tp+fp);
    FN = 100*fn/(tn+fn);
    Accuracy =100* (tp+tn)/(tp+tn+fp+fn);
    formatSpec = '%2.3f &%2.1f &%2.1f &%2.1f &%2.1f &%2.2f &%d ';
    
    fprintf(formatSpec, c2 ,TP ,TN,FP,FN,Accuracy,imagenumber)
    % sprintf('%2.1f & %2.2f &%2.2f &%2.2f &%2.1f &%2.1f &%2.1f &%2.1f &%2.1f &%2.1f', i,N, C, rbf , c2 ,TP ,TN,FP,FN,Accuracy);
    disp('\\ \hline');
    sprintf('\n');
    filesave=['data_param_mrf_gmm_',num2str(c2),'_',num2str(imagenumber)];
    data_save{1} =clf;
    data_save{2} = Ig;
    data_save{3} = y;
    data_save{4} = imagenumber;
    save(filesave,'data_save');
    
end

