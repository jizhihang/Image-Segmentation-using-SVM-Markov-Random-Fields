%thesis
close all;
clc;
clear all;
warning('off','all');
tic
cnt=0;
data_matrix=[];
srcFiles = dir('C:\Users\ndy102\Desktop\thesis\notochord5dpf\*.jpg');  % the folder in which ur images exists
srcFiles2 = dir('C:\Users\ndy102\Desktop\thesis\notochord5dpfOriginal\*.jpg');
i=680;
tic
% ws=20;
nf=2;
nb=250;
Srno=0;
for rb = -2:-2
    rbf=10^rb;
    for C=0:0.3:1
        for tp1=1:4:20
            data_matrix=[];
            class_matrix_data=[];
            ws= tp1;
            nf=tp1;
            if(tp1==1)
               nf = 2; 
            end
            nb=30*tp1+1;
            c_i_t=0;
            cnt=0;
            while(i< length(srcFiles))
                i=i+1;
                cnt1=0;
                filename = strcat('C:\Users\ndy102\Desktop\thesis\notochord5dpf\',srcFiles(i).name);
                filename2 = strcat('C:\Users\ndy102\Desktop\thesis\notochord5dpfOriginal\',srcFiles2(i).name);
                I1 = imread(filename2);
                I = imread(filename);
                displayimages(I);
                idl=I;
                % id = imread('N:\\thesis\\test1.jpg');
                % idl = imread('N:\\thesis\\test1_label.jpg');
                [ imb,m,n ] = preprocessing( idl );
                displayimages(imb);
                [ bbc ] = bbcalc(imb,m,n);
                displayimages(idl,bbc,m,n);
                [ idl,m,n ] = preprocessing( idl,'colour' );
                [ bbcol ] = bbcalc(idl,bbc);
                displayimages(idl,bbcol,m,n);
                [retimg ,selected_pixels ] = pixelselector( idl,bbcol );
                displayimages(idl,selected_pixels);
                [data_matrix_training,class_matrix] = feature_selector(selected_pixels,bbc,I1,ws,nf,nb);
                cnt1=numel(find(data_matrix_training(:,end)==1));
                cnt=cnt1+cnt;
                data_matrix=[data_matrix;data_matrix_training];
                class_matrix_data=[class_matrix_data,class_matrix];
                i=i+300;
                % toc
                c_i_t=c_i_t+1;
            end
            
            [SVMStruct,kkt,rbf_sigma ] = classifier_training(data_matrix,class_matrix_data,rbf,C);
            svm{tp1,1} = SVMStruct;
%             [Itemp, matf ] = classifier(SVMStruct,ws);
             [ matf ] = classifier(SVMStruct,ws);
            matfin{tp1} = matf;
            svm{tp1,2} = matf;
            
            %true positives
            formatSpec = ' %2.1f & %2.2f &%2.2f &%2.2f &%2.1f &%2.1f &%2.1f &%2.1f &%2.1f &%2.1f ';
            Srno=Srno+1;
            N=2*ws+1;
            TP=100* sum(matf(:,1))/sum(matf(:,1)+matf(:,3));
            TN=100* sum(matf(:,2))/sum(matf(:,2)+matf(:,4));
            FP=100* sum(matf(:,3))/sum(matf(:,1)+matf(:,3));
            FN=100* sum(matf(:,4))/sum(matf(:,2)+matf(:,4));
            Accuracy=100*(sum(matf(:,1)+matf(:,2))/sum(matf(:,5)));
            Training_images=c_i_t;
            C=kkt;
            fprintf(formatSpec, Srno,N, C, rbf_sigma ,TP ,TN,FP,FN ,Accuracy,Training_images)
            disp('\\ \hline');
            sprintf('\n');
            i=680;
            % figure,imshow(Itemp);
            % title(['Window size is ' num2str(N) '* ' num2str(N)]);
            clm(1,1)=TP/100;
            clm(1,2)=FP/100;
            clm(2,1)=TN/100;
            clm(2,2)=FN/100;
            svm{tp1,3}=clm;
            svm{tp1,4}=rbf;
            svm{tp1,5}=C;
            svm{tp1,6}=2*tp1+1;
            filesavename=['data_param_',num2str(rbf),'_',num2str(C),'_',num2str(tp1)];
            save(filesavename,'svm');
        end
    end
end
toc

