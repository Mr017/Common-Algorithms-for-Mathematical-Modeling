% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 6
% modified by ʯ��
clear
clc
a = 0.95;  %�¶��½�ϵ��
t0 = 97; tf = 3; t = t0;  %t0Ϊ��ʼ�¶ȣ�tfΪ��ֹ�¶ȣ�tΪ��ǰ�¶�
k = [5;10;13;4;3;11;13;10;8;16;7;4];
k = -k;	% ģ���˻��㷨�������Сֵ����ȡ����
price = [2;5;18;3;2;5;10;4;11;7;14;6];
restriction = 46;  %����Լ��
num = 12;
sol_new = ones(1,num);         % ���ɳ�ʼ��
E_current = inf;
E_best = inf;  
% E_current�ǵ�ǰ���Ӧ��Ŀ�꺯��ֵ������������Ʒ�ܼ�ֵ����
% E_new���½��Ŀ�꺯��ֵ��
% E_best�����Ž��
sol_current = sol_new; 
sol_best = sol_new;
p=1;

while t>=tf
	for r=1:100  %ÿһ��ǰ�¶��£�����100�ε���
		%��������Ŷ�
		tmp=ceil(rand.*num);
		sol_new(1,tmp)=~sol_new(1,tmp);
		
		%����Ƿ�����Լ��
		while 1
			q=(sol_new*price <= restriction);  %�������б��־
			if ~q
                p=~p;	%ʵ�ֽ�������תͷβ�ĵ�һ��1
                tmp=find(sol_new==1);  %Ѱ���½�01���С�1����λ�ã����Ϊһ��������
                if p
                    sol_new(1,tmp)=0;  %ʲô��˼��ΪʲôҪ��ô����
                else
                    sol_new(1,tmp(end))=0;  %ʲô��˼��ΪʲôҪ��ô����
                end
            else
                break
			end
		end
		
		% ���㱳���е���Ʒ��ֵ
		E_new=sol_new*k;
		if E_new<E_current
            E_current=E_new;
            sol_current=sol_new;
            if E_new<E_best
				% ����ȴ��������õĽⱣ������
                E_best=E_new;
                sol_best=sol_new;
            end
		else
            if rand<exp(-(E_new-E_current)./t)
                E_current=E_new;
                sol_current=sol_new;
            else
                sol_new=sol_current;
            end
		end
	end
	t=t.*a;
end

disp('���Ž�Ϊ��')
sol_best
disp('��Ʒ�ܼ�ֵ���ڣ�')
val=-E_best;
disp(val)
disp('��������Ʒ�����ǣ�')
disp(sol_best * price)
