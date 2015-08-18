function [ E2 ] = new_energy_calculator_mrf( value,m,n,y,c2 )
%NEW_ENERGY_CALCULATOR_MRF Summary of this function goes here
%   Detailed explanation goes here
y=double(y);

y1=y(2:m-1,2:n-1);          %i,j
num=numel(y1);
N= reshape(y1,[num,1]);
% Nc1 = value(1)*ones(size(N));
% Nc2 = value(2)*ones(size(N));

y1n=y(2:m-1,3:n);
N1= reshape(y1n,[num,1]);  %i,j+1

y2n=y(2:m-1,1:n-2);
N2= reshape(y2n,[num,1]);  %i,j-1

y3n=y(3:m,2:n-1);
N3= reshape(y3n,[num,1]);  %i+1,j

y4n=y(1:m-2,2:n-1);
N4= reshape(y4n,[num,1]);  %i-1,j

y5n=y(3:m,1:n-2);
N5= reshape(y5n,[num,1]);  %i+1,j-1

y6n=y(3:m,3:n);
N6= reshape(y3n,[num,1]);  %i+1,j+1

y7n=y(1:m-2,3:n);
N7= reshape(y7n,[num,1]);  %i-1,j+1

y8n=y(1:m-2,1:n-2);
N8= reshape(y8n,[num,1]);  %i-1,j-1

for classnum=1: numel(value)
Nc1 = value(classnum)*ones(size(N));
E2(:,classnum) = c2 * ( abs(Nc1-N1) + abs(Nc1-N2) + abs(Nc1-N3)+ abs(Nc1-N4) + abs(Nc1-N5) + abs(Nc1-N6) + abs(Nc1-N7)+ abs(Nc1-N8));

end

