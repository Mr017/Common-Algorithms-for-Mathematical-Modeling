% �ӳ�������Ⱥѡ�����, �������ƴ洢Ϊselection.m
% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 5
% modified by ʯ��

function seln=selection(cumsump);  %ɾ����ԭ������selection�ĵ�һ����population
%���ա�����ѡ�񷨡�����Ⱥ��ѡ����������
for i=1:2
   r=rand;  %����һ�������
   prand=cumsump-r;
   j=1;
   while prand(j)<0
       j=j+1;
   end
   seln(i)=j; %ѡ�и�������
end
