% ���������Ŵ��㷨���y=200*exp(-0.05*x).*sin(x)��[-2 2]�����ϵ����ֵ
% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 5
% modified by ʯ��

clc;
clear all;
close all;
global BitLength  %��Ⱥ��������Ʊ��볤��
global boundsbegin  %�滮�߽����ֵ
global boundsend  %�滮�߽��յ�ֵ
bounds=[-2 2];  %һά�Ա�����ȡֵ��Χ
precision=0.0001;  %���㾫��
boundsbegin=bounds(:,1);
boundsend=bounds(:,2);
BitLength=ceil(log2((boundsend-boundsbegin)' ./ precision)); %������Ⱥ��������Ʊ��볤�ȣ�ceil���������������ȡ��
popsize=100; %��ʼ��Ⱥ��С����Ⱥ����ȡ��Щ�������ڶ�εĳ��������ж��������ϺõĽ������Ⱥƽ����Ӧ���������Ӧ���ڽ������ڵ�ƽ�������̶ȣ�
Generationnmax=12  %������
pcrossover=0.90; %�������
pmutation=0.09; %�������
population=round(rand(popsize,BitLength));  %rand�������ڲ������ӱ�׼��̬�ֲ�����Ԫ��ȡֵ��0-1���������飻round����Ϊ�������뺯��������������Ⱥ��������Ķ����ƴ�
[Fitvalue,cumsump]=fitnessfun(population);  %������Ӧ��,������Ӧ��Fitvalue���ۻ�����cumsump
Generation=1;
while Generation<Generationnmax+1
   for j=1:2:popsize  %���ա�����ѡ�񷨡�ÿ�δ�ԭ��Ⱥ��ѡ�񡢸����������壬��ѡ���ĸ��彻�䡢�������������������������߼��������������Ŵ��㷨ԭ���г��� 
      %ѡ���Ʋ���
      seln=selection(cumsump);
      %�������
      scro=crossover(population,seln,pcrossover);
      scnew(j,:)=scro(1,:);
      scnew(j+1,:)=scro(2,:);
      %�������
      smnew(j,:)=mutation(scnew(j,:),pmutation);
      smnew(j+1,:)=mutation(scnew(j+1,:),pmutation);
   end
   population=smnew;  %�������µ���Ⱥ
   %��������Ⱥ����Ӧ��   
   [Fitvalue,cumsump]=fitnessfun(population);
   %��¼��ǰ����õ���Ӧ�Ⱥ�ƽ����Ӧ��
   [fmax,nmax]=max(Fitvalue);  %����Ӧ���������е����ֵ����λ��
   fmean=mean(Fitvalue);
   ymax(Generation)=fmax;  %��ǰ����Ⱥ�����Ӧ��
   ymean(Generation)=fmean;  %��ǰ����Ⱥƽ����Ӧ��
   %��¼��ǰ�������Ⱦɫ�����
   x=transform2to10(population(nmax,:));
   %�Ա���ȡֵ��Χ��[-2 2],��Ҫ�Ѿ����Ŵ���������Ⱦɫ�����ϵ�[-2 2]����
  xx=boundsbegin+x*(boundsend-boundsbegin)/(power(2,BitLength)-1);  %�˴���ԭ������power�����ĵ�һ������boundsend����Ϊ2
   xmax(Generation)=xx;  %��ǰ����Ӧ����Ѹ���
   Generation=Generation+1;
end
Generation=Generation-1;  %�����Ŵ�����
Bestpopulation=xx  %��Ѹ���
Besttargetfunvalue=targetfun(xx)  %���Ŀ��ֵ

%���ƾ����Ŵ���������Ӧ�����ߡ�һ��أ����������������Ⱥ��ƽ����Ӧ���������
%Ӧ�������������໥��ͬ����̬����ʾ�㷨�������еú�˳����û�г����𵴣�������ǰ
%���£������Ӧ�ȸ����������ɴ���û�з�������������Ⱥ�Ѿ����졣
figure(1);
hand1=plot(1:Generation,ymax);  %������Ⱥ�и���������Ӧ��ֵ
set(hand1,'linestyle','-','linewidth',1.8,'marker','^','markersize',6)  %set�����ǳ�ʵ��
hold on;
hand2=plot(1:Generation,ymean);   %������Ⱥ��ƽ����Ӧ��ֵ
set(hand2,'color','r','linestyle','-','linewidth',1.8,...
'marker','h','markersize',6)
xlabel('��������'); ylabel('���/ƽ����Ӧ��'); xlim([1 Generationnmax]);  %xlim��������ָ��figure�к�����ȡֵ��Χ
legend('�����Ӧ��','ƽ����Ӧ��');
box off;  %���ڹر�figure�е��ϱ߿����ұ߿�
hold on;  %�ر�figure����