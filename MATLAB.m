% MatLab是一个矩阵分析实验室

一.符号
0.常量
	ans		% 上一次运算结果
	eps		% =2e-52
	pi
	Inf
	NaN		% 不是数，0/0或者Inf/Inf
	i/j		% 虚数单位
1.常用数学函数
	log2(x)
	fix(x)		% 截断式取整
	round(x)	% 四舍五入
	rem(x,y)	% 取余
	mod(x,y)	% 取模
2.运算符号
	*|.*	% 矩阵|数组乘
	^|.^	% 矩阵|数组乘方
	\|.\	% 矩阵|数组左除
	/|./	% 矩阵|数组右除
	~=		% 判断不等
	&/|/~	% 与或非
3.结构符号
	:	% 序列生成
	;	% 分隔行，不回显本行结果
	,	% 分隔行，分隔函数参数
	()	% 提高优先级
	[]	% 矩阵
	{}	% 单元数组
	...	% 续行符
	'	% 字符串标示，向量转置
4.通用命令
	!/cd/ls/type/home	% 调Dos命令
	clc/clf		% 清除工作窗口/图形窗口
	home	% 清屏，光标移至左上角
	clear 	% 清理内存变量
	pack	% 内存碎片整理
	hold	% 图形保持开关
	format
	path
	diary	% 日志文件
	save/load
5.输入输出杂项
	A=input('input something')
	disp(A)
	pause(100)	% 暂停100s
	pause()		% 暂停直到按下任意键

二.数据
0.形式
	符号
		syms a b c d	% 定义为符号
	向量
		vec=[1,2,3,4,5]
		vec=[1 2 3 4 5]
		vec=1:5
		vec=-pi:pi/100:pi
	矩阵
		mat=[1,2,3; 4,5,6; 7,8,9]
		mat=[1 2 3; 4 5 6; 7 8 9]
		mat=[1:3; 4:6; 7:9]
2.矩阵形成函数
zeros(n[,m])	% 产生零阵
eye(n[,m])		% 产生单位阵，m存在时为增广的单位阵
rand()/randn()	% 产生0~1随机数阵
diag(vec[,k])	% 产生对角阵
3.元素访问()
mat(5,6)
mat(1,1)=15
mat(2,1:3)=[1,2,3]
mat2=mat(1:5,3:7)	% 抽取子矩阵
mat3=mat(:,[1,3,5])	% 冒号:表示所有行列
4.矩阵操作
[m1, m2]		% 横向连接
[m1; m2]		% 纵向连接
mat(2,:)=[]		% 删除行
mat(:,[2,3])=[]	% 删除列
diag(mat)		% 抽取主对角元素
rot90(mat[,k])	% 逆时针旋转k个90度
fliplr(mat)/flipud(mat)	% 左右/上下翻转
tril(mat)/triu(mat)		% 抽取下/上三角阵
5.矩阵运算
	+|-|*|^|/|\
	inv(mat)	% 逆矩阵
	det(mat)	% 行列式
	lu(mat)		% 三角分解
	qr(mat)		% 正交三角分解
	svd(mat)	% 奇异值分解
	eig(mat)	% 特征值分解，[V,D]=eig(A)
	[V,D]=eig(mat)

三.程式
0.控制结构
条件
	if expr1
		statement1
	elseif expr2
		statement2
	else
		statementn
	end
分支
	switch expr
		case expr1
			statement1
		case expr2
			statement2
		otherwise
			statementn
	end
迭代
	for variable=expr
		statement
	end
循环
	while expr
		statement
	end
1.函数：m文件
function [avg,med]=mmval(u)
% Find Mean and median
% This commet wiil be displayed when 'help mmval'
n=length(u)
avg=mean(u,n)
med=median(u,n)

function a=mean(v,n)
% Calculate average
a=sum(v)/n

function m=median(v,n)
% Calculate median number
w=sort(v);
if rem(n,2) == 1
	m=w((n+1)/2)
else
	m=(w((n+1)/2)+w((n+1)/2))/2
end

四.函数库
	simple(A)		% 找符号矩阵最简形
	factor(y)		% 因式分解
	length(x)		% 向量长度
	size(A)			% 矩阵维数
	linsolve(A,b)	% 解Ax=b，等价于A/b
	null(A,'r')		% 求Ax=0的基础解系
	polyfit(x,y,n)	% 算n次多项式的值
	vpa(x,n)		% 控制浮点精度输出
	plot(x,y)		% 画图
	rref(A)			% 矩阵初等变换-梯矩阵
	solve(x)		% 解符号方程
	subs()			% 符号变量赋值。用数值代替符号
	rank(A)			% 矩阵秩
	norm(x)			% 向量取模
	dot(x,y)		% 向量内积
	poly(A)			% 特征多项式系数
	poly2str(A,'x')	% 特征多项式，det(x*E-A)
					% factor(poly2sym(poly(A)))
	orth(A)			% 列向量组正交规范化
	jordan(A)		% 化jordan标准型
	trace(A)		% 矩阵迹
