% �ӳ�������Ⱥ�������,�������ƴ洢Ϊcrossover.m
% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 5
% modified by ʯ��

function scro=crossover(population,seln,pc);
BitLength=size(population,2);  %��������ƴ����ȣ�size(a,2)�������a������
pcc=IfCroIfMut(pc);  %���ݽ�����ʾ����Ƿ���н��������1���ǣ�0���
if pcc==1
   chb=round(rand*(BitLength-2))+1;  %��[1,BitLength-1]��Χ���������һ������λ
   %��selection����ѡ�������������е��㽻�䣬scroΪ�������¸���
   scro(1,:)=[population(seln(1),1:chb) population(seln(2),chb+1:BitLength)];
   scro(2,:)=[population(seln(2),1:chb) population(seln(1),chb+1:BitLength)];
else
   scro(1,:)=population(seln(1),:);
   scro(2,:)=population(seln(2),:);
end