close all
clc,clear
global p     % 训练集输入数据
global t     % 训练集输出数据
global R     % 输入神经元个数   
global S2    % 输出神经元个数
global S1    % 隐层神经元个数
global S     % 编码长度  其实就是连接权值个数和阈值个数的总和
S1 = 5;
%训练数据用txt的太少了，只能从label那里面挑选
load('label.mat');
[a,b,c,d]=textread('1.txt','%s%f%f%d');
train_data=[b c]';train_label=d';

[A,~] = geotiffread('4.tiff');
info = geotiffinfo('4.tiff');
Lat=[];Lon=[];
k=0;
for i=1:2184
    [x,y] = pix2map(info.RefMatrix, i, 1);
    [lat,lon] = projinv(info, x,y);
    Lat=[Lat,lat];
end
for j=1:1034
    [x,y] = pix2map(info.RefMatrix, 1, j);
    [lat,lon] = projinv(info, x,y);
    Lon=[Lon,lon];
end
newmat1=[];
newmat2=[];
aa=1;
for i=1:2184
    newmat1(1034*(i-1)+1:1034*i,1)=Lat(i);
end
while aa<=2184
    newmat2=[newmat2;Lon'];
    aa=aa+1;
end

% b=newmat2(1:2258256);
% c=newmat1(1:2258256);
% d=label(1:2258256);
% train_data=[b c]';train_label=d;

 % 1. 训练数据
p1=train_data;
t1=train_label;

P_test1=[newmat2 newmat1]';
% 2. 测试数据
% 数据归一化
[p, ps_input] = mapminmax(p1,0,1);
P_test = mapminmax('apply',P_test1,ps_input);
[t, ps_output] = mapminmax(t1,0,1);  
% 1. 创建网络
net = newff(minmax(p),[S1,1],{'tansig','purelin'},'trainlm'); 
% 2. 设置训练参数
net.trainParam.show = 10;
net.trainParam.epochs = 50;   %迭代次数
net.trainParam.goal = 1e-5;      %mse均方根误差小于这个值训练结束
net.trainParam.lr = 0.05;         %学习率
% 3. 训练网络
net = train(net,p,t);
% 4. 仿真测试
s_bp = sim(net,P_test);         %返回预测值
ans1=mapminmax('reverse',s_bp,ps_output);
ans1=round(ans1);
save('ans1.mat','ans1');
% 误差
% N = size(P_test,2);
% MAE1=sum(abs(ans1-test_y))/N;
% MAPE1=sum(abs((ans1-test_y)./test_y))/N;
% RMSE1=power(sum(power(ans1-test_y,2))/N,1/2);
% [MAE1;MAPE1;RMSE1]