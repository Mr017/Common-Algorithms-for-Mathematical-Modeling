% refer to the ����ѧ��ģ�㷨��Ӧ�� �� ��2�桷 chapter 3
% modified by ʯ��
% �ο���P23�����µ���3.2
function NP()  %�����뱣��Ϊfunction��ʽ��ʵ��ֱ�ӽ��ļ���ק������ھ�ִ��
clear
clc
X0=rand(3,1);
A=[];  %���Բ���ʽԼ��ϵ������
b=[];  %���Բ���ʽԼ���Ĳ��Ⱥ��Ҳ�ȡֵ����
Aeq=[];  %���Ե�ʽԼ��ϵ������
Beq=[];  %���Ե�ʽԼ���ĵȺ��Ҳ�ȡֵ����
LB=zeros(3,1);  %���߱����½�����
UB=[];
[x,fval]=fmincon(@Tar,X0,A,b,Aeq,Beq,LB,UB,@NONLCON);  %���
x
fval

function f=Tar(x)
f=x(1)^2+x(2)^2+x(3)^2+8;  %Ŀ�꺯��

function [g,h]=NONLCON(x)
g=[-x(1)^2+x(2)-x(3)^2
    x(1)+x(2)^2+x(3)^3-20];  %�����Բ���ʽԼ��
h=[-x(1)-x(2)^2+2
    x(2)+2*x(3)^2-3];  %�����Ե�ʽԼ��
