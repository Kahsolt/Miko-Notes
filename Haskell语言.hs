Haskell是一个纯函数式编程语言，长得略像Python和R
函数式编程的基本思路：取一个初始集合并将其变形，随后逐步用过滤条件缩小范围直到得出解

零.基本
:l myFunc.hs	载入.hs文件，通常是一些函数定义
:r myFunc.hs 重新载入

一.常用内部函数
前缀函数：<函数名> [操作数1] [操作数2]，可以转换为中缀式，此时函数名用反引号``括起来
中缀函数：[操作数1] <函数名> [操作数2]

数值运算：+、-、*、/、div(取整除法)、mod(取余除法)、^(乘方)、sqrt(开平方)
逻辑运算：&&、||、not(对True或False取反)、==、/=(判断不等于)、>、>=、<、<=
succ x	取后继
max x y	取二者较大
min x y	取二者较小
compare x y	比较x和y，返回GT、LT或EQ(Ordering类型)

二.自定义函数：以.hs文件保存后载入
函数定义：函数名不能以大写字母开头
<函数名> <形参表>=<返回值表达式>
如：myFunc x = if x `mod` 2 == 0
				then x/2
			   else x*3-1
	f x = (if x>100 then x/2 else x*2)+1
	dis x y = sqrt (x*x + y*y)
	PI = 3.1415926	//无参函数称之为定义或者名字

函数调用：
如：myFunc 5
	f 75
	dis 3 4

三.数据结构
1.列表[]：单类型元素组，字符串是一种特殊列表
[]	空表
["What ","is ","this"]
let odd = [1,3,5,7,9]	let关键字用来定义常量
let str = "Hello"++" "++"World"
let listlist = [[1,4,7],[2,5,8],[3,6,9]]	嵌套表

运算及访问：
++	列表连接 
:	Cons运算符，把左参数(一个)添加到右参数的列表头
	如：5:[1,3]等价于[5]++[1,3]
		[1,3,5,7,9]即1:3:5:7:[9]
!!	按索引访问符，索引从0开始计数
	如：str !! 5	取出字符元素'o'
		listlist !! 1 !! 1	取出数字元素5
>、<、==	列表的字典序比较，返回bool型
head [1,2,3]	返回表头元素，即第一个元素；空表报错
	head函数的定义：head :: [a] -> a
					head [] = error "Empty list!"	//error函数抛出错误并中断函数
					head (x:_) = x	//下划线_是通配符，此句或作all@(x:xs) = x
tail [1,2,3]	返回尾表，即除去第一个元素的子表；空表报错
init [1,2,3]	返回头表，即除去末一个元素的子表；空表报错
last [1,2,3]	返回表尾元素，即末一个元素；空表报错
length []	返回表长
null []	判断是否为空表
take n []	从一个给定列表取前n个元素组成子表
drop n []	从一个给定列表删除前n个元素
maximum []	返回列表最大值
minimum []	返回列表最小值
sum []	返回列表和
product []	返回列表积
elem e []	判断元素e是否在列表中

*特殊的列表：区间
[1..50]
['A'..'Z']	省略记号双点..
[2,4..48]	等效于[2,4..24*2]或[2,4..49]
[19,17..1]	降序，必须指定前两个元素，[19..1]无效
[0,5..]	无限长列表，截断方法如下：
	take 10 [0,5..]
	take 15 (repeat "Ha")	repeat接收一个参数作为重复元素
		replicate 3 "De"	replicate把操作数2重复操作数1次构成列表
	take 15 (cycle[1,5,9])	cycle接收一个列表

列表推导式：
[x*2|x<-[1..10]]
[x|x<-[50..100],mod x 7==3]	多条件用逗号区隔
let judgeOE lst = [if mod x 2==0 then "Even" else "Odd"|x<-lst]	判断一个列表元素奇偶性

2.元组()：多类型元素组
()	空元组
(1,"Ha",'z',52.4)
let findTriangle = [(a,b,c)|a<-[1..10],b<-[1..10],c<-[1..10],a^2+b^2==c^2,a+b+c<50]

二元组：序对
fst ("one",2)	返回一个二元组的首项
snd ("one",2)	返回一个二元组的尾项
zip [] []	根据所给列表，生成一个二元组列表
	如：zip ['A'..] [1,2,3,4,5]	直到短表结束则停止生成

四.类型类
:t	类型查看函数
::	“类型是”，多用于函数类型指定
	如：factorial :: Integer -> Integer
		factorial n = product [1..n]

Eq类型类：等同
	==、/=
Ord类型类：有序
	>、>=、<、<=
Show类型类：
	show x	把x以字符串输出
Read类型类：
	read x	把x从字符串智能转为其他类并立刻参与运算，也即read后面必须是个运算式
Enum类型类：有序可枚举
	元组()、Bool、Char、Ordering、Int、Integer、Float、Double
	succ x	返回后继
	pred x	返回前驱
Bounded类型类：有界
	maxBound	返回上界，如maxBound::Int
	minBound	返回下界，如minBound::(Float,Char)
Num类型类：数值
	Int、Integer、Float、Double
Integeral类型类：整型
	Int、Integer
Float类型类：浮点
	Float、Double
