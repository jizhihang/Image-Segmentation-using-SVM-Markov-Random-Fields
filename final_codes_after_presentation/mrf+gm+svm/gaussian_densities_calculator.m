function [ mu, sigma ] =gaussian_densities_calculator( image )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
coordinates_of_roi = [258,276,234,246];
coordinates_of_roi1 = [118,216,1404,1550];
coordinates_of_roi2 = [196,243,1080,1134];
% coordinates_of_roi = [436,474,68,110];
% mu1= zeros(1,3); %for rgb image
% mu2 = zeros(1,3);
mu1= zeros(1,1); %for grayscale image
mu2 = zeros(1,1);
mu3 = zeros(1,1);
count=zeros(3);
[m n z] = size(image);
X1=[];
X2=[];
X3=[];
for i=1:m
    for j=1:n
        if( i>=coordinates_of_roi(1) && i<=coordinates_of_roi(2) && j>=coordinates_of_roi(3) && j<=coordinates_of_roi(4))
            %             mu1(1,1)= image(i,j,1)+mu1(1,1);
            % % %             mu1(1,2)= image(i,j,2)+mu1(1,2);
            % % %             mu1(1,3)= image(i,j,3)+mu1(1,3);
            
            %             X1= [X1;image(i,j,1), image(i,j,2), image(i,j,3)];
            count(1)=count(1)+1;
            mu1(1,1)= image(i,j)+mu1(1,1);
            X1= [X1;image(i,j)];
        elseif( i>=coordinates_of_roi1(1) && i<=coordinates_of_roi1(2) && j>=coordinates_of_roi1(3) && j<=coordinates_of_roi1(4))
            
            %             X1= [X1;image(i,j,1), image(i,j,2), image(i,j,3)];
            count(2)=count(2)+1;
            mu2(1,1)= image(i,j)+mu2(1,1);
            X2= [X2;image(i,j)];
        elseif( i>=coordinates_of_roi2(1) && i<=coordinates_of_roi2(2) && j>=coordinates_of_roi2(3) && j<=coordinates_of_roi2(4))
            %             X2= [X2;image(i,j,1), image(i,j,2), image(i,j,3)];
            %             mu2(1,1)= image(i,j,1)+mu2(1,1);
            %             mu2(1,2)= image(i,j,2)+mu2(1,2);
            %             mu2(1,3)= image(i,j,3)+mu2(1,3);
            count(3)=count(3)+1;
            mu3(1,1)= image(i,j)+mu3(1,1);
            X3= [X3;image(i,j)];
        else
            continue;
        end
        
    end
end
mu1 = mu1(1,:)/count(1);
X1m = (X1 - repmat(mu1,[size(X1,1),1]));
cov1 =X1m'*X1m./(count(1)-1);
mu2 = mu2(1,:)./(count(2));
X2m = (X2 - repmat(mu2,[size(X2,1),1]));
cov2 =X2m'*X2m./(count(2)-1);
mu3 = mu3(1,:)/count(3);
X3m = (X3 - repmat(mu3,[size(X3,1),1]));
cov3 =X3m'*X3m./(count(3)-1);
mu(1,:) = mu1;
mu(2,:) = mu2;
mu(3,:) = mu3;
sigma(:,:,1) = cov1;
sigma(:,:,2) = cov2;
sigma(:,:,3) = cov3;
end