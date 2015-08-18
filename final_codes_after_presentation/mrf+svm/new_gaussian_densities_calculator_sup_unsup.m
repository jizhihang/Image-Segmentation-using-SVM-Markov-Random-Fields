function [ mu, sigma ] =new_gaussian_densities_calculator_sup_unsup(x,y,m,n,value )
%UNTITLED Summary of this function goes here
%{{
%supervised gaussian density assignment
coordinates_of_roi(1,:) = [258,276,234,246];
coordinates_of_roi(2,:) = [118,216,1404,1550];
coordinates_of_roi(3,:) = [196,243,1080,1134];
% coordinates_of_roi = [436,474,68,110];

% for i=1:num_classes
%     coordinates_of_roi(i,:) = input('enter roi');
% end
num_classes=numel(value);
mu= zeros(1,num_classes); %for grayscale image
count=zeros(1,num_classes);
[m n ] = size(image);

for i=1:m
    for j=1:n
        for temp=1:num_classes
            if( i>=coordinates_of_roi(temp,1) && i<=coordinates_of_roi(temp,2) && j>=coordinates_of_roi(temp,3) && j<=coordinates_of_roi(temp,4))
                mu(temp)= image(i,j)+mu(temp);
                count(temp)=count(temp)+1;
                X{temp,count(temp)}= image(i,j);
                break;
            end
        end
    end
end

for temp=1:num_classes
    mu(temp) = mu(temp)/count(temp);
    Xt=cell2mat(X(temp,:));
    Xtm = (Xt - repmat(mu(temp),[size(Xt,1),1]));
    sigma(temp) =sum(Xtm.*Xtm)/(count(temp)-1);
end
%}   
% 
% %unsupervised gaussian density assignment
% x1=x(2:m-1,2:n-1);          %i,j
% num=numel(x1);
% x1d= reshape(x1,[num,1]);
% y1=y(2:m-1,2:n-1);          %i,j
% num=numel(y1);
% y1d= reshape(y1,[num,1]);
% data=[x1d,y1d];
% for i=1:num_classes
%     ind=find(data(:,2)==value(i));
%     mu(i)= sum(data(ind,1))/numel(ind);
%     X1 = data(ind,1);
%     X2 = X1- repmat(mu(i),[size(X1,1),1]);
%     sigma(:,:,i) =sum(X2.*X2)/(numel(ind)-1);
% end
    
end