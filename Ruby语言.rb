#Ruby是一门脚本语言，可以说是Python、Perl的再改进

零.基础
1.编码方式-增加中文支持
脚本魔法注释
	#encoding:编码方式
		UTF-8	(默认)
		GBK
		GB2312
ruby编译
	ruby -E GBK 脚本文件
irb启动
	irb -E GBK
2.控制台参数
puts "#{ARGV[0]}"	#接收为字符串
3.库的包含引用
require "date.rb"	#可省略后缀名.rb
4.注释
#行注释用井号
=begin
 大段的文档注释
 用这两个括起来
=end
5.同行多语句
用分号;区隔
6.输入输出
gets	读取一行，含换行符
print	不带换行的标准输出
puts 	自带换行符，转义
p 		强制不转义，提示数据类型
pp		需引入pp.rb库，会智能换行
	name=gets
	puts "Hello #{name}!"	#用哈希符号#{}括起来的部分会作为表达式求值计算
	print "%02d,%02x" %[a, b]
7.调用系统命令行
system "ls /"
`ruby -version`	#取字符串结果

一.数据与变量
1.数据类型
整数Fixnum
	x=5
浮点数Float
	f=3.2
字符串String
	"双引号字符串\n被转义"
	'单引号字符串\n不转义'
	"".empty?	#判空
范围Range
    1..10
    -5...5
*类型转换
	.to_i
	.to_f
	.to_r	分数
	.to_s
	.to_c	复数
*多重赋值
	x,y,z=2,"53",9.6
	a,b,c,d=1,2,3		#d=nil
	a,b,c=1,2,3,4		#值4被抛弃
	a,*b,c=1,2,3,4		#b=[2,3]被封装
		*反封装：a,(b1,b2),c=[1,[2,3],4]
2.变量类型
LocalVar	局部变量	以小写字母或下划线_开头
$GlobalVar	全局变量	以$开头
@InstVar	实例变量	以@开头
@@ClassVar	类变量		以@@开头
			伪变量		nil/true/false/self	
Const_PI	常量		以大写字母开头，不可改值
3.相等判断
A==B		判断值相等，整数与浮点比较时会先自动转换为浮点
A.eql?(B)	判断值相等，不转换数据类型
A===B		
*用Obj.object_id可获得对象的唯一ID

二.控制语句
1.条件
正条件
	if 条件 [then]	#单行时then不可省略
		语句集
	elsif 条件 [then]
		语句集
	else
		语句集
	end
	*或：语句 if 条件
反条件
	unless 条件 [then]
		语句集
	else
		语句集
	end
	*或：语句 unless 条件
*nil或false为假，其余为真
2.选择
	case 判定变量名
		when 值1,值2,... then	#when的判据实际上是===运算
			语句集
		when 值3,... then
			语句集
		else
			语句集
	end
3.循环
对象遍历
	for 变量 in 对象 [do]
		语句集
	end
条件循环
	while 条件 do
		语句集
	end
	until 条件 do		#等价于while !(条件)
		语句集
	end
无限循环
	loop do
		语句集
	end
迭代器法
	循环次数.times do
		语句集
	end
	集合.each do |变量名|
		语句集
	end
*do...end可用{...}替换；多行时用前者，一行时用后者
*循环控制：
	break	退出
	next	跳到语句集结尾
	redo	跳到语句集开头

三.高级数据结构
1.数组Array
声明/索引
	letero=["\n",3.2,'G',7]
	letero[0]		#数组下标始于0
	letero.size		#取长度
each遍历
	letero.each do |n|
		puts n
	end
	*或写在一行：letero.each {|n| puts n}
2.散列Hash：键值对
声明/访问
	address={name:"Kahsolt",gender:"Puer"}
	*address={:name=>"Kahsolt",:gender=>"Puer"}		#或者
	address[:name]
	address[:number]=183729
each遍历
	letero.each do |key,value|
		puts "#{key}: #{value}"
	end
3.正则表达式
	/模式/=~希望匹配的字符串	#匹配成功返回位置，失败返回nil
		例：/Ruby/=~"There is no Ruby in text? 2333"
4.文件读写
只读
	text=File.read(filename)
	print text
单行读出
	file=File.open(filename)
	file.each_line do |line|
		puts line
	end
5.方法
定义：
	def 方法名(参数表[:默认值]...)		#普通方法显名函数适用
		语句集
		return 返回值		#默认以最后一个表达式的值为返回值
	end
	#带块方法
	def 方法名(*args)			#不定参数方法，args被封装为数组
		语句集
	end
调用：
	对象.方法名(参数1,参数2,...,参数n)		#一般方法，括号可省略
	对象.方法名(参数表...) do |变量表...|	#带块方法，用do...end时括号可省略
		块内容
	end
	对象.方法名(参数表...){|变量表...| 块内容}	#单行带块方法，括号不可省略(除非函数无参)
	
四.面向对象
1.类
class Dog
	def initialize(aName,aDescription)
		@Name=aName
		@Description=aDescription
	end
	def set_name(aName)
		@Name=aName
	end
	def get_name
		return @Name
	end
	def bark
		return 'Woof!'
	end
end
mydog=Dog.new
mydog.set_name('Fido')
puts mydog.get_name
puts mydog.bark

五.
	
