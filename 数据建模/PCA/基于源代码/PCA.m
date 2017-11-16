% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 3
% modified by ʯ��
clear,clc
A=xlsread('Coporation_evaluation.xlsx', 'B2:I16');  %��ȡ����
a=size(A,1);
b=size(A,2);
for i=1:b
    SA(:,i)=(A(:,i)-mean(A(:,i)))/std(A(:,i));  %���ݱ�׼������
end

CM=corrcoef(SA);  %�������ϵ������

[V, D]=eig(CM);  %�������ϵ�����������ֵ����������

for j=1:b
    DS(j,1)=D(b+1-j, b+1-j);  %����ֵ���������������
end
for i=1:b
    DS(i,2)=DS(i,1)/sum(DS(:,1));  %ÿ������ֵ�Ĺ�����
    DS(i,3)=sum(DS(1:i,1))/sum(DS(:,1));  %����ֵ�ۼƹ�����
end

%ѡ�����ɷּ���Ӧ����������
T=0.9;  %���ɷ���Ϣ������
for K=1:b
    if DS(K,3)>=T
        Com_num=K;  %�����ۼƹ�������õ����ɷ���
        break;
    end
end

%��ȡ���ɷֶ�Ӧ����������
for j=1:Com_num
    PV(:,j)=V(:,b+1-j);
end

%��������۶�������ɷֵ÷�
new_score=SA*PV;
for i=1:a
    total_score(i,1)=i;
    total_score(i,2)=sum(new_score(i,:));
end
result_report=[total_score new_score];
result_report_s=sortrows(result_report,-2);  %��-2������result_report�ĵڶ��н�������

% Displays result reports
disp('����ֵ�������ʡ��ۼƹ����ʣ�')
DS
disp('��ֵT��Ӧ�����ɷ���������������')
Com_num
PV
disp('���ɷַ�����')
new_score
disp('���ɷַ�������')
result_report_s  %��1��Ϊ��ţ��ڶ���Ϊ����˾�����ɷ��ܵ÷֣������зֱ�Ϊ�������ɷֵĵ÷�
