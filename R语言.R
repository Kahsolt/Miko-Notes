#R是一门解释型统计编程语言，多用于数据分析师分析数据
#所有的变量都是列表

零.R结构基础
函数帮助
	查函数的help文件：?函数名 或 help(函数名)
	查运算符的help文件：?`运算符`
	搜索相关函数：apropos("mea")
	函数参数意义：args(mean)
R的模板库:包
	install.packages("coefplot")安装
	library("coefplot")			加载
	require("coefplot")			加载，相对于library(),会返回表示是否成功的bool值
	detach("coefplot")			卸载
R Source file引用：相当于C/C++头文件引用
	source("MyFunctions.R")
数据导入
	read.csv()
	read.table(file="XXX",header=TRUE,sep=",")	sep为分割符
工作空间加载/存储
	load(file="DF.rdata")
	save(DF,file="DF.rdata")
	saveHistory(file="DF.Rhistory")
	getwd()		#查看工作空间的保存目录
对象查看与删除
	objects()或ls()
	remove(a,b)或rm(i)
立刻内存回收
	gc()	虽然R会周期性自动回收
关闭退出控制台
	q()
输出
	print()

一.基本数据
变量声明及赋值->/<-
	x<-2
	9->y
	z.value=3		//可以带点号.表示子域(js like)
	a<-b<-1
	assign("i",10)
数据类型
	数值型	n<-20
	整型	x<-5L								R默认的数据是浮点型numeric，若要声明整型integer需用L后缀
	字符型	S<-"Hello"							求长度用nchar(S)
			s<-'Single is also right.'			连接用paste(str1,str2)
	因子型	T<-factor("World!")
	日期型	d<-as.Date("1995-06-03")			实际记录自Linux纪元以来的天数，可用as.numeric(d)输出以检验
			t<-as.POSIXct("2000-05-01 12:30")	实际记录自Linux纪元以来的秒数
	逻辑型	TRUE和FALSE(或者用R预存在变量T和F中的值，但不建议，因为两个变量可能被重新赋值了)
			同时也可以作为数值，TRUE=1,FALSE=0
	常量型	数据缺失NA,不是数值NaN,无值NULL,无穷大Inf
		判定表：Function		+/-Inf		NaN		NA
				is.finite()		FALSE	FALSE	FALSE
				is.infinite()	TRUE	FALSE	FALSE
				is.nan()		FALSE	TRUE	FALSE
				is.na()			FALSE	TRUE	TRUE
数据类型判定
	class(x)	查看数据类型，返回字符串
	is.numeric()或is.double()
	is.integer()
	is.complex()
	is.character()
	is.logical()	以上返回相应的bool值
数据类型转换
	as.DataType()	#用具体的类型名取代DataType
数据运算
	&/|/xor()/!/any()/all()		逻辑运算
	^或**		乘方/幂
	%%		取模
	%/%		带余除法求商
	%in%		判断包含，例如 a %in% c(a, b, c)
	# 运算符也是函数：`+`(2,3)等价于2+3
*常用数学运算
	log(x,base=y)
	exp(x)	
	sqrt(x)
	factorial(x)
	min(x)
	max(x)	
	range(l)			同时返回列表的最大最小值，等同于c(min(x),max(x))
	length(l)			求列表长度
	nchar(x)			求字符串长度
	seq(from,to,by,length,along)
	rep(x,times=5)
	mean(1)				求均值，还有rowMeans()、colMeans()
	var(1)				求方差
	sum(x)/cumsum(l)	求和/累积求和，还有rowSums()、colSums();可加入na.rm=TRUE参数去NA值
	prod(x)/cumprod(l)	求积/累积求积
	diff(l)				返回各元素与下一个元素之差
	abs(x)				求绝对值
	ceiling(x)
	floor(x)
	trunc(x)
	round(x,digits=y)	舍入到y位小数，y为负时舍入到个十百千万位
	signif(x,digits=y)	舍入到y位有效数字

二.高级数据结构vector、data.frame、list、matrix、array
0.数据形态
	元素数据类型统一	元素数据类型任意
