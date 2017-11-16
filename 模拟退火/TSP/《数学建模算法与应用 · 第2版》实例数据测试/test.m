% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 6
% modified by ʯ��
clear	
	clc
	a = 0.99;	% �¶�˥�������Ĳ���
	t0 = 97; tf = 3; t = t0;  %t0Ϊ��ʼ�¶ȣ�tfΪ��ֹ�¶ȣ�tΪ��ǰ�¶�
	Markov_length = 10000;	% Markov������
	coordinates = [  %berlin52����
53.7121   15.3046;	51.1758    0.0322;	46.3253   28.2753;	30.3313    6.9348;
56.5432   21.4188;	10.8198   16.2529;	22.7891   23.1045;	10.1584   12.4819;
20.1050   15.4562;	1.9451    0.2057;	26.4951   22.1221;	31.4847    8.9640;
26.2418   18.1760;	44.0356   13.5401;	28.9836   25.9879;	38.4722   20.1731;
28.2694   29.0011;	32.1910    5.8699;	36.4863   29.7284;	0.9718   28.1477;
8.9586   24.6635;	16.5618   23.6143;	10.5597   15.1178;	50.2111   10.2944;
8.1519    9.5325;	22.1075   18.5569;	0.1215   18.8726;	48.2077   16.8889;
31.9499   17.6309;	0.7732    0.4656;	47.4134   23.7783;	41.8671    3.5667;
43.5474    3.9061;	53.3524   26.7256;	30.8165   13.4595;	27.7133    5.0706;
23.9222    7.6306;	51.9612   22.8511;	12.7938   15.7307;	4.9568    8.3669;
21.5051   24.0909;	15.2548   27.2111;	6.2070    5.1442;	49.2430   16.7044;
17.1168   20.0354;	34.1688   22.7571;	9.4402    3.9200;	11.5812   14.5677;
52.1181    0.4088;	9.5559   11.4219;	24.4509    6.5634;	26.7213   28.5667;
37.5848   16.8474;	35.6619    9.9333;	24.4654    3.1644;	0.7775    6.9576;
14.4703   13.6368;	19.8660   15.1224;	3.1616    4.2428;	18.5245   14.3598;
58.6849   27.1485;	39.5168   16.9371;	56.5089   13.7090;	52.5211   15.7957;
38.4300    8.4648;	51.8181   23.0159;	8.9983   23.6440;	50.1156   23.7816;
13.7909    1.9510;	34.0574   23.3960;	23.0624    8.4319;	19.9857    5.7902;
40.8801   14.2978;	58.8289   14.5229;	18.6635    6.7436;	52.8423   27.2880;
39.9494   29.5114;	47.5099   24.0664;	10.1121   27.2662;	28.7812   27.6659;
8.0831   27.6705;	9.1556   14.1304;	53.7989    0.2199;	33.6490    0.3980;
1.3496   16.8359;	49.9816    6.0828;	19.3635   17.6622;	36.9545   23.0265;
15.7320   19.5697;	11.5118   17.3884;	44.0398   16.2635;	39.7139   28.4203;
6.9909   23.1804;	38.3392   19.9950;	24.6543   19.6057;	36.9980   24.3992;
4.1591    3.1853;	40.1400   20.3030;	23.9876    9.4030;	41.1084   27.7149;
];
	%coordinates(:,1) = [];  %������������ÿ������ֵ�����
	amount = size(coordinates,1); 	% ���е���Ŀ��size(a,1):�����������size(a,2):���������
	% ͨ���������ķ�������������
	dist_matrix = zeros(amount, amount);
	coor_x_tmp1 = coordinates(:,1) * ones(1,amount);
	coor_x_tmp2 = coor_x_tmp1';
	coor_y_tmp1 = coordinates(:,2) * ones(1,amount);
	coor_y_tmp2 = coor_y_tmp1';
	dist_matrix = sqrt((coor_x_tmp1-coor_x_tmp2).^2 + ...
					(coor_y_tmp1-coor_y_tmp2).^2);

	sol_new = 1:amount;         % ������ʼ�⡣TSP������ν�Ľ⼴Ϊһ�����г��еı���˳��
