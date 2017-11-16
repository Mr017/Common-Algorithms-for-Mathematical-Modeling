% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 4
% modified by ʯ��
clc;
close;
clear all;
format short;  % ��������������
% ԭʼ���ݾ���
x=[308.58 310 295 346 367
195.4 189.9 187.2 205 222.7
24.6 21 12.2 15.1 14.57
20 25.6 23.3 29.2 30
18.98 19 22.3 23.5 27.655
170 174 197 216.4 235.8
57.55 70.74 76.8 80.7 89.85
88.56 70 85.38 99.83 103.4
11.19 13.28 16.82 18.9 22.8
4.03 4.26 4.34 5.06 5.78
13.7 15.6 13.77 11.98 13.95];
n1=size(x,1);  %�����ݾ�������
n2=size(x,2);
% ���ݱ�׼������
% for i = 1:n1
% x(i,:) = x(i,:)/x(i,1);
% end  %�����ݴ���������ӦΪÿ�����ݳ��Ը�������Ӧ�Ĺ̶��ʲ�Ͷ�ʣ���ֱ�Ӳ���Դ����

consult=x(6:n1,:);  % ����ο����У�ĸ���أ�
m1=size(consult,1);  %�ο���������

compare=x(1:5,:);  % ����Ƚ����У������أ�
m2=size(compare,1);   %�Ƚ���������

for i=1:m1
for j=1:m2
t(j,:)=compare(j,:)-consult(i,:);
end
min_min=min(min(abs(t')));  %min��max�������������Ϊ����ʱ�����Ϊ�þ���ÿһ�е���ֵ
max_max=max(max(abs(t')));
% ͨ���ֱ��ʶ���ȡ0.5
resolution=0.5;
% �������ϵ��
coefficient=(min_min+resolution*max_max)./(abs(t)+resolution*max_max);  %�����ص�����������ĸ���صĵ�i�����ݵĹ���ϵ������
% ���������
corr_degree=sum(coefficient')/size(coefficient,2);  %sum�������������Ϊ����ʱ�����Ϊ�þ���ÿһ�еĺ�
r(i,:)=corr_degree;
end

% ���������ֵ����������ͼ
r
bar(r,0.90);  %���ƹ����Ⱦ������״ͼ��������ÿ�����εĿ��Ϊ0.9
axis tight;  %Set the axis limits to the range of the data.
% �������������� �̶��ʲ�Ͷ��,��ҵͶ��,ũҵͶ��,�Ƽ�Ͷ��,��ͨͶ��
le=legend('�̶��ʲ�Ͷ��','��ҵͶ��','ũҵͶ��','�Ƽ�Ͷ��','��ͨͶ��');  %leΪͼ�����
set(le,'fontname','����');  %�˾�������ӣ�����ͼ������Ϊ����


% ���³�����Ϊ�˸�x����Ӻ��ֱ�ǩ
% �����ԭ������ȥ��x���ϵĹ��б�ǩ��Ȼ�����ı���עx��

set(gca,'XTickLabel','');  % ȥ����ǰX���ϵĿ̶�ֵ

%  �趨X��̶ȵ�λ�ã�������6��ĸ����
n=6;
% ����ע�⣺x_range��Χ�����[1 n]�ᵼ�²���������������ʾ����
% ���Է�ΧҪ��һ��
x_value = 1:1:n;
x_range = [0.6 n+.4];  %[0.6 6.4]
% ��ȡ��ǰͼ�εľ��
set(gca,'XTick',x_value,'XLim',x_range);

% ��X���ϱ��6��ĸ����
profits={'��������','��ҵ����','ũҵ����','��ҵ����','��ͨ����','����ҵ����'};
y_range = ylim;
% ���ı���עĸ��������
handle_date = text(x_value,y_range(1)*ones(1,n)-.001,profits(1:1:n));  %handle_dateΪ��ӵ��ı��ľ�����˴�text�������÷�Ϊtext(x,y,'String')��StringΪ����ʾ���ı���x��yΪ�ı�����
% ���ı����������ú��ʵĸ�ʽ�ʹ�С����תһ���ĽǶ�
set(handle_date,'HorizontalAlignment','right','VerticalAlignment','top', 'Rotation',35,...
'fontname','����','fontsize',10.5);
% y����
ylabel('y');
ti=title('Ͷ�ʶ����������');  %tiΪfigure����ľ��
set(ti,'fontname','����','fontsize',10.5);  %�˾�������ӣ�����figure��������Ϊ����
