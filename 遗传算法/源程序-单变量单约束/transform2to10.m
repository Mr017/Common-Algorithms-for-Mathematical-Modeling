% �ӳ��򣺽�2������ת��Ϊ10������,�������ƴ洢Ϊtransform2to10.m
% refer to the ��MATLAB����ѧ��ģ�е�Ӧ�� �� ��2�桷 chapter 5
% modified by ʯ��

function x=transform2to10(Population);
BitLength=size(Population,2);
x=Population(BitLength);
for i=1:BitLength-1
   x=x+Population(BitLength-i)*power(2,i);
end
