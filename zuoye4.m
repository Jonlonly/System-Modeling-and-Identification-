%������Ȼ��
%Jiao Hailin
clear
clc
%%
load uy2;
z=uy2(:,1);
u=uy2(:,2);
Y=z';
U=u';
%%% ����˵��:
% CARMAģ�ͣ�A[z^(-1)]*y(k) = B[z^(-1)]*u(k) + D[z^(-1)]*e(k)
% A[z^(-1)] = 1 + a1*z^(-1) + ... + a_na*z^(-na);
% B[z^(-1)] = b0 + b1*z^(-1) + ... + b_nb*z^(-nb);
% D[z^(-1)] = 1 + d1*z^(-1) + ... + d_nd*z^(-nd);
% U: ��������
% Y: �������
% oa: A�Ľ���, ob:B�Ľ���, od: D�Ľ���
% theta: ���ƵĲ���
%%
na=2;nb=1;nc=2;d=1; nn=max(na,nc); L=size(Y,2);
xiek=zeros(nc,1); %	���������Ƴ�ֵ
yfk=zeros(nn,1); %yf(k-i) 
ufk=zeros(nn,1); %uf(k-i) 
xiefk=zeros(nc,1); %vf(k-i)
% xiefk=rand(nc,1); %vf(k-i)

thetae_1=zeros(na+nb+1+nc,1); %	�������Ƴ�ֵ
P=eye(na+nb+1+nc); 
for k=3:L
%	��������
phi=[-Y(k-1);-Y(k-2);U(k);U(k-1);xiek]; %	�齨 h�� k��
xie=Y(k)-phi'*thetae_1;
phif=[-yfk(1:na);ufk(d:d+nb);xiefk];


%	���Ƽ�����Ȼ���������㷨 
K=P*phif/(1+phif'*P*phif); 
thetae(:,k)=thetae_1+K*xie; 
P=(eye(na+nb+1+nc)-K*phif')*P;

yf=Y(k)-thetae(na+nb+2:na+nb+1+nc,k)'*yfk(1:nc); %yf(k) 
uf=U(k)-thetae(na+nb+2:na+nb+1+nc,k)'*ufk(1:nc); %uf(k) 
xief=xie-thetae(na+nb+2:na+nb+1+nc,k)'*xiefk(1:nc); %vf(k)

%	�������� 
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

fprintf('�����ƵĲ���ֵΪ��\n');
fprintf('a1=%g\n',thetae_1(1));
fprintf('a2=%g\n',thetae_1(2));
fprintf('b0=%g\n',thetae_1(3));
fprintf('b1=%g\n',thetae_1(4));
fprintf('c1=%g\n',thetae_1(5));
fprintf('c2=%g\n',thetae_1(6));
figure(1)
plot([1:L],thetae(1:na,:));
xlabel('k'); ylabel('	��������	a');
legend('a_1','a_2'); axis([0 L -2 2]);
figure(2)
plot([1:L],thetae(na+1:na+nb+1,:));
xlabel('k'); ylabel('	��������	b');
legend('b_0','b_1'); axis([0 L -1.5 2]); 
figure(3) 
plot([1:L],thetae(na+nb+2:na+nb+nc+1,:)); xlabel('k'); ylabel('	��������	c');
legend('c_1','c_2'); axis([0 L -2 2]);