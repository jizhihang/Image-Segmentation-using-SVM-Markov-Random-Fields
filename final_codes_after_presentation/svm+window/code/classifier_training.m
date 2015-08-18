function [ SVMStruct,kkt,rf ] = classifier_training(data_matrix,class_matrix,rbf,C)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
data_matrix = double(data_matrix);
dim=size(data_matrix,2)-1;
options.MaxIter = 100000;
% kkt=0.1;
% rf=10;
kkt = C;
rf = rbf;
SVMStruct = svmtrain(data_matrix(:,1:dim),class_matrix','Options', options, 'kernelcachelimit', 10000 , 'kernel_function', 'rbf','rbf_sigma',rf, 'kktviolationlevel',kkt );
% 'kktviolationlevel',0
end

