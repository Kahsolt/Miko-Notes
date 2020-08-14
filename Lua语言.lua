--Lua是一门脚本解释语言
--和Python与Ruby类似

零.基础
0.解释器参数
	-e	直接执行一行命令
	-i	运行脚本后进入交互模式
	-l	加载库文件，即dofile('test.lua')
	*lua -i -e "_PROMPT='lua>'"	--以自定义的提示符启动
	 lua [选项参数] [脚本名[参数]]
	 lua -e "sin=math.sin" script.lua a b
		参数数组：arg[-3]="lua" arg[2]="b"
		即，脚本名永远在索引0上
1.注释
--单行注释
--[=[多行
     可含零或多个等号=，用于层次嵌套区分
     注释，实际是doc-string]=]
2.输出
print('This is a '..x)		--连接符为..
=表达式		--交互模式中的快捷输出
3.引入
loadfile('test.lua')
loadstring('print("a")')	
4.异常
error('Err, no!')
assert(x, err)	--x为nil则调用error(err)
pcall(func)

一.数据
0.常量
'\x61'
'\72'
'\u{123}'	-- unicode
[[this is a multiline
 and prefomatted
 doc-string]]
[==[
   this is also
   只要等号个数相同
   123"]==]
1.变量
PI=3.14	声明伪常量，命名大写
x=5		声明为_ENV全局变量；也可不赋初值
local y	声明为局部变量，作用域为本函数
		*local x=x,声明一个局部x，赋值为全局x，可加快访问
*变量默认初值为nil
2.类型：动态类型(赋值时确认类型)
空值nil			*若变量被赋值为nil，则垃圾回收器会删除此变量
数值型number	必须含数字、小数点或e(E)	--Lua只有实数类型
布尔型boolean	true/false					--只有false和nil视为假，0和''也视为真
字符串string	s='单引号字符串'.."双引号字符串"		--连接用双点号..
				slen=string.len(s)		长度，或用#str取长度
				ssub=string.sub(s,1,-3)	子串
				ss=string.lower(s)
				sS=string.upper(s)
				s3=string.rep(s,3)		重复
				srvrs=string.reverse(s)	翻转
				startid,endid=string.find(s,"双引号")	查找
				string.format("%format",...)		格式化
					%s		字符串
					%q		带引号字符串
					%c		字符
					%d/i	整数
					%u		无符号整数
					%f		浮点数
					%G/g	紧凑浮点数
					%E/e	科学计数法
					%o		八进制
					%X/x	十六进制
				*类型转换：字符串进行数学运算时会自动转数字，即隐式调用tonumber()
				tostring(布尔/数值型)	转字符串，其他类型返回nil
				tonumber(字符串[,基数])	转数字，失败返回nil
自定义userdata
函数型function
	function 函数名(参数表)
		语句集
		[return 返回值1[,返回值2[,...]]]
	end
	function varParam(x, y, ...)
	   params = {...}
	   print(#params)
	end
	*嵌套函数
		function calc(opr,a,b)
			--子函数声明
			function add(a,b)	--嵌套函数
				return a+b
			end
			function sub(a,b)
				return a-b
			end
			--父函数体
			if opr=='+' then
				return add(a,b)
			else
				return sub(a,b)
			end
		end
		--调用时
		print(calc('+',5,7))
		print(calc('-',5,7))
	*返回函数：函数指针
		function add(a,b)
			return a+b
		end
		function sub(a,b)
			return a-b
		end
		function getOpr(opr)	--获取算子函数
			if opr=='+' then
				return add
			else
				return sub
			end
		end
		--调用时
		calc=getOpr('+')	--此处calc是函数指针
		print(calc(5,7))
		calc=getOpr('-')
		print(calc(5,7))
        *函数调用
	    p=function(x) print(x) end
	    p("Hello")	-- 单参数时可省去括号
	    p "this is ok"
	    p 'so is this'
	    p [[this is a long string]]
	    p {x=1;5,7,8}
线程型thread
表类型table	point={x=10,y=20,z=0.5}
			point={["x"]=10,["y"]=20,["z"]=0.5}		定义为字典
				print(point["x"])	--下标式访问
				print(point.y)		--字典式访问
				*p["x"]==p.x
			stuList={"A","B","C","D"}		定义为数组
				print(#stuList)				取length
				print(stuList[1])			取元素
			splitTable={x=10,y=20;"1","2","3"}	混合式，成分分段用分号;(可选)
			*简单链表实现
				list={}
				for line in io.lines() do
					list={value=line,link=list}
				end
			 链表打印
				local l=list
				while l do
					print(l.value)
					l=l.next
				end
*type()函数可返回对象类型
3.运算符
//	整除
;	分句
:	对象访问符
=	支持多重赋值
%	取余，符号与第二操作数相同
^	乘方
#	取字符串/表长度
~	异或/位非
~=	不等于
..	字符串连接
...	变长函数参数
{}	表生成器
and/or/not	逻辑联结词
	x=a or b		--若a空则赋值为b
	a and b or c	--类似于a?b:c，但要求b不为假
	(print or io.write)('done')

二.控制
1.条件分支
if 表达式1 then
	语句集1
elseif 表达式2 then
	语句集2
else
	语句集3
end
2.循环
while 表达式 do
	语句集
	[计数器变换]
end
或
repeat
	语句集
	[计数器变换]
until 表达式
或
for 计数器变量=初始值,终止值[,步长] do
	语句集
end
或
for i,v in pairs(a) do	--遍历table型用pairs，数组型用ipairs
	语句集
end
4.转移
::start::
-- do something here
goto start
*跳转控制
	break			循环中断
	return [返回值]	函数中断

三.库
0.basic raw
_G
_VERSION
collectgarbage([opt[,arg]])
    opt: "collect" "stop" "restart" "count" "step" "setpause" "setstepmul" "isrunning"
dofile([filename])
require(modname)
load(chunk[,chunkname[,mode[,env]]])
getmetatable(object)
next(table[,index])
pairs(t)
ipairs(t)
tonumber(e[,base])
tostring(v)
type(v)
print(···)
rawlen(string/table)
assert(v[, message])	-- v is not false
error(message[,level])
pcall(f [, arg1, ···])
xpcall(f,msgh[,arg1,···])
1.math
	math.huge
	math.pi
	math.mininteger
	math.maxinteger
	math.type (x)
	math.tointeger (x)
	math.modf (x)
	math.fmod (x, y)
	math.random()		[0,1)
	math.random(n)		[1,n]
	math.random(m,n)	[m,n]
	math.randomseed(os.time())
2.table
	table.insert(tablename,index,newvalue)
	table.remove(tablename,index)
	table.sort(tablename,sortfunc)	--sortfun默认为小于<
	table.concat()
	table.move (a1, f, e, t [,a2])
	table.pack (···)
	table.unpack (list [, i [, j]])
3.string
	string.byte(s [, i [, j]])
	string.char(ord_num)
	string.dump(function [, strip])	-- 编译后的函数
	string.len(s)	=> s:len()
	string.rep("str",times)
	string.reverse(s)
	string.lower(s)
	string.upper(s)
	string.sub(s[,i],j]])
	string.match(s,"%d-%d-%d")
	string.find(s,"target_str",start_index)
	string.gsub("src_str","pattern","replcement_str",max_replace_times)
		*由于第二返回值为被替换次数，因此统计'X'出现频率：
		_,cnt=string.gsub(str,'X','X')
	string.gmatch(s,"pattern")
		*模式pattern
			.	所有字符
			%a	字母
			%c	控制字符
			%d	数字
			%l	小写字母
			%p	标点符号
			%s	空白字符
			%u	大写字母
			%w	字母和数字
			%x	十六进制数字
			%z	内部表示为0的字符
				*大写字母表示其补集，元字转义符为%
			+	1-n次
			*	0-n次，尽可能多
			-	0-n次，尽可能少
			?	0-1次
			[-]	范围
			()	分段、优先级
4.utf8
	utf8.char(...)
	utf8.codes(s)
	utf8.len (s [, i [, j]])
	utf8.offset (s, n [, i])
5.io
	io.close ([file])
	io.flush ()
	io.input ([file])
	io.lines ([filename, ···])
	io.open (filename [, mode])
	io.output ([file])
	io.popen (prog [, mode])
	io.read (···)
	io.write (···)
	io.tmpfile ()
	io.type (obj)
	file:lines (···)
		for c in file:lines(1) do body end
	file:read (···)
	file:write (···)
	file:setvbuf (mode [, size])
	file:seek ([whence [, offset]])
	file:close ()
	file:flush ()
6.os
	os.clock ()
	os.date ([format [, time]])
	os.difftime (t2, t1)
	os.exit()
	os.execute()
	os.getenv (varname)
	os.remove (filename)
	os.rename (oldname, newname)
	os.time ([table])
	os.tmpname ()	
7.package
	package.config
	package.path
	package.cpath
	package.preload
	package.loaded
	package.loadlib (libname, funcname)
	package.searchers
	package.searchpath (name, path [, sep [, rep]])
8.debug
	debug.debug ()
	
四.协同程序coroutine
0.状态
	挂起Suspended-运行Running-死亡Dead-正常Normal
	coroutine.create (f)
	coroutine.isyieldable ()
	coroutine.resume (co [, val1, ···])
	coroutine.running ()
	coroutine.status (co)
	coroutine.wrap (f)
	coroutine.yield (···)
1.生命流程
	co=coroutine.create(function() print("Hi.") end)	--创建时Suspended
	print(co,coroutine.status(co))	--返回thread类型
	coroutine.resume(co)	--启动/再启动后Suspend->Running
	coroutine.yield()	--在协同过程函数体里用，让渡后暂停Running->Suspend
				--运行完毕则Running->Dead
2.实例：消费者驱动
producer=coroutine.create(
	function()
		while true do
		coroutine.yield(io.read())
		end
	end)
function consumer()
	local status,value=coroutine.resume(producer)
	return value
end
consumer()	--启动消费者来运行

五.元表与环境
1.元表
	Lua中每个值都有元表，lua语言只能设置table的元表：
	table和userdata的数据可以有独立元表，其他类型的数据共享本类的元表
2.用法：相当于运算符重载
Set={}
mt={}
function Set.new(s)
	local set={}
	setmetatable(set,mt)	--设置表set的元表为mt
	for _,v in ipairs(s) do set[v]=true end
	return set
end
function Set.union(a,b)
	local res=Set.new{}
	for k in pairs(a) do res[k]=true end
	for k in pairs(b) do res[k]=true end
	return res
end
mt.__add=Set.union
s1=Set.new(1,2,3)
s2=Set.new(1,3,5,7)
s3=s1+s2	//加运算+会转义为Set.union()
3.元表中可用的注册字段
算数
	__add|__sub|__mul|__div|__pow|__mod
	__unm	--相反数
	__concat	--连接
关系
	__eq|__lt|__le
访问
	__index|__newindex
4.环境
	_G	全局表

六.面向对象：用表类型模拟对象
Student={id=14211050,name="Kahsolt"}
function Student:toString()		--或者function Student.toString(self)
	return "Name:"..self.name.." id:"..self.id
end
function Student:create(o)
	o=o or {}				--无参时创建空表
	setmetatable(o,self)	--把self作为元表设置给o对象
	self.__index=self		--首先在当前对象中查找方法，没有则在原型Student中查找
	return o
end
print(Student:toString())
student2=Student:create({id=100,name="Hehe"})
print(student2:toString())
student3=Student:create({id=10086,name="Da~"})
print(student3:toString())
