%�����򣺱���������Ŵ��㷨����������
%���ϴν���������õ���������Ⱥ��Ϊ�´�����ĳ�ʼ��Ⱥ
% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 5
% modified by ʯ��

clc;
close all;
clear all;
T=500;  %��������
optionsOrigin=gaoptimset('Generations',T/2,'Populationsize',35,'StallGenLimit',250);  %���ν������ԣ�gaoptimset�������Կɲο���MATLAB����ѧ��ģ�е�Ӧ�á���2�桷P91
[x,fval,reason,output,finnal_pop]=ga(@ConstAndFit,2,optionsOrigin);
options1=gaoptimset('Generations',T/2,'InitialPopulation',finnal_pop,'Populationsize',35,'StallGenLimit',250,...
    'PlotFcns',@gaplotbestf);  %�ڶ��ν�������
[x,fval,reason,output,finnal_pop]=ga(@ConstAndFit,2,options1);   %���еڶ��ν�������
Bestx=x  %��Ӧ�����Ÿ���
BestFval=-fval  %�����Ӧ��ֵ