% ����kmeans����������������
% created by ʯ��
%% ��������
clear,clc
data=[0 0;1 0; 0 1; 1 1;2 1;1 2; 2 2;3 2; 6 6; 7 6; 8 6; 6 7; 7 7; 8 7; 9 7 ; 7 8; 8 8; 9 8; 8 9 ; 9 9];  %ÿһ������Ϊһ������ֵ
%% ����
[idx ctrs]=kmeans(data,2);
%%  ������������ο�help kmeans
plot(data(idx==1,1),data(idx==1,2),'r*','MarkerSize',10)
hold on
plot(data(idx==2,1),data(idx==2,2),'b*','MarkerSize',10)
plot(ctrs(:,1),ctrs(:,2),'kx',...
     'MarkerSize',12,'LineWidth',2)
plot(ctrs(:,1),ctrs(:,2),'ko',...
     'MarkerSize',12,'LineWidth',2)
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
   