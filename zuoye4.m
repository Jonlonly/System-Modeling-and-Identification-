%极大似然法
%Jiao Hailin
clear
clc
%%
load uy2;
z=uy2(:,1);
u=uy2(:,2);
Y=z';
U=u';
%%% 参数说明:
% CARMA模型：A[z^(-1)]*y(k) = B[z^(-1)]*u(k) + D[z^(-1)]*e(k)
% A[z^(-1)] = 1 + a1*z^(-1) + ... + a_na*z^(-na);
% B[z^(-1)] = b0 + b1*z^(-1) + ... + b_nb*z^(-nb);
% D[z^(-1)] = 1 + d1*z^(-1) + ... + d_nd*z^(-nd);
% U: 输入向量
% Y: 输出向量
% oa: A的阶数, ob:B的阶数, od: D的阶数
% theta: 估计的参数
%%
na=2;nb=1;nc=2;d=1; nn=max(na,nc); L=size(Y,2);
xiek=zeros(nc,1); %	白噪声估计初值
yfk=zeros(nn,1); %yf(k-i) 
ufk=zeros(nn,1); %uf(k-i) 
xiefk=zeros(nc,1); %vf(k-i)
% xiefk=rand(nc,1); %vf(k-i)

thetae_1=zeros(na+nb+1+nc,1); %	参数估计初值
P=eye(na+nb+1+nc); 
for k=3:L
%	构造向量
phi=[-Y(k-1);-Y(k-2);U(k);U(k-1);xiek]; %	组建 h（ k）
xie=Y(k)-phi'*thetae_1;
phif=[-yfk(1:na);ufk(d:d+nb);xiefk];


%	递推极大似然参数估计算法 
K=P*phif/(1+phif'*P*phif); 
thetae(:,k)=thetae_1+K*xie; 
P=(eye(na+nb+1+nc)-K*phif')*P;

yf=Y(k)-thetae(na+nb+2:na+nb+1+nc,k)'*yfk(1:nc); %yf(k) 
uf=U(k)-thetae(na+nb+2:na+nb+1+nc,k)'*ufk(1:nc); %uf(k) 
xief=xie-thetae(na+nb+2:na+nb+1+nc,k)'*xiefk(1:nc); %vf(k)

%	更新数据 
thetae_1=thetae(:,k); 
for i=nc:-1:2
xiek(i)=xiek(i-1); xiefk(i)=xiefk(i-1);
end
xiek(1)=xie; xiefk(1)=xief;

for i=nn:-1:2 
    yfk(i)=yfk(i-1);
    ufk(i)=ufk(i-1); 
end
yfk(1)=yf; 
ufk(1)=uf;
end
% thetae_1

fprintf('待估计的参数值为：\n');
fprintf('a1=%g\n',thetae_1(1));
fprintf('a2=%g\n',thetae_1(2));
fprintf('b0=%g\n',thetae_1(3));
fprintf('b1=%g\n',thetae_1(4));
fprintf('c1=%g\n',thetae_1(5));
fprintf('c2=%g\n',thetae_1(6));
figure(1)
plot([1:L],thetae(1:na,:));
xlabel('k'); ylabel('	参数估计	a');
legend('a_1','a_2'); axis([0 L -2 2]);
figure(2)
plot([1:L],thetae(na+1:na+nb+1,:));
xlabel('k'); ylabel('	参数估计	b');
legend('b_0','b_1'); axis([0 L -1.5 2]); 
figure(3) 
plot([1:L],thetae(na+nb+2:na+nb+nc+1,:)); xlabel('k'); ylabel('	参数估计	c');
legend('c_1','c_2'); axis([0 L -2 2]);