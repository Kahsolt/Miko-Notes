#Python是一门脚本解释语言
#注释用井号标示

零.Python结构基础
0.库引用：两种方式
import <库名>
	然后以<库名>.<库函数名>的方式调用
from <库名> import <库函数名,名,名……>
from <库名> import *	//全部引用
	然后以<库函数名>的方式调用

1.输入输出
接收为Python表达式=input("提示性文字")
接收为字符串变量=raw_input("提示性文字")
print()的格式化：
	1.类同于C语言的占位符%d、%f、%c
	例：print("It is %4d." %15)
	2.<string>.format{<参数的Index>:<填充符><对齐方式><域宽>.<精度><类型>}	//Index从0开始计数，左对齐<，右对齐>，居中^
	例：print("It is {1:7.2f} pounds and {0:7.2f} cents!".format(5.5,3))
		print("My ID number is {0:-^12}.".format(14211050))
print("Hell",end="")	#指定结尾分隔符
sys.stdout.write()		#import sys，调用标准输出
sys.stdin.readline()	#import sys，读入一行

2.同步赋值(元组赋值)
x,y,z=a,b,c	依次对应赋值，用x,y=y,x可以交换两变量值
yearStr,monthStr,dayStr=dateStr.split("-")	如将"1995-5-1"分割后依次赋值

3.特殊的存在
None	None不属于任何数据类型，是个无类型的对象，可以把它赋给任意类型的变量
is运算符	判断两个对象是否同一，或为别名
反斜线\	代码分行续写
#注释
'''多行注释'''

4.帮助
import sys
help(函数名)	#返回函数定义
dir(类名)		#返回一个类中所有被定义过的成员方法列表
eval()		#表达式估值，简单语句执行
exec()		#执行语句

一.基本数据类型：不定义，弱类型(其实是个指针)
type()	类型判断函数，返回type型
int()long()float()complex()bool()str()	强制类型转换，注意complex类不能转为其他类；bool()取0和None为False
*eval(<string>)	字符串表达式求职

x=5		整型int
y=1320L	长整形long
	range(5)		产生从0到小于5的整型序列
	range(5,15)		产生从5到小于15的整型序列
	range(-5,15,3)	产生从5到小于15步长为3的整型序列
pi=3.1415	浮点型float
E=5.2e-3	浮点的科学计数法<Float_a>e/E<Int_b>，这里是0.0052
z=2.5+3.5j	复数型complex，j为虚数单位
flag=True	逻辑Bool型
y="Hehe World."	字符串类型

