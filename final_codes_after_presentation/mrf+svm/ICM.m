function [ y ] = ICM(c1,c2,value,m,n,y,x,mu,sigma)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
num_classes=numel(value);


[ E1 ] = new_energy_calculator_probability_gaussain(mu,sigma,value,m,n,y,x,c1,c2);

[ E2 ] = new_energy_calculator_mrf(value,m,n,y,c2);

Ef = E1+E2;

[t1,t2]= min(Ef,[],2);
fv = value(t2);
[s1 s2]=size(y(2:m-1,2:n-1));
y(2:m-1,2:n-1)=reshape(fv,[s1,s2]);   

end

