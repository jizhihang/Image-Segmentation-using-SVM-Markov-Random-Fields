function [ E1 ] =new_energy_calculator_probability_gaussain(mu,sigma,value,m,n,x,c3)

%NEW_EN Summary of this function goes here
%   Detailed explanation goes here

x1=x(2:m-1,2:n-1);          %i,j
num=numel(x1);
x1d= reshape(x1,[num,1]);

%calculate for class 1
for classnum=1:numel(value)
% ind1= find(data(:,2)==value(classnum));
ip= x1d;
diff_i=ip-mu(classnum);
sigma_i=sigma(classnum);
E1(:,classnum) = -c3*((-0.5*(diff_i*(inv(sigma_i+10^-5)).*diff_i))+(-0.5*log(det(sigma_i)))+(-0.5*log(2*pi)));

end

end



