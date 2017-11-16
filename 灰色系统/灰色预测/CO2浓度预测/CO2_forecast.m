format short g  %�رտ�ѧ������
data=load('CO2.txt');  %�������ݣ���Դ��https://www.co2.earth/annual-co2
nn = size(data,1);
x0 = data(1:54,2)';  %ȡԴ����ǰ54������ɫģ��
n = length(x0);

% �������жϣ������Ƿ��ʺ���GM(1��1)��ģ
lamda = x0(1:n-1)./x0(2:n);  %����
range = minmax(lamda);  %�����������lamda����ֵ
% �ж��Ƿ��ʺ���һ�׻�ɫģ�ͽ�ģ
if range(1,1) < exp(-(2/(n+1))) | range(1,2) > exp(2/(n+1))  %������ԭ�����м��Ƚ��޵Ĵ���
    error('����û�������ɫģ�͵ķ�Χ��');  %���������Ϣ
else
   % �������
    disp('              ');
    disp('����G(1��1)��ģ');
end

% ��AGO�ۼӴ���
x1 = cumsum(x0);  % Returns a vector containing the cumulative sum of the elements of x0.
for i = 2:n
    % ������ھ�ֵ��Ҳ���ǰ׻�����ֵ
    z(i) = 0.5*(x1(i)+x1(i-1));
end
B = [-z(2:n)',ones(n-1,1)];
Y = x0(2:n)';
% ���������������㷢չϵ��a�ͻ�ɫ������b
% ǧ��ע�⣺�������ҳ����������
u = B\Y;  %ע��˴�������Ч��inv(B)*Y����Ϊinv�������������Ϊ����
x = dsolve('Dx+a*x=b','x(0)=x0');  %dsolve�������������ų�΢�ַ���,�˴��÷�Ϊdsolve('����','��ʼ����')����ģ��ΪGM(1,1)�׻�ģ�ͣ�����xʵΪx1
x = subs(x,{'a','b','x0'},{u(1),u(2),x1(1)});  %�����ű��ʽx�е�a,b,x0���ɾ���u(1),u(2),x1(1)��ֵ���˴�x1(1)=x0(1)
forecast1 = subs(x,'t',[0:nn-1]);  %forecast1ΪԤ��õ���x1����
% digits��vpa�����������Ƽ������Ч����λ��
digits(6);  %����6λ��Ч����
% yֵ��AGO��ʽ�ģ������ۼӵģ�
y = vpa(x);  %����ɫģ��Ԥ��ֵ��Чλ������Ϊ6λ
% ��AGO���ֵ�����ۼ�
% diff���ڶԷ��ű��ʽ������
% �����������������������ʾ����ԭ��������Ԫ�صĲ�
forecast11 = double(forecast1);
exchange = diff(forecast11);  %ͨ��ģ��Ԥ��õ���Ϊx1���У����Ԥ�����н���IAGO����ſɵõ�x0����
forecast = [x0(1),exchange]  % �����ɫģ��Ԥ���ֵ

epsilon = x0 - forecast(1:54);  % ����в�
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

% ����ԭʼ�������ɫģ��Ԥ��ó������в�������ͼ
plot(1959:2015,data(1:nn,2),'*','markersize',11);
hold on
plot(1959:2015,forecast,'k-','linewidth',2.5);
grid on;
axis tight;
xlabel('���');
ylabel('CO2��Ũ��/ppm');
title('1959-2015ȫ��CO2��Ũ��');
legend('ԭʼ����','��ɫģ��Ԥ������');