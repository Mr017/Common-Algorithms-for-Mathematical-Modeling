% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 4
% modified by ʯ��

clc, clear all, close all
syms a b;
u=[a b]';
x0=[89677,99215,109655,120333,135823,159878,182321,209407,246619,300670];  %ԭʼ����
x1=cumsum(x0);  % ԭʼ�����ۼ�
n=length(x0);
for i=1:(n-1)
    z(i)=(x1(i)+x1(i+1))/2;  % ���ɽ��ھ�ֵ
end
% �������������ֵ
Y=x0(2:end)';
B=[-z;ones(1,n-1)];
u=inv(B*B')*B*Y;
u=u';
a=u(1);b=u(2);
% Ԥ���������
forcast_temp=[];forcast_temp(1)=x0(1);
for i=2:(n+10)
    forcast_temp(i)=(x0(1)-b/a)/exp(a*(i-1))+b/a ;
end
forecast=[];forecast(1)=x0(1);
for i=2:(n+10)
    forecast(i)=forcast_temp(i)-forcast_temp(i-1); %�õ�Ԥ�����������
end 

epsilon = x0 - forecast(1:n);  % ����в�
delta = abs(epsilon./x0);  % ����������

% ����ģ�͵����
% ���鷽��һ��������Q���鷨��QԽСģ��Խ��ȷ
Q = mean(delta)

% ���鷽�����������C���鷨
% �����׼���Ϊstd��x,a��
% �������һ������aȡ0��ʾ���ǳ���n��1�������1����������n
C = std(epsilon,1)/std(x0,1)

% ���鷽������С������P���鷨
S1 = std(x0,1);
S1_new = S1*0.6745;
temp_P = find(abs(epsilon-mean(epsilon)) < S1_new);
P = length(temp_P)/n

t1=1999:2008;
t2=1999:2018;
forecast
plot(t1,x0,'ko', 'LineWidth',2)
hold on
plot(t2,forecast,'k', 'LineWidth',2)
xlabel('���', 'fontsize',12)
ylabel('����/(Ԫ/��)','fontsize',12)
set(gca,  'LineWidth',2);
