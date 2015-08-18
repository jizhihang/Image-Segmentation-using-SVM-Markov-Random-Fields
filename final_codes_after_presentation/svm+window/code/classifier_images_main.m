

load('C:\Users\ndy102\Desktop\thesis\documents-export-2015-07-25\data_param_10_0_9.mat'); %load other dataset for other svm
[ Iftpn,Ig,Ic,matf ] = classifier(svm{9,1},(svm{9,6}-1)/2,svm{9,4},svm{9,5}); %for this specific svm

% load('C:\Users\ndy102\Desktop\thesis\documents-export-2015-07-25\data_param_10_0_13.mat'); %load other dataset for other svm
% [ Iftpn,Ig,Ic,matf ] = classifier(svm{13,1},(svm{13,6}-1)/2,svm{13,4},svm{13,5}); %for this specific svm