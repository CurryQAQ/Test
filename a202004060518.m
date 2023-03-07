%{
姓名：苗鑫雨
学号：202004060518
班级：车辆2004
日期：2023.03.07
解决问题：最小二乘拟合 线性回归
%}
clc,clear;
% 生成600个在0-200范围内的随机数
x = rand(1, 600)*200;

% 计算满足y=3*x+6的y值
y = 3*x + 6;

% 计算需要添加噪声的数据个数
num_noise_points = round(0.6 * length(x));

% 随机选择需要添加噪声的数据索引，并添加-5%-5%的噪声
noise_index = randperm(length(x), num_noise_points);
y(noise_index) = y(noise_index) + (0.1 * rand(1, num_noise_points) - 0.05).*y(noise_index);

% 将数据分为前60%和后40%
train_x = x(1:num_noise_points);%前60%的样本点用于进行拟合
train_y = y(1:num_noise_points);%前60%的样本点用于进行拟合
test_x = x(num_noise_points+1:end);%后40%样本点用于进行误差计算
test_y = y(num_noise_points+1:end);%后40%样本点用于进行误差计算

% 最小二乘拟合
train_ones = ones(length(train_x), 1);%创建一维数组，其中元素都为1
train_A = [train_x', train_ones];%按列连接成矩阵train_A
train_coefficients = (train_A'*train_A)\train_A'*train_y';%求解正规方程得到最小二乘解
train_m = train_coefficients(1);%获取特征向量m的值
train_b = train_coefficients(2);%获取特征向量中截距b的值

% 计算误差
test_y_pred = test_x*train_m + train_b;%计算预测值
test_error = sqrt(mean((test_y-test_y_pred).^2));%计算均方根误差

% 输出结果和绘图
fprintf('实际直线方程: y = 3*x + 6\n');%输出实际直线方程
fprintf('拟合直线方程: y = %fx + %f\n', train_m, train_b);%输出拟合直线方程
fprintf('测试误差: %f\n', test_error);%输出测试误差
plot(x, y, '.', 'MarkerSize', 6);%绘制出散点图
hold on;
plot(test_x, test_y_pred, 'r-', 'LineWidth', 2);%绘制拟合曲线图
title('最小二乘拟合');
xlabel('X');
ylabel('Y');
legend('原始数据', '拟合直线');
grid on;
