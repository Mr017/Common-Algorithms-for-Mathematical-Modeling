% �ӳ����ж��Ŵ������Ƿ���Ҫ���н�������, �������ƴ洢ΪIfCroIfMut.m
% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 5
% modified by ʯ��

function pcc=IfCroIfMut(pcORpm);  %�������pcORpmΪ������ʻ�������
test(1:100)=0;
l=round(100*pcORpm);
test(1:l)=1;
n=round(rand*99)+1;  %rand�ȼ���rand(1)
pcc=test(n);  