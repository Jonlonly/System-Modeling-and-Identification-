clc;
close all;
clear;

y(1)= 0;
k=1;
u(k)= 2*rand-1;
f(k)= 0.6*sin(pi*u(k))+0.3*sin(3*pi*u(k))+0.1*sin(5*pi*u(k));
y(k+1)= 0.3*y(k)+f(k);

for k=1:100
    u(k)= 2*rand-1;
    f(k)= 0.6*sin(pi*u(k))+0.3*sin(3*pi*u(k))+0.1*sin(5*pi*u(k));
    y(k+1)= 0.3*y(k)+0.6*(k-1)+f(k); 
end

uP= u(1:100);
uT= 0.6*sin(pi*uP)+0.3*sin(3*pi*uP)+0.1*sin(5*pi*uP);
netg= newff(minmax(uP),[20,20,1],{'tansig','tansig','purelin'},'trainlm','learngdm','msereg');
[netg,tr] = train(netg,uP,uT);
% 
% uQ= -1:0.1:1;
% simu= sim(netg,uQ);
% figure;
% plot(uQ,0.6*sin(pi*uQ)+0.3*sin(3*pi*uQ)+0.1*sin(5*pi*uQ),'b',uQ,simu,'r');
% legend('系统输出','系统辨识');

k=1;
u(k)= 2*rand-1;
f(k)= 0.6*sin(pi*u(k))+0.3*sin(3*pi*u(k))+0.1*sin(5*pi*u(k));
y(k+1)= 0.3*y(k)+f(k);

for k=2:100
    u(k)= 2*rand-1;
    f(k)= 0.6*sin(pi*u(k))+0.3*sin(3*pi*u(k))+0.1*sin(5*pi*u(k));
    y(k+1)= 0.3*y(k)+0.6*y(k-1)+f(k); 
end

a0= rand;
a1= rand;
Eta= 0.5;
T = 0;
while (T<10000) 
    E= 0;
    k= round(98*rand+2);
    simy(k+1)= a0*y(k)+a1*y(k-1);
    e(k+1)= 0.3*y(k)+0.6*y(k-1)-simy(k+1);
    Delta0= -1*Eta*e(k+1)*y(k);
    Delta1= -1*Eta*e(k+1)*y(k-1);
    a0= a0- Delta0;
    a1= a1- Delta1;          
    E= 0.5*(1/99)*sum(e.^2);
    T= T+1;
end

k=1;
u(k)= sin(2*pi*k/250);
f(k)= 0.6*sin(pi*u(k))+0.3*sin(3*pi*u(k))+0.1*sin(5*pi*u(k));
y(k+1)= 0.3*y(k)+f(k);

for k=2:100
    u(k)= sin(2*pi*k/250);
    f(k)= 0.6*sin(pi*u(k))+0.3*sin(3*pi*u(k))+0.1*sin(5*pi*u(k));
    y(k+1)= 0.3*y(k)+0.6*y(k-1)+f(k); 
end

simu= sim(netg,u(2:100));
simy= a0*y(2:100)+a1*y(1:99)+simu;
figure;
plot(1:101,y(1:101),'b',3:101,simy,'r',1:100,f(1:100),'g');
legend('系统输出','系统辨识','f函数');
text(10,5.5,{strcat('a0= ',num2str(a0),', a1=',num2str(a1))});

