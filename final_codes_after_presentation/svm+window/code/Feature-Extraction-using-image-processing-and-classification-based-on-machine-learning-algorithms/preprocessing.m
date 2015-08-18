function [ imb,m,n ] = preprocessing( i,varargin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if(numel(varargin)==0)
 [m,n , k]=size(i);   
i(700:m,:)=0;     %cancelling out whatever is written on the top left edge and also the border at the bottom
i(1:69,1:246,:)=0;
    im = rgb2gray(i);  %convert to gray
lev = graythresh(im);   
imb = im2bw(im, lev); %convert to binary to find the bounding box


else
[m,n,k]=size(i);
i(700:m,:)=0;     %cancelling out whatever is written on the top left edge and also the border at the bottom
i(1:69,1:246,:)=0;
imb=i;
end

