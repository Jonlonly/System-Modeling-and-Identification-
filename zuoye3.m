%%广义最小二乘递推算法
%Z(k)=-a1*Z(k-1)-a2*Z(k-2)+b0*u(k)+b1*u(k-1)+v(k)
clear all
close all
clc

% v=normrnd(0,sqrt(0.01),1,300); %均值为零的，方差为0.01的正态分布
%%
%最小二乘辨识程序 
load uy2;
z=uy2(:,1);
u=uy2(:,2);

%%
%%RGLS广义最小二乘辨识
%%赋初值
c0=[0.0001 0.0001 0.0001 0.0001]';
pf0=10*eye(4,4);
ce0=[0.001 0.001]';
pe0=eye(2,2);
c=[c0,zeros(4,99)];
ce=[ce0,zeros(2,99)];
e=zeros(4,100);
ee=zeros(2,100);
s=0;
%%
%广义最小二乘递推算法的计算步骤
for k=3:100
    zf(k)=z(k)+ce(1,k-1)*z(k-1)+ce(2,k-2)*z(k-2);
    uf(k)=u(k)+ce(1,k-1)*u(k)+ce(2,k-2)*u(k-1);
    
    hf1=[-zf(k-1),-zf(k-2),uf(k),uf(k-1)]';
    x=hf1'*pf0*hf1+1; x1=inv(x);
    k1=pf0*hf1*x1;
    pf1=pf0-k1*hf1'*pf0;
    pf0=pf1;
    d1=zf(k)-hf1'*c0;
    c1=c0+k1*d1;
    e1=c1-c0;
    e2=e1./c0;
    e(:,k)=e2;
    c0=c1;
    c(:,k)=c1;

    h1=[-z(k-1),-z(k-2),u(k),u(k-1)]';

    ee(k)=z(k)-h1'*c1;
    he1=[-ee(k-1),-ee(k-2)]';
    x=he1'*pe0*he1+1; x1=inv(x);
    k1=pe0*he1*x1;
    pe1=pe0-k1*he1'*pe0;
    
    d1=ee(k)-he1'*ce0;
    ce1=ce0+k1*d1;
    ce0=ce1;
    ce(:,k)=ce1;
    pe0=pe1;
end

%辨识参数变化矩阵
%显示被辨识参数及其误差（收敛）情况
%分离参数
a1=c(1,1:100);
a2=c(2,1:100);
b0=c(3,1:100);
b1=c(4,1:100);
c1=ce(1,1:100);
c2=ce(2,1:100);
ea1=e(1,1:100);
ea2=e(2,1:100);
eb1=e(3,1:100);
eb2=e(4,1:100);
figure(1);
i=1:100;
 plot(i,a1,'k:','linewidt',2)
 hold on
 plot(i,a2,'k-','linewidt',3)
 hold on
 plot(i,b0,'g','linewidt',2)
 hold on
 plot(i,b1,'g--','linewidt',2)
 hold on
 plot(i,c1,'b','linewidt',2)
 hold on
 plot(i,c2,'b--','linewidt',4)
 legend('a1','a2','b0','b1','c1','c2');
title('参数变化曲线')
figure(2)
i=1:100;
 plot(i,ea1,'k:','linewidt',2)
 hold on
 plot(i,ea2,'k-','linewidt',1)
 hold on
 plot(i,eb1,'b','linewidt',1)
 hold on
 plot(i,eb2,'g--','linewidt',3)
% plot(i,ea1,'r',i,ea2,'r',i,eb1,'b',i,eb2,'k:')
 legend('ea1','ea2','eb1','eb2');
title('误差曲线')

fprintf('待估计的参数值为：\n');
fprintf('a1=%g\n',c(1,end));
fprintf('a2=%g\n',c(2,end));
fprintf('b0=%g\n',c(3,end));
fprintf('b1=%g\n',c(4,end));


