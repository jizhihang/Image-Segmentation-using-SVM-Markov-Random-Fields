p1=(find(data_matrix(:,10)==0));
plot3(data_matrix(p1,5),data_matrix(p1,1),data_matrix(p1,9),'b*');
hold on
p1=(find(data_matrix(:,10)==1));
plot3(data_matrix(p1,5),data_matrix(p1,1),data_matrix(p1,9),'r*');
