%最小二乘递推算法
%Z(k)=-a1*Z(k-1)-a2*Z(k-2)+b0*u(k)+b1*u(k-1)+v(k)
%Jiao Hailin
%2019-4-15
clear
clc

load uy1;
z=uy1(:,1);
u=uy1(:,2);
c0=[0.0001 0.0001 0.0001 0.0001]';
p0=10^7*eye(4);

for i=3:100
   H=[-z(i-1) -z(i-2) u(i) u(i-1)]';
   Z=[z(i)];
        r=H'*p0*H+1;
        K1 = p0*H/r;
        c1 = c0+K1*( Z- H'*c0);
        c0=c1;
        p1=p0-K1* H'*p0;
        p0=p1; 
        c(:,i)=c1;          
end
fprintf('待估计的参数值为：\n');
fprintf('a1=%g\n',c0(1));
fprintf('a2=%g\n',c0(2));
fprintf('b0=%g\n',c0(3));
fprintf('b1=%g\n',c0(4));
     
 i=1:100;  
 figure(1)
for k=1:4
 plot(i,c(1,:),'k:','linewidt',2)
 hold on
 plot(i,c(2,:),'g','linewidt',2)
 hold on
 plot(i,c(3,:),'k+','linewidt',2)
 hold on
 plot(i,c(4,:),'b--','linewidt',2)
legend('a1','a2','b0','b1');
end
title('待估参数的辨识情况'); 
% figure(2)
% for k=1:4
%  plot(i,c(1,:),'b',i,c(2,:),'k',i,c(3,:),'g',i,c(4,:),'r');
%  legend('a1','a2','b0','b1');
% end
% title('待估参数的辨识情况'); 
      
 