% sol_new��ÿ�β������½⣻sol_current�ǵ�ǰ�⣻sol_best����ȴ�е���ý�
	E_current = inf;  % E_current�ǵ�ǰ���Ӧ�Ļ�·���룻
    E_best = inf;  % E_best�����Ž�Ļ�·���� 		
% E_new���½�Ļ�·����

	sol_current = sol_new; 
    sol_best = sol_new;          
	p = 1;  %p��ʲô������

	while t>=tf
		for r=1:Markov_length		% Markov�����ȡ�ÿһ��ǰ�¶��£������д�������Markov�����ȵĵ�����ÿ�ε���������һ������Ŷ�
			% ��������Ŷ��� ��������ǽ�������������������
			if (rand < 0.5)  %������
				ind1 = 0; ind2 = 0;
				while (ind1 == ind2)
					ind1 = ceil(rand.*amount);  %ceil������ȡ��
					ind2 = ceil(rand.*amount);
				end
				tmp1 = sol_new(ind1);  %�������
				sol_new(ind1) = sol_new(ind2);
				sol_new(ind2) = tmp1;
            else  % ������
				ind1 = 0; ind2 = 0; ind3 = 0;
				while (ind1 == ind2) || (ind1 == ind3) ...
					|| (ind2 == ind3) || (abs(ind1-ind2) == 1)  %Ϊ��Ҫ�ų�abd(ind1-ind2) == 1?
					ind1 = ceil(rand.*amount);
					ind2 = ceil(rand.*amount);
					ind3 = ceil(rand.*amount);
				end
				tmp1 = ind1;tmp2 = ind2;tmp3 = ind3;
				% ȷ��ind1 < ind2 < ind3
				if (ind1 < ind2) && (ind2 < ind3)
					;
				elseif (ind1 < ind3) && (ind3 < ind2)
					ind2 = tmp3;ind3 = tmp2;
				elseif (ind2 < ind1) && (ind1 < ind3)
					ind1 = tmp2;ind2 = tmp1;
				elseif (ind2 < ind3) && (ind3 < ind1) 
					ind1 = tmp2;ind2 = tmp3; ind3 = tmp1;
				elseif (ind3 < ind1) && (ind1 < ind2)
					ind1 = tmp3;ind2 = tmp1; ind3 = tmp2;
				elseif (ind3 < ind2) && (ind2 < ind1)
					ind1 = tmp3;ind2 = tmp2; ind3 = tmp1;
				end
				
				tmplist1 = sol_new((ind1+1):(ind2-1));  %������任���Ĳ�������
				sol_new((ind1+1):(ind1+1+(ind3-ind2))) = ...
					sol_new((ind2):(ind3));
				sol_new((ind1+ind3-ind2+2):ind3) = ...
					tmplist1;
			end

			%����Ƿ�����Լ��
			
			% ����Ŀ�꺯��ֵ�������ܣ�
			E_new = 0;
			for i = 1 : (amount-1)
				E_new = E_new + ...
					dist_matrix(sol_new(i),sol_new(i+1));
			end
			% �����ϴ����һ�����е���һ�����еľ���
			E_new = E_new + ...
				dist_matrix(sol_new(amount),sol_new(1));
			
			if E_new < E_current
				E_current = E_new;
				sol_current = sol_new;
				if E_new < E_best
% ����ȴ��������õĽⱣ������
					E_best = E_new;
					sol_best = sol_new;
				end
			else
				% ���½��Ŀ�꺯��ֵ�����ܣ����ڵ�ǰ���Ŀ�꺯��ֵ��
				% �����һ�����ʽ����½�
				if rand < exp(-(E_new-E_current)./t)
					E_current = E_new;
					sol_current = sol_new;
				else	
					sol_new = sol_current;
				end
			end
		end
		t=t.*a;		% ���Ʋ���t���¶ȣ�����Ϊԭ����a��
	end

	disp('���Ž�Ϊ��')
	disp(sol_best)
	disp('��̾��룺')
	disp(E_best)
for i=1:100
    co_new(i,:)=coordinates(sol_best(i),:);
end
plot(co_new(:,1),co_new(:,2),'ro')
hold on
plot(co_new(:,1),co_new(:,2),'k-')