一维	vector			list
二维	matrix			data.frame
多维	array
1.向量vector：一个同类型元素的合并，没有维度
向量声明及赋值
	用:运算符，产生步长为1的序列
		1:50
		-15:25
		7:-15
	用seq()函数
		seq(from=4.5,to=2.5,by=-0.5)
		seq(from=-2.7,to=1.3,length.out=5)
	用c()函数连接向量
		c("Credo","Quia","Absurdum")
		c(-5:-1,6,2:-7,seq(from=4,to=20,by=2))
	用rep()函数重复向量
		rep(c(1,2,3),each=3)
		rep(c(1,2,3),times=3)
		rep(c(1,2,3),times=c(3,2,1))
		rep(1:3,length.out=10)
缺失数据和空数据
	z<-c(1,NA,51,NA,46,10,NA)
	z<-c(NaN,4,NaN,3,23,NaN)
	z<-c(5,NULL,4,NaN,50,NA)	向量中只有5个元素：三个数据两个空缺，NULL不被存储
	g<-NULL		建立空对象，仅这种情况下is.null()为TRUE
	is.na()		数据缺失
	is.nan()	不是数字Not A Number
	is.null()	空白，对象没有值
向量元素的取子集：[]运算		#下标从1开始
	x[5]
	x[-2]		略去第2项
	x[1:10]
	x[c(1,3,5)]
	x[x>5]		所有值大于5的项
	x[1:length(x)-5]		等价于tail(x,5)
向量的属性
	x<-c(1,23,456)
	str(x)							显示向量类型和结构信息
	names(x)<-c("S","Hg","NaCl")	设置列名
	length(x)						对向量求长度，返回一个整型
	nchar(x)						把每个元素视作字符串求长度，返回整型向量
向量运算：注意循环计算
	数值型运算
		x<-c(5,4,8,6,1,4)
		y<-c(5,4,7)
		x+y		整数倍长，安全循环计算
		x<-c(5,4,8,6,1,4)
		y<-c(5,4,7,5)
		x-y		不是整数倍长，警告，但仍然循环计算
	逻辑型运算
		x==5
		x<y			返回一个bool向量
		any(x<=y)
		all(x>y)	返回一个bool值
		!&/|/&&/||
		xor(x,y)
*因子向量
	factor(c(5,4,8,6,1,4))
	因子的水平值Level即x作为集合时的势(忽略重复元素后的个数)，而且已排序

2.数据框data.frame：若干等长的向量按列拼合
	x<-0:10
	y<-(-20:-10)
	z<-5:15
	DF<-data.frame(x,y,z)	此时data.frame每一列的名字也就是原来每个向量的名字
	DF<-data.frame(Sun=x,Moon=y,Star=z)	此时列名字将被重设为指定的标识符
	*stringsAsFactors=FALSE参数组织字符型数据(若存在)自动转化为Factor
数据框的属性
	nrow(DF)	行数，也即原向量长度
	ncol(DF)	列数，即向量的个数
	dim(DF)		行数及列数，两个维度
	colnames(DF)	列名字，或names(DF)，colnames(DF)[k]返回第k列的名字
	rownames(DF)	行名字，用rownames(DF)<-NULL还原为默认的1:n序列
	head(DF,n=k)	显示头k行，默认为6行
	tail(DF,n=k)	显示尾k行
	length(DF)	对数据框求长度，返回一个整型
	nchar(DF)	对每个向量求长度，返回整型向量
数据框元素的访问
	按列名访问列：$运算
		DF$Sun
		DF$S	若前端匹配唯一，则输出匹配的列；若有重复则输出NULL
	按位置访问；[,]运算
		DF[1,3]
		DF[c(1,3.4),2:3]
		DF[5,]
		DF[5:1,c("Moon","Star")]
		DF["Star"]	注意：用DF[,"Star"]或DF[["Star"]]会返回factor型，可在[]内加上drop=FALSE防止降级

3.列表list：多个不同类型向量vector的合并
	l<-list(1:5,"Aloha",c(4+3,-5,NaN,7),2:-4)
	r<-list(A=1:5,B="Mojosa",C=c(4,-5,NaN,7),D=20:-4)	加个名字
	r[]	# 取向量
	r[[1]]	# 取值
列表的属性函数：
	names()
	length()
	nchar()

4.矩阵matrix：同型元素的合并，两个维度
矩阵建立
	直接建立矩阵：matrix()函数
		m<-matrix(1:20,nrow=5)
		n<-matrix(-4:15,ncol=4)
	等长向量的拼凑：cbind(),rbind()
		x<-c(1,3,5)
		y<-c(2,4,6)
		cbind(x,y)	列排
		rbind(x,y)	行叠
	向量变矩阵：添加维度dim()
		x<-c(5,4,8,1,5,1,2,51,5)
		dim(x)<-c(3,3)
