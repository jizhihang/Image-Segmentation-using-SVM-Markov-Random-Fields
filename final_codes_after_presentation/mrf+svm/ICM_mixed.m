function [en, x ] = ICM_mixed(c1,c2,value,m,n,x,clm)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
num_classes=numel(value);
% [ mu, sigma ] =new_gaussian_densities_calculator( num_classes,x,y,m,n,value );

[ E1 ] = new_energy_calculator_probability_mixed(clm,m,n,x,c1,value);

[ E2 ] = new_energy_calculator_mrf(value,m,n,x,c2);

Ef = E1+E2;

[t1,t2]= min(Ef,[],2);  %calculate the minimum energy for each class
fv = value(t2);
en=sum(t1);
[s1 s2]=size(x(2:m-1,2:n-1));
x(2:m-1,2:n-1)=reshape(fv,[s1,s2]);   

end

