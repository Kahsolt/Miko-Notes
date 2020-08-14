# GDB: GNU Project Debugger

0.gcc时加入符号表
	gcc -g
1.基本
帮助
	help <指令名>
退出
	q
载入文件
	file <文件名>
反汇编
	disassemble
运行
	r	开始运行
继续
	c	到下一个断点
断点
	b <行号>		设置断点
	  <函数名>
	  *<函数名>
	  *<代码地址>
	d <编号>		删除断点
源码逐行执行
	s	(stepi)此行有函数调用时跟踪进入
	n	(nexti)此行有函数调用则执行完毕返回
汇编逐指令执行
	si	此指令是函数调用则跟踪进入
	ni	此指令是函数调用则执行完毕返回
跳到函数完成
	finish
打印
	p <变量名称>
自动显示
	display ...				每次断点时自动显示
		例如：display /i $pc	以十六进制显示当前汇编指令
	undisplay <编号>
2.高级
查看寄存器
	i r				常用寄存器
	i r a			全部寄存器
	i r [寄存器名]	指定寄存器
修改寄存器
	set $v0 = 0x004000000
	set $epc = 0xbfc00000
查看内存
	x /[数量][格式] <地址>
	例如：
		x /wx 0x80040000    # 以16进制显示指定地址处的数据，长度为word=32bit
		x /8x $esp
		x /16x $esp+12
		x /16s 0x86468700   # 以字符串形式显示指定地址处的数据
		x /24i 0x8048a51    # 以指令形式显示指定地址处的数据（24条）
修改内存
	set {unsigned int}0x8048a51=0x0
	set *(unsigned int*)0x8048a54=0x55aa55aa
内存搜索
	define find                            
		set $ptr = $arg0
		set $cnt = 0
		while ( ($ptr<=$arg1) && ($cnt<$arg2) )
			if ( *(unsigned int *)$ptr == $arg3 )
				x /wx $ptr
				set $cnt = $cnt + 1
			end
			set $ptr = $ptr + 4
		end
	end