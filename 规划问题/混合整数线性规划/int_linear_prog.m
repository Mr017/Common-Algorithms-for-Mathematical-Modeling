% refer to the ����ѧ��ģ�㷨��Ӧ�� �� ��2�桷 chapter 2
% modified by ʯ��
% �ο���P18�����µ���2.8
function int_linear_prog()  %�����뱣��Ϊfunction��ʽ��ʵ��ֱ�ӽ��ļ���ק������ھ�ִ��
clear
clc
f=[-3 -2 -1];  %Ŀ�꺯��ϵ������
intcon=3;  %��������λ��
A=[1 1 1];  %����ʽԼ��ϵ������
b=[7];  %����ʽԼ���Ĳ��Ⱥ��Ҳ�ȡֵ����
Aeq=[4 2 1];  %��ʽԼ��ϵ������
Beq=[12];  %��ʽԼ���ĵȺ��Ҳ�ȡֵ����
LB=zeros(3,1);  %���߱����½�����
UB=[inf;inf;1];  %���߱����Ͻ�����
[x,fval]=intlinprog(f,intcon,A,b,Aeq,Beq,LB,UB);  %��⣬MATLAB 2012a�汾�޷�����
x
fval
