% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 3
% modified by ʯ��
% �����Դ����ļ�������Ƚϣ�����ϸ΢���
%% ��������
clear,clc
data=xlsread('Coporation_evaluation.xlsx', 'B2:I16');  %��ȡ����
%% PCA����
[pc,score] = princomp(data);
%% �������ɷ��ܵ÷�
rows=size(data,1);
for i=1:rows
    total_score(i,1)=i;
    total_score(i,2)=sum(score(i,:));
end
%% �����ʾ
result_report=[total_score score];
result_report_s=sortrows(result_report,-2);  %��-2������result_report�ĵڶ��н�������
disp('���ɷַ�������')
result_report_s  %��1��Ϊ��ţ��ڶ���Ϊ����˾�����ɷ��ܵ÷֣������зֱ�Ϊ�������ɷֵĵ÷�
