function [ SVMStruct ] = classifier_training(data_matrix)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
data_matrix = double(data_matrix);
dim=size(data_matrix,2)-1;
options.MaxIter = 100000;
SVMStruct = svmtrain(data_matrix(:,1:dim),data_matrix(:,dim+1),'Options', options, 'kernelcachelimit', 10000 , 'kernel_function', 'rbf' );


end

