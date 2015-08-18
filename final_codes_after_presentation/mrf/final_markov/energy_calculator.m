function  [class,terms] =  energy_calculator(i,j,y,x,value,mu,sigma,image)
%ENERGY_CALCULATOR Summary of this function goes here
%   Detailed explanation goes here
%energy function defn;
c1= 1;
c2=550*1/16;
% [ m n k]= size(x);
[m n]=size(x);
E=0;
% for i1=1:m
%     for j1=1:n
%         %term1 calculations
%         %term1 = c1* (x(i,j,1)+x(i,j,2)+x(i,j,3))/3 ;  %multiply c1 by intensity of observed pixels
%         % term1= c1* ( abs(x(i,j)-x(i+1,j)) + abs(x(i,j)-x(i-1,j)) + abs(x(i,j)-x(i,j+1))+ abs(x(i,j)-x(i,j-1)) );
%        
%         if(y(i1,j1)==value(1))
%             mu_i=mu(1,:);
%             sigma_i=sigma(:,:,1);
%         else
%             mu_i=mu(2,:);
%             sigma_i=sigma(:,:,2);
%         end
%         ip=reshape(x(i1,j1,:),[1,3]);
%         diff_i=ip-mu_i;
%         term1 = c1*((diff_i*(inv(sigma_i)*diff_i'))+log(det(sigma_i)));
%         %term 2 calculations
%         %term2= c2 * ( abs(y(i,j)-y(i+1,j)) + abs(y(i,j)-y(i-1,j)) + abs(y(i,j)-y(i,j+1))+ abs(y(i,j)-y(i,j-1)) );
%         % term2= c2 * ( y(i,j)*y(i,j+1) + y(i,j)*y(i,j-1) + y(i,j)*y(i+1,j) +y(i,j)*y(i-1,j));
%         term2 = c2 * ( abs(y(i,j)-y(i+1,j)) + abs(y(i,j)-y(i-1,j)) + abs(y(i,j)-y(i,j+1))+ abs(y(i,j)-y(i,j-1)) + abs(y(i,j)-y(i-1,j-1)) + abs(y(i,j)-y(i+1,j-1)) + abs(y(i,j)-y(i-1,j+1))+ abs(y(i,j)-y(i+1,j+1)) );
%         
%         
%         E = term1 + term2+E;
%     end
% end
% ip=reshape(x(i,j,:),[1,3]);
ip =x(i,j);
diff_i=ip-mu(1,:);
sigma_i=sigma(:,:,1);
term1 = c1*((-0.5*(diff_i*(inv(sigma_i))*diff_i'))+(-0.5*log(det(sigma_i)))+(-0.5*log(2*pi)));
term2 = c2 * ( abs(y(i,j)-y(i+1,j)) + abs(y(i,j)-y(i-1,j)) + abs(y(i,j)-y(i,j+1))+ abs(y(i,j)-y(i,j-1)) + abs(y(i,j)-y(i-1,j-1)) + abs(y(i,j)-y(i+1,j-1)) + abs(y(i,j)-y(i-1,j+1))+ abs(y(i,j)-y(i+1,j+1)) );
E1 = E + term1 + term2;
term1_class1=term1;
term2_class1=term2;

diff_i=ip-mu(2,:);
sigma_i=sigma(:,:,2);
term1 = c1*((-0.5*(diff_i*(inv(sigma_i))*diff_i'))+(-0.5*log(det(sigma_i)))+(-0.5*log(2*pi)));
term2 = c2 * ( abs(y(i,j)-y(i+1,j)) + abs(y(i,j)-y(i-1,j)) + abs(y(i,j)-y(i,j+1))+ abs(y(i,j)-y(i,j-1)) + abs(y(i,j)-y(i-1,j-1)) + abs(y(i,j)-y(i+1,j-1)) + abs(y(i,j)-y(i-1,j+1))+ abs(y(i,j)-y(i+1,j+1)) );
E2 = E + term1 + term2;
term1_class2=term1;
term2_class2=term2;

if(E1>E2)
    class= value(2);
else
    class = value(1);
end
terms=[term1_class1, term2_class1, term1_class2, term2_class2];
end

