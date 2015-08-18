function [en, x ] = ICM_gmm_mrf_svm(c1,c2,c3,value,m,n,x,clm,mu,sigma)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
num_classes=numel(value);


[ E3 ] = new_energy_calculator_probability_gaussain(mu,sigma,value,m,n,x,c3);

[ E1 ] = new_energy_calculator_probability_mixed(clm,m,n,x,c1,value);

[ E2 ] = new_energy_calculator_mrf(value,m,n,x,c2);

Ef = E1+E2+E3;

[t1,t2]= min(Ef,[],2);  %calculate the minimum energy for each class
fv = value(t2);
en=sum(t1);
[s1 s2]=size(x(2:m-1,2:n-1));
x(2:m-1,2:n-1)=reshape(fv,[s1,s2]);   



end

