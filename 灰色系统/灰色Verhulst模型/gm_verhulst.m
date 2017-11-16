% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 4
% modified by ʯ��

clc, clear all, close all
% �󳦸˾��ⶨ�Ĺ��ܶ�ֵ
x1=[0.025 0.023 0.029 0.044 0.084 0.164 0.332 0.521 0.97 1.6 2.45 3.11 3.57 3.76 3.96 4 4.46 4.4 4.49 4.76 5.01];
n=length(x1);
time=0:n-1;
figure(1);
plot(time,x1,'k*');  %����ʵ������
x0=diff(x1);
x0=[x1(1),x0];  %��ͨ��x0����Y
for i=2:n
    z1(i)=0.5*(x1(i)+x1(i-1));
end
z1;
B=[-z1(2:end)',z1(2:end)'.^2];
Y=x0(2:end)';
% ��ȻҲ����ʹ����С���˷���verhulst��ɫģ�͵ľ�����ʽ�����
% ǰ���½��Ѿ��к���ϸ�Ľ�����
abvalue=B\Y;
x=dsolve('Dx+a*x=b*x^2','x(0)=x0');
x=subs(x,{'a','b','x0'},{abvalue(1),abvalue(2),x1(1)});
forecast=subs(x,'t',0:n-1);
digits(6);x=vpa(x);
forecast

epsilon = x1 - forecast;  % ����в�
delta = abs(epsilon./x1);  % ����������

% ����ģ�͵����
% ���鷽��һ��������Q���鷨��QԽСģ��Խ��ȷ
Q = mean(delta)

% ���鷽�����������C���鷨
% �����׼���Ϊstd��x,a��
% �������һ������aȡ0��ʾ���ǳ���n��1�������1����������n
C = std(epsilon,1)/std(x1,1)

% ���鷽������С������P���鷨
S1 = std(x1,1);
S1_new = S1*0.6745;
temp_P = find(abs(epsilon-mean(epsilon)) < S1_new);
P = length(temp_P)/n

% ��ͼ
hold on;
plot(time,forecast,'k-.','linewidth',3);
xlabel('ʱ����Ȳ���/5Сʱ','fontsize',12);
ylabel('ϸ������Һ�����/OD600', 'fontsize',12);
legend('ʵ������','Ԥ������');
title('�󳦸˾�����S����������','fontsize',12);
axis tight;
