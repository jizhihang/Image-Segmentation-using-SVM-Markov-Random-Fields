srcFiles1 = dir('C:\Users\ndy102\Desktop\thesis\notochord5dpf\*.jpg'); % the folder in which ur images exists
srcFiles2 = dir('C:\Users\ndy102\Desktop\thesis\notochord5dpfOriginal\*.jpg');
% z=55;
tp=0;
tn=0;
fp=0;
fn=0;
matf=[];
lf=1920; %last file
sf=993;
z=sf;
while(z< lf)
    cnt1=0;
    filename1 = strcat('C:\Users\ndy102\Desktop\thesis\notochord5dpf\',srcFiles1(z).name);
    filename2 = strcat('C:\Users\ndy102\Desktop\thesis\notochord5dpfOriginal\',srcFiles2(z).name);
end