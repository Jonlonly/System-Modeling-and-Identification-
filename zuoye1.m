%%��С����һ������㷨
%Z(k)=-a1*Z(k-1)-a2*Z(k-2)+b0*u(k)+b1*u(k-1)+v(k)
%Jiao Hailin
%2019-4-15
clear all
close all
clc
%%
load uy1;     %����������
z=uy1(:,1);   %������� 
u=uy1(:,2);   %��������
%������ϵ������H(i,:)    �����۲����Z(i,:)
for i=3:100
    H(i,:)=[-z(i-1) -z(i-2) u(i) u(i-1)];
    Z(i,:)=[z(i)];
end
%%
%�������
c=inv(H'*H)*H'*Z;
%�������

fprintf('�����ƵĲ���ֵΪ��\n');
fprintf('a1=%g\n',c(1));
fprintf('a2=%g\n',c(2));
fprintf('b0=%g\n',c(3));
fprintf('b1=%g\n',c(4));

a1=c(1);
a2=c(2);
b0=c(3);
b1=c(4);
v=randn(1,100); %����һ��10��N(0,1)�ĸ�˹�ֲ����������
zz=zeros(1,10);
for k=3:100
    zz(k)=-a1*z(k-1)-a2*z(k-2)+b0*u(k)+b1*u(k-1)+1*v(k); %�۲�ֵ
end
figure(1);
i=1:100;
plot(i,z(i),'k','linewidt',2);
hold on
plot(i,zz(i),'b--','linewidt',2);
legend('��������','��������');
title('����������������߱Ƚ�');

