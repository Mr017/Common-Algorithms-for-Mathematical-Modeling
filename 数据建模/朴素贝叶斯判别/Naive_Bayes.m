% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 3
% modified by ʯ��
% ���á����ر�Ҷ˹�б𡱵ķ������SVM�еġ����д��ʵ����ѵ���м����ݣ�Ԥ���Ե
% ���ݣ�������SVM��������ͬ�������б���ѵ����Ե���ݣ�Ԥ���м����ݣ�����������
clear,clc
train_sam=xlsread('SVM_data.xlsx', 'B6:E15');  %��ȡ������������ѵ���������������������Լ�
ObjBayes=NaiveBayes.fit(train_sam(:,1:3),train_sam(:,4));  %ѵ������
test1=xlsread('SVM_data.xlsx', 'B2:D5');  %��ȡ�������ݼ�1
test2=xlsread('SVM_data.xlsx', 'B16:D19');  %��ȡ�������ݼ�2
test=[test1 test2];
pre1=ObjBayes.predict(test1)  %Ԥ��������ݼ�1
pre2=ObjBayes.predict(test2)  %Ԥ��������ݼ�2
