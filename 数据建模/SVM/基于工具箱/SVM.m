% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 3
% modified by ʯ��
%% ���ݴ���
clear,clc
X0=xlsread('SVM_data.xlsx', 'B2:E19');  %��������
Training=X0(:,1:3);  %��������
Group=X0(:,4);  %��������
%% SVM����
SVMStruct = svmtrain(Training,Group);
%% ����Ԥ�⣬�˴�ʹ�õ�ѵ������
pre = svmclassify(SVMStruct,Training)
