% �ӳ�������Ⱥ����������������ƴ洢Ϊmutation.m
% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 5
% modified by ʯ��

function snnew=mutation(snew,pm);  %pmΪ�������
BitLength=size(snew,2);
snnew=snew;
pmm=IfCroIfMut(pm);  %���ݱ�����ʾ����Ƿ���б��������1���ǣ�0���
if pmm==1
   chb=round(rand*(BitLength-1))+1;  %��[1,BitLength]��Χ���������һ������λ
   snnew(chb)=abs(snew(chb)-1);
end