基本运算符：
+	加法运算、字符串连接
-
*
/
//	带余除法的商
%	求模，浮点数也适用
divmod(x,y)	带余除法，返回tuple类(x//y,x%y)
**	幂运算，或用pow(x,y)函数
sqrt()	开平方运算
注意：逻辑联结词为and、or、not


数学库：import math
pi	圆周率常量
e	自然对数底数常量
ceil()floor()	取整
exp()log()log10()	指数对数
degrees()radians()	角度转换
sin()cos()tan()asin()acos()atan()	三角函数

随机数库：import random
seed(x)		设置种子
random()		随机产生一个[0,1)的小数
uniform(a,b)	随机产生一个[a,b)的小数
randint(a,b)	随机产生一个[a,b)的整数
randrange(a,b,c)	随机产生一个[a,b)间以c递增的数
choice(<list>)		从列表中随机返回一个元素
shuffle(<list>)		将此列表打乱
sample(<list>,k)	从指定序列随机获取k个元素

*字符串处理：字符串元素不可改变，名字不同内容相同的字符串为同一字符串
x="Hehe World."
y='双引号和单引号作用等同'
z='''三引号
会保持文本——的相对...
板式'''
len(y)
y.upper()
sub=y[0:4]
sub2=y[:-1]	-k表示倒数第k个位置
*正则表达式：import re
例一：	str = 'A cute word:cat!!'
		match =re.search(r'word:\w\w\w',str)
		if match:
			print 'found',match.group()
例二：	print re.search(r'..g','piiig').group()			//任意
		print re.search(r'\d\d\d','p123g').group()		//digital
		print re.search(r'\w\w\w','@@abcd!!').group()	//word
		print re.search(r'pi+','piiig').group()			//+表示1次及以上
		print re.search(r'pi*','pg').group()			//*表示0次及以上
		print re.search(r'[abc]+','xxxacbbcbbadddedede').group()	//含abc的连续字符串
		print re.search(r'[a-d]+','xxxacbbcbbadddedede').group()	//含abcd的连续字符串
例三：	str = 'purple alice-b@jisuanke.com monkey dishwasher'
		match=re.search('([\w.-]+)@([\w.-]+)',str)
		if match:
			print match.group()
			print match.group(1)
			print match.group(2)
例四：	str = 'purple alice@jisuanke.com, blah monkey bob@abc.com blah dishwasher'
		tuples=re.findall(r'([\w\.-]+)@()[\w\.-]+',str)

基本运算：
+	连接
*	数乘，自身复制
len(<string>)	求长度
<string>[]	按位置索引
<string>[x:y]	剪切子串
<string>.upper()	全大写，还有.lower()、.capitalize()和.swapcase()
<string>.strip()	去除两端空格，去除指定字符
<string>.split(ch)	字符串按指定分隔符分割
<string>.find('Substr',start,end)	字符串从start到end搜索
ord(Char_c)	字符c转ASCII数值
chr(Int_x)	数值x转字符
<strsub> in <str>	成员检查，判断strsub是否为str的子串，返回bool值
for <iterator> in <string>	字符串类是特殊的列表

二.高级数据类型
1.列表list：任意类型元素的合并(字符串是特殊的列表)
NL=[]	空表
L=[2L,3.55,"FFF",True,2+3j]
LL=[(1,2,3),("A","B"),(5j,9+j)]	 广义表表示的二维层次

基本运算和方法：
sum(<list>)	求和
<list>.append(x)	末尾追加元素x
<list>.sort()	排序，逆序用<list>.sort(reverse=True)
				*sorted(<list>,reverse=False,key=<比较函数>)	带返回值的排序
<list>.reverse()	反序
<list>.index(x)	按值查找第一个x的位置
<list>.insert(i,x)	在i处插入x
<list>.remove(x)	按值删除第一个x
<list>.count(x)	计数x出现的次数
<list>.pop(i)	取出i位置的元素作为返回值，并删除
del <list>[元素索引或子表]	按位置删除

2.元组tuple：不可变的列表
NT=()	空元组
T=(2L,3.55,"FFF",True,2+3j)

3.字典dict：键值对，无序
ND={}	空字典
Trilove={"Adam":1,"Lilith":0,"Eva":2}	Key:Value的形式中，通过Trilove[Key]返回Value
x={"A":[1,2,3],"B":["1"],"c":"3"}

基本运算和方法：
<dict>.keys()	以列表形式返回所有键信息
<dict>.values()	以列表形式返回所有值信息
<dict>.items()	以列表形式返回所有键值对
<dict>.get(<key>,<errMsg>)	若键存在则返回值，否则返回错误信息errMsg
<dict>.clear()	清空所有键值对
del <dict> <key>	删除某个键值对
<key> in <dict>	成员检查，返回bool值
for <iterator> in <dict>	字典是无序的列表

直方图函数：
def histogram(s):
	d=dict()
	for c in s:
		if c not in d:
			d[c]=1;
		else:
			d[c]+=1;
	return d;

三.文件读写
<fileVar>=open(<name>,<mode>)	打开一个文件，如fin=open("test.in","r")
<fileVar>.close()	关闭文件
打开模式：
	r	只读(默认)
	w	只写
	r+	读写
	a	末尾追加
	rb、wb、ab	以二进制操作
读取操作：
	<fileVar>.read()	整个文件读为一个字符串
	<fileVar>.readline()	读入一行并包含换行符，文件指针移至下一行首
	<fileVar>.readlines()	整个文件读为一个字符串列表，每个列表元素为一行
例如：for lines in f.readlines():	用循环变量lines遍历每一行
写入操作：
	print>><fileVar>,<输出内容>
	如：print>>fout,"Glorious is Greek\nGrand is Rome\n"

或用with...as...嵌套，保证文件打开失败也能正常关闭
with open("test.in","r") as fin:
	<语句集>
========================
以上相当于：
try:
	fin=open("test.in","r")
except:
	pass
else:
	<语句集>
finally:
	fin.close()
	
四.控制语句结构与函数
1.条件语句
if(<条件表达式>):
	<语句集>
elif(<条件表达式>):
	<语句集>
else:
	<语句集>
2.循环语句
for <iterator> in <序列>：
	<语句集>
while(<条件表达式>):
	<语句集>
*序列可以用range()构造，也可以直接是诸如[2.23,5j,3L,"haha"]
3.函数
def <函数名>(<形参表=默认值>):	#具名函数：调用时给出形参，此时实参顺序可以打乱
	<语句集>
	return<返回值>	#默认为None
	pass 			#空函数结束符
def var_params_func(*args, **kwargs):
	# 一般参数组成args元组，具名参数组成kwargs字典
	# var_params_func(1, 'A', what=-1, where=2.5)
	pass
def param_bind_func(a, b, c, x, y):
	# 实参强制解包
	# param_bind_func(*[1,2,3], **{'x':1, 'y':2})
	pass
4.闭包
def closure():	# a closure for function inc()
	hi = [0]	# MUST be a ref type
	def inc():
		hi[0] += 1
		print(hi[0])
	return inc	# return the function
inc = closure()	# unbox the function
inc()
inc()

五.异常处理
try:
	<语句集>
except <异常种类>:
	<解决方案1>
except (<异常种类>, <异常种类>):
	<解决方案2>
finally:
	<语句集>
*异常种类往往是系统给出的，试一个错误的值，看系统会返回什么错误信息

六.面向对象编程
1.类class
class 类名[(父类名)]:
	def __init__(参数表):
		//构造函数
	def __del__:
		//析构函数
	成员函数(self)	#无参函数形参表为self
	成员变量
	pass	#空类结束符
*访问成员使用点运算符.

七.图形化编程：
import graphics
win=GraphWin('标题',宽度,高度)	建立一个窗口类的对象win
win.close()	关闭win窗口对象
子对象.draw(win)	在win窗口中绘制一个子对象
pnt=Point(25,50)	点
	pnt.getX()
	pnt.getY()
	pnt.move(-20,10)	水平、上下移动
rect=Rectangle(Point(10,5),Point(20,10))	矩形，给出两个对角点
	rect.setFill('blue')
	rect.setOutline('red')
line=Line(Point(10,5),Point(20,10))	直线段
circ=Circle(Point(2,2),2)	圆，给出圆心和半径
oval=Oval(Point(20,30),Point(250,85))	椭圆
txt=Text(Point(100,50),'Hello here!')	文本
*交互：后缀名.pyw文件
pnt=p.getMouse()	鼠标单击位置，返回Point类型

import turtle
t=turtle.Pen()
	t.reset()		重置清空
	t.clear()
	t.up()			起落笔
	t.down()
    t.forward(50)	前进后退
	t.backward(50)
    t.left(90)		旋转
	t.right(45)
	t.color(0.5,0.5,0.5)	颜色
	t.begin_fill()	绘色控制
	t.end_fill()

from tkinter import *
	tk=Tk()		#创建窗口
	tk.update()
	对象.pack()	#整理并显示对象
	btn=Button(tk,text="Clike Me!",command=函数名)
	canvas=Canvas(tk,width=500,height=500)
		canvas.create_line(0,0,500,500)
		canvas.create_rectangle(10,10,70,70,fill=颜色)	#颜色用十六进制#ffffff表示
		canvas.create_arc(10,10,200,100,extent=180,style=ARC)
		canvas.create_polygon(1,1,2,2,3,3,4,4,...,fill="",outline="black")
		canvas.create_text(10,10,text="Hehe",fill="blue",font=("Helvetica",20))
		canvas.create_image(0,0,anchor=NW,image=PhotoImage(file="C:\\test.gif"))
		canvas.move(1,5,5)	#对象ID,x偏移,y偏移
		canvas.itemconfig(ObjectID,fill='blue',outline='black')

八.模块
1.sys
sys.exit()
sys.stdin.readline()
sys.stdout.write()
sys.version

2.time
time.time()
time.asctime()
time.localtime()
time.sleep()

3.re
p=re.compile('(http?://.*?)', re.IGNORECASE)
p.match().group()
p.search()
for i in p.findall("test.html"):	# finditer()
	print(i)