矩阵运算
	+、-、*、/对同型矩阵有效，对应元素的和差积商
	==、>、<、>=、<=、!=对同型矩阵有效，返回向量矩阵
	%*%矩阵阵乘，满足左列等于右行有效
	%o%矩阵外乘法

矩阵的属性函数
	nrow()	
	ncol()	
	dim()	
	attributes()	
	rownames()	
	colnames()
矩阵的方法函数
	t()	取转置矩阵

5.数组array：多维向量
	a<-array(1:24,dim=c(2,3,4))
数组的属性函数
	dim()

三.字符串操作
1.字符串连接：paste()函数
	paste("A","B","C")
	paste("1995","6","3",sep="-")	对于多个字符参数，sep指定连接符
	paste(c("Y","W"),c("H","H"))
	paste("A",c("B","C","D"),c("E","F"))	循环操作读出ABE,ACF,ADE
	paste(c("V","O","A"),collapse="-")		对于一个字符向量，collapse指定连接符
2.文本分离：strsplit()函数
	strsplit(str,sep=".")		返回一个列表
3.格式化串：sprintf()函数
	sprintf("Credo Quia %s",s<-"Absurdum")
	sprintf("It is a %s day!",c("happy","sad","humid","glorious"))


四.控制语句与逻辑结构
1.条件语句
	if(表达式){语句集}
	else{语句集}
	ifelse(表达式,真返回值,假返回值)
	switch(参数,符合值表=返回值表)	没有符合值时返回NULL
*逻辑联结词
	&&和||	有短路效应
	&和|	无短路效应，除此以外无差别	
2.循环语句
	for(循环变量名 in 范围向量)
		{语句集}
	while(表达式)
		{语句集}
	repeat	#即while(TRUE)
		{语句集}
*特殊控制语句有
	next
	break

五.自定义函数function()
函数名<-function(参数表=缺省参数,...)	#语句集只有一行的时候，可以省略大括号，把整个函数定义写在同一行上
{
	语句集
	return(返回值)
}
invisible(ret)	可以作为函数最后一句，标示返回值不被自动输出到屏幕
*简单库函数
identical(x,y)	比较是否相同，返回逻辑型
attributes(x)	展示所有属性
summary()	展示一些基本特征值的统计
sort(x)	排序，另有order()和sort.list()

六.库函数族
1.apply族：apply(),lapply(),sapply(),mapply()
apply(矩阵名,1(对行处理)/2(对列处理),函数名,na.rm=TRUE)
	对一个矩阵的行或者列进行同一个函数操作，返回一个向量(na.rm可以控制NA值的去除)
lapply(列表名/向量名,函数名)
	对一个列表的每一个子表进行同一个函数操作，返回一个列表
sapply(列表名/向量名,函数名)
	对一个列表的每一个子表进行同一个函数操作，返回一个向量
mapply(函数名,列表名集)
	对多个列表的每一个子表进行同一个函数操作，返回一个向量
2.plyr族：

七.统计数据分布分析
r随机函数，产生符合分布规律的随机数
d密度函数，计算一个特定值发生的概率，即分布函数的y值
p分布函数，计算累积概率(默认为左侧)，即分布函数(-无限,给定值]的面积积分
q分位数函数，p的反函数，计算给出面积积分[0,期望(通常是1)]对应的x值
1.正态分布norm
rnorm(n,mean=0,sd=1)	产生n个随机数，若在之前用set.seed(种子数)或设置相同的sd=m取相同的种子，则会产生相同的数字序列
dnorm(x,mean=0,sd=1,log=FALSE)
pnorm(q,mean=0,sd=1,lower.tail=TRUE,log.p=FALSE)
qnorm(p,mean=0,sd=1,lower.tail=TRUE,log.p=FALSE)
2.二项分布binom
rbinom(n,size=100,prob=0.5)
dbinom
pbinom
qbinom
3.泊松分布pois
rpois(n=100，lambda=2)
dpois
ppois
qpois

八.效率分析与调试
1.语句集运行时间：system.time()
2.R分析器：Rprof()+summaryRprof()
