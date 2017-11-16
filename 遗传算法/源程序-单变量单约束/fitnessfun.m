% �ӳ��򣺼�����Ӧ�Ⱥ���, �������ƴ洢Ϊfitnessfun
% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 5
% modified by ʯ��

function [Fitvalue,cumsump]=fitnessfun(population);
global BitLength  %��Ⱥ��������Ʊ��볤��
global boundsbegin  %�滮�߽����ֵ
global boundsend  %�滮�߽��յ�ֵ
popsize=size(population,1);   %��popsize�����壬size(a,1)�������a������
for i=1:popsize
   x=transform2to10(population(i,:));  %��������ת��Ϊʮ����
    %ת��Ϊ[-2,2]�����ʵ��
xx=boundsbegin+x*(boundsend-boundsbegin)/(power(2,BitLength)-1);  %�˴���ԭ������power�����ĵ�һ������boundsend����Ϊ2 
   Fitvalue(i)=targetfun(xx);  %������Ⱥ�е�i�������Ŀ�꺯��ֵ������Ӧ��
end
%����Ӧ�Ⱥ�������һ����С��������Ա㱣֤��Ⱥ��Ӧ��Ϊ����
Fitvalue=Fitvalue'+230;
%������Ⱥ����ı�ѡ���Ƹ���
fsum=sum(Fitvalue);  %��Ⱥ��Ӧ���ܺ�
Pperpopulation=Fitvalue/fsum;
%������Ⱥ����ı�ѡ�����ۻ�����
cumsump(1)=Pperpopulation(1);
for i=2:popsize
   cumsump(i)=cumsump(i-1)+Pperpopulation(i);
end
cumsump=cumsump';