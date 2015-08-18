clc;
close all;
img_save=images_save;
ifptn=img_save{3};
Ig= img_save{1};
Ic= img_save{2};
bbox= img_save{5};
border=5;
ifptn1= ifptn(bbox(1)+border:bbox(2)-border,bbox(3)+border:bbox(4)-border);
Ig1= Ig(bbox(1)+border:bbox(2)-border,bbox(3)+border:bbox(4)-border);
Ic1= Ic(bbox(1)+border:bbox(2)-border,bbox(3)+border:bbox(4)-border);
[r4,c4]=find(ifptn1==4);
indices = sub2ind(size(Ig1), r4, c4);
Ig1(indices)=2;
Ic1(indices)=1;

figure,imshow(Ig1,[]);
figure,imshow(Ic1,[]);