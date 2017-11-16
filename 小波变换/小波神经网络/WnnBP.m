% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 10
% modified by ʯ��

function main()
clc;clear all;close all;
%��Mexihat������Ϊ������������
x=0:0.03:3; %��������ֵ
c=2/(sqrt(3).*pi.^(1/4));
d=1/sqrt(2);
u=x/2-1;
targ=d.*c.*exp(-u.^2/2).*(1-u.^2);  % Ŀ�꺯�����������ֵ
eta=0.02; aerfa=0.735; %��������ѧϰ���ʺͶ������ӳ�ʼֵ
%��ʼ�������������������Ȩֵwjh�������������������Ȩֵwhi.
%����С�������ڵ���ΪH,������ΪP,����ڵ���ΪJ,����ڵ���ΪI.
H=15;P=2;I=length(x);J=length(targ);
b=rand(H,1);a=rand(H,1); %��ʼ��С������������������ƽ����������
whi=rand(I,H);wjh=rand(H,J); %��ʼ��Ȩϵ����
b1=rand(H,1);b2=rand(J,1); %��ʼ����ֵ;
p=0;
Err_NetOut=[]; %�������
flag=1;count=0;
while flag>0
flag=0;
count=count+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xhp1=0;
for h=1:H  %��ѭ����ɺ��õ�����������ڵ�ľ�����
    for i=1:I
        xhp1=xhp1+whi(i,h)*x(i);  %xhp1Ϊ�����Ե�h��������ڵ�ļ�Ȩ����
    end
ixhp(h)=xhp1+b1(h);  %ixhp(h)Ϊ��h��������ڵ�ľ����루������Ȩ��������ֵ���ڣ�
xhp1=0;  %xhp1����
end

for h=1:H
oxhp(h)=fai((ixhp(h)-b(h))/a(h));  %oxhp(h)Ϊ�������h���ڵ�������faiΪ������С�����ݺ���
end

ixjp1=0;
for j=1:J  %��ѭ����ɺ��õ����������ڵ�ľ�����
  for h=1:H
      ixjp1=ixjp1+wjh(h,j)*oxhp(h);  %ixjp1Ϊ������Ե�j�������ڵ�ļ�Ȩ����
  end
ixjp(j)=ixjp1+b2(j);  %ixjp(j)Ϊ��j�������ڵ�ľ����루������Ȩ��������ֵ���ڣ�
ixjp1=0;  %ixjp1����
end

for j=1:J
    oxjp(j)=fnn(ixjp(j));  %oxjp(j)Ϊ������j���ڵ�����
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wuchayy=1/2*sumsqr(oxjp-targ);
Err_NetOut=[Err_NetOut wuchayy];  %����ÿ�ε����
%���С����������BP�㷨��������ÿ��ѧϰ�ĵ�����
for j=1:J
    detaj(j)=-(oxjp(j)-targ(j))*oxjp(j)*(1-oxjp(j));
end
for j=1:J
  for h=1:H
      detawjh(h,j)=eta*detaj(j)*oxhp(h);
  end
end
detab2=eta*detaj;
sum=0;
for h=1:H
  for j=1:J
      sum=detaj(j)*wjh(h,j)*diffai((ixhp(h)-b(h))/a(h))/a(h)+sum;
  end
detah(h)=sum;
sum=0;
end
for h=1:H
  for i=1:I
      detawhi(i,h)=eta*detah(h)*x(i);
  end
end
detab1=eta*detah;
detab=-eta*detah;
for h=1:H
    detaa(h)=-eta*detah(h)*((ixhp(h)-b(h))/a(h));
end

%���붯������aerfa���ӿ������ٶȺ��谭����ֲ���Сֵ����̬������Ȩϵ������ֵ���������ӡ�ƽ������
wjh=wjh+(1+aerfa)*detawjh;
whi=whi+(1+aerfa)*detawhi;
a=a+(1+aerfa)*detaa';
b=b+(1+aerfa)*detab';
b1=b1+(1+aerfa)*detab1';
b2=b2+(1+aerfa)*detab2';

%���㷨���õ�����������������������������
p=p+1;
if p~=P
    flag=flag+1;
else
    if Err_NetOut(end)>0.008  %������������㾫��Ҫ����ѧϰ����������6000�������ѧϰ
        flag=flag+1;  
    else  %�������������㾫��Ҫ��  
        figure;
        plot(Err_NetOut);
        xlabel('����ѧϰ����');ylabel('����������');
        title('����ѧϰ�������','fontsize',20,'color',[0 1 1],'fontname','����');
    end
end
if count>6000  %ѧϰ��������6000��ֹͣѧϰ
    figure(1);
    subplot(1,2,1)
    plot(Err_NetOut,'color','b','linestyle','-','linewidth',2.2,...
        'marker','^','markersize',3.5);
    xlabel('����ѧϰ����');ylabel('����������');
    title('�������','fontsize',20,'color',[1 1 1],'fontname','����');
    subplot(1,2,2)
    plot(x,targ,'color','r','linestyle','--','linewidth',2.2,...
        'marker','p','markersize',3.5);
    hold on  %ͬһ��ͼ���ϻ��ƶ������ߣ���Ҫ�������߱���
    plot(x,oxjp,'color','g','linestyle','-.','linewidth',2.2,...
        'marker','d','markersize',3.5);
    xlabel('��������ֵ');ylabel('����Ŀ��ֵ���������ֵ');
    title('Ŀ��ֵ���������ֵ�Ƚ�','fontsize',20,'color',[1 1 1],'fontname','����');
    legend('����Ŀ��ֵ','�������ֵ');
    break;
end
end

function y3=diffai(x)  %�ӳ��򣬼������������ʱ�õ�
y3=-1.75*sin(1.75*x).*exp(-x.^2/2)-cos(1.75*x).*exp(-x.^2/2).*x;

function yl=fai(x)  %�����㴫�ݺ����ӳ���MorletС����
yl=cos(1.75.*x).*exp(-x.^2/2);

function y2=fnn(x)  %�ӳ����������õ���S�ʹ��ݺ���logsig��
y2=1/(1+exp(-x));
