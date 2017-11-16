% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 9
% modified by ʯ��
% ��Ⱥ�㷨���������ʵ���϶������������⣿
%% ����׼��
clear all,clc
t0 = clock;  % ���г������м�ʱ���ɲ�ѯclock����
citys=xlsread('data.xlsx', 'B2:C53');  % ��������
%--------------------------------------------------------------------------
%% ������м��໥����
n = size(citys,1);  % ��������
D = zeros(n,n);
for i = 1:n
    for j = 1:n
        if i ~= j
            D(i,j) = sqrt(sum((citys(i,:) - citys(j,:)).^2));  % ���м����ԽǾ���
        else
            D(i,j) = 1e-4;      % �趨�ĶԽǾ�������ֵ
        end
    end    
end
%--------------------------------------------------------------------------
%% ��ʼ������
m = 75;                              % �����������������������������ֵΪ1.5ʱ��Ϊ����
alpha = 1;                           % ��Ϣ����Ҫ�̶����ӣ���Ϣ�����ӣ�����Ϣ�����Ӵ���[1,4]֮���Ϊ����
beta = 4.5;                          % ����������Ҫ�̶����ӣ������������ӣ��������������Ӵ���[3,4.5]֮���Ϊ����
vol = 0.2;                           % ��Ϣ�ػӷ�(volatilization)���ӡ���Ϣ�ػӷ����Ӵ���[0.2,0.5]֮���Ϊ����
Q = 10;                              % ��Ϣ�س�ϵ������Ϣ�س�ϵ������[10,1000]֮���Ϊ����
Heu_F = 1./D;                        % ��������(heuristic function)
Tau = ones(n,n);                     % ��Ϣ�ؾ���
Table = zeros(m,n);                  % ·����¼��
iter = 1;                            % ����������ֵ
iter_max = 100;                      % ���������� 
Route_best = zeros(iter_max,n);      % �������·��       
Length_best = zeros(iter_max,1);     % ���ε��������·������  
Length_ave = zeros(iter_max,1);      % ���ε�����·��ƽ������  
Limit_iter = 0;                      % ��������ʱ��������
%-------------------------------------------------------------------------
%% ����Ѱ�����·��
while iter <= iter_max  % ÿ����1��
    % ��������������ϵ�������
      start = zeros(m,1);
      for i = 1:m
          temp = randperm(n);
          start(i) = temp(1);
      end
      Table(:,1) = start; 
      % ������ռ�
      citys_index = 1:n;
      % �������·��ѡ��
      for i = 1:m
          % �������·��ѡ��
         for j = 2:n  % ���ɵ�i������ʣ��ķ��ʳ���·��
             tabu = Table(i,1:(j - 1));         % �ѷ��ʵĳ��м���(���ɱ�)
             allow_index = ~ismember(citys_index,tabu);    % ismember(a,b):���Ҿ��������a���Ƿ���ھ��������b�е�Ԫ�أ�������aͬά�ȵ��߼�����
             allow = citys_index(allow_index);  % �����ʵĳ��м���
             P = allow;  % ��P����ֵ��allow������ʵ�����壬��Ϊ��ʹP��allow������ͬά��
             % ������м�ת�Ƹ���
             for k = 1:length(allow)
                 P(k) = Tau(tabu(end),allow(k))^alpha * Heu_F(tabu(end),allow(k))^beta;  % ����ӵ�ǰλ�ó�����δ���ʳ��еĸ��ʣ�tabu(end)Ϊ��ǰλ�ã�allow(k)Ϊ��k��δ���ʵĳ���
             end
             P = P/sum(P);
             % ���̷�ѡ����һ�����ʳ���
             Pc = cumsum(P);     % �����ۻ�ת�Ƹ���
             target_index = find(Pc >= rand);   
             target = allow(target_index(1));
             Table(i,j) = target;
         end
      end
      % ����������ϵ�·������
      Length = zeros(m,1);
      for i = 1:m
          Route = Table(i,:);
          for j = 1:(n - 1)
              Length(i) = Length(i) + D(Route(j),Route(j + 1));
          end
          Length(i) = Length(i) + D(Route(n),Route(1));  %��i�����ϵ�·��Ѱ������
      end
      % �������·�����뼰ƽ������
      if iter == 1
          [min_Length,min_index] = min(Length);  % [min_value,min_index] = min(a):��������a�е���СԪ��min_value��min_value��������a�е�λ��
          Length_best(iter) = min_Length;  
          Length_ave(iter) = mean(Length);
          Route_best(iter,:) = Table(min_index,:);
          Limit_iter = 1; 
          
      else
          [min_Length,min_index] = min(Length);
          Length_best(iter) = min(Length_best(iter - 1),min_Length);
          Length_ave(iter) = mean(Length);
          if Length_best(iter) == min_Length
              Route_best(iter,:) = Table(min_index,:);
              Limit_iter = iter; 
          else
              Route_best(iter,:) = Route_best((iter-1),:);
          end
      end
      % ������Ϣ��
      Delta_Tau = zeros(n,n);  % ��ʼ����Ϣ������
      % ������ϼ���
      for i = 1:m
          for j = 1:(n - 1)   % ����
              Delta_Tau(Table(i,j),Table(i,j+1)) = Delta_Tau(Table(i,j),Table(i,j+1)) + Q/Length(i);  % ·�����ȴ���Ϣ��������С
          end
          Delta_Tau(Table(i,n),Table(i,1)) = Delta_Tau(Table(i,n),Table(i,1)) + Q/Length(i);  % ·�����ȴ���Ϣ��������С
      end
      Tau = (1-vol) * Tau + Delta_Tau;  % ������Ϣ�ء���Ϣ�صĴ�СӰ���������������м��ת�Ƹ���
    % ����������1�����·����¼��
    iter = iter + 1;
    Table = zeros(m,n);
end
%--------------------------------------------------------------------------
%% �����ʾ
[Shortest_Length,index] = min(Length_best);
Shortest_Route = Route_best(index,:);
Time_Cost=etime(clock,t0);  % etime(b,a)����ȡʱ������a��ʱ������b���ʱ�����������
disp(['��̾���:' num2str(Shortest_Length)]);  % num2str���������ַ���ת��
disp(['���·��:' num2str([Shortest_Route Shortest_Route(1)])]);  % ·�����Ϊһ����
disp(['������������:' num2str(Limit_iter)]);
disp(['����ִ��ʱ��:' num2str(Time_Cost) '��']);
%--------------------------------------------------------------------------
%% ��ͼ
figure(1)  %���ƶรͼ��
plot([citys(Shortest_Route,1);citys(Shortest_Route(1),1)],...  % ��ͼ�ĺ�������˴������˺ܾã�������citys(Shortest_Route,1)��citys(Shortest_Route,2)��Ϊ������������
     [citys(Shortest_Route,2);citys(Shortest_Route(1),2)],'o-');
grid on
for i = 1:size(citys,1)
    text(citys(i,1),citys(i,2),['   ' num2str(i)]);  % ����text�����ڳ���������Է��ó��б�� 
end
text(citys(Shortest_Route(1),1),citys(Shortest_Route(1),2),'       ���');
text(citys(Shortest_Route(end),1),citys(Shortest_Route(end),2),'       �յ�');
xlabel('����λ�ú�����')
ylabel('����λ��������')
title(['ACA���Ż�·��(��̾���:' num2str(Shortest_Length) ')'])
figure(2)
plot(1:iter_max,Length_best,'b');
xlabel('��������');
ylabel('��̾���');
title('�㷨�����켣');
%--------------------------------------------------------------------------
