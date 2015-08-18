function [ E1 ] = new_energy_calculator_probability_mixed(clm,m,n,x,c1,value)
%NEW_EN Summary of this function goes here
%   Detailed explanation goes here

x1=x(2:m-1,2:n-1);          %i,j
num=numel(x1);
x1d= reshape(x1,[num,1]);

%calculate for class 1
for classnum=1:numel(value)
% ind1= find(data(:,2)==value(classnum));
ip= x1d;
[r]=find(ip==value(classnum));
[c]=find(ip~=value(classnum));
E1(r,classnum) = -c1*log(clm(classnum,1));
E1(c,classnum) = -c1*log(clm(classnum,2));
end

end



