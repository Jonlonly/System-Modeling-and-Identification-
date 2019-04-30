%Jiao Hailin
%2019-4-15
clear all
close all
clc

%%
load uy1;     %����������
z=uy1(:,1);   %������� 
u=uy1(:,2);   %��������
% load uy2;     %��ɫ��������
% z=uy2(:,1);   %������� 
% u=uy2(:,2);   %��������

%%
%%������ϵ������H(i,:)    �����۲����Z(i,:)
%����Ϊ1��
n=1;
for i=2:100
    HL1(i,:)=[-z(i-1) u(i-1)];
    ZL1(i,:)=[z(i)];
end
c1=inv(HL1'*HL1)*HL1'*ZL1;
e=ZL1- HL1*c1;
V(1)=e'*e/100;


%����Ϊ2��
n=2;
for i=3:100
    HL2(i,:)=[-z(i-1) -z(i-2) u(i-1) u(i-2)];
    ZL2(i,:)=[z(i)];
end
c2=inv(HL2'*HL2)*HL2'*ZL2;
e=ZL2- HL2*c2;
V(2)=e'*e/100;

%����Ϊ3��
n=3;
for i=4:100
    HL3(i,:)=[-z(i-1) -z(i-2)  -z(i-3) u(i-1) u(i-2) u(i-3)];
    ZL3(i,:)=[z(i)];
end
c3=inv(HL3'*HL3)*HL3'*ZL3;
e=ZL3- HL3*c3;
V(3)=e'*e/100;

%����Ϊ4��
n=4;
for i=5:100
    HL4(i,:)=[-z(i-1) -z(i-2) -z(i-3) -z(i-4) u(i-1) u(i-2) u(i-3) u(i-4)];
    ZL4(i,:)=[z(i)];
end
c4=inv(HL4'*HL4)*HL4'*ZL4;
e=ZL4- HL4*c4;
V(4)=e'*e/100;

%����Ϊ4��
n=5;
for i=6:100
    HL5(i,:)=[-z(i-1) -z(i-2) -z(i-3) -z(i-4) -z(i-5) u(i-1) u(i-2) u(i-3) u(i-4) u(i-5)];
    ZL5(i,:)=[z(i)];
end
c5=inv(HL5'*HL5)*HL5'*ZL5;
e=ZL5- HL5*c5;
V(5)=e'*e/100;

%%
figure(1)
i=1:5;
plot(1:5,V(i),'-o','markersize',10);
xlabel('ģ�ͽ״Σ�n��'); ylabel('	�в��(Jn)	');
axis([0 5 -2 4]);
title('���в���');
disp('�в��');
disp(V);


