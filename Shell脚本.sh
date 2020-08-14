#Linux脚本是在操作系统中，进行命令输入的终端
:'在Linux中命令解释器为bash/sh/tcsh等程序
  查帮助用 <command> --help 或者 man <command>'

特别.Shell编程
0.解释器咒语
	#!/bin/bash
1.变量赋值
	a="hello"		#等号两边无空格
	echo "A is: " $a
	num=2
	echo "You are the ${num}nd"	#用{}括起来重整优先级
2.运算
字符串运算(默认)
	var=1
	var=$var+1
	echo $var	#输出11
数学运算
	let "var+=1"	#let表示数学运算
	var=$[$var+1]	#方括号内作为数学表达式计算输出
	var=expr $var + 1	#加号两边必须有空格，expr表示整数运算
3.控制流
条件
	if [ 条件 ] ;then
	elif [ 条件 ] ;then
	else
	fi
	*条件
	[ -f "somefile" ] ：判断是否是一个文件 
	[ -x "/bin/ls" ] ：判断/bin/ls是否存在并有可执行权限 
	[ -n "$var" ] ：判断$var变量是否有值 
	[ "$a" = "$b" ] ：判断$a和$b是否相等 
逻辑
	布尔式&&语句	//布尔为真则执行语句
	布尔式||语句	//布尔为假则执行语句
分支
	case expr in
	"pattern1")
		cmd1;;
	"pattern2")
		cmd2;;
	*)
		cmd3;;
	esac
选择
	echo "make a choice:"
	select var in “A” “B” "C"
	do	break; 	done	#跳出select循环
	echo "you chosed $var"
循环
	while expr1
	do
		commands
	done
	for var in list		#list为若干空格分割字符串
	do
		commands
	done
3.Here Document
cat << HELP
ren — renames a number of files using sed regular expressions USAGE: ren ‘regexp’ ‘replacement’ files…
EXAMPLE: rename all *.HTM files in *.html:
ren ‘HTM$’ ‘html’ *.HTM
HELP
4.函数
函数名()
{
	# 传入参数为$1,$2...
	# 函数体
}
*函数调用：直接使用不带括号的名字

零.Shell
0.Sehll
	sh -x	#调试模式运行
1.字符串界符
	"双引号中转义符有效"
	'单引号中转义符无效'
	`反引号中内容被可视为shell命令而执行`
2.组合命令界符
	cmd1;cmd2;cmd3		连续启动多个命令
	cmd1&&cmd2&&cmd3	等待上一个成功完成
	cmd1||cmd2||cmd3	等待上一个完成
3.花括号扩展
	{A,BB,CCC,DDDD}	依次用每一项去展开执行一个命令
4.Shell控制
	jobs 显示所有任务
	bg|fg %jobnumber	把某个job转至后台|前台
	&	作为命令后缀，指定在后台运行
	^Z	挂起前台任务
	suspend	暂停shell本身
5.软件包
	*.deb	Debian封装包
	*.rpm	RPM封装包
	*.tar.gz|*.tar.z|*.tar.bz2	压缩的tar文件
	
一.文件操作
1.ls
	-a	包括隐藏文件
	-l	长格式(含文件属性)
		-k	使用友好的数据大小单位，而不是默认的byte
	-s	前缀文件所占块数
		*按文件大小排序：ls -s | sort -n
	-R	递归显示目录
2.cp
	-p	同时复制访问权限、时间戳、所属组、拥有者
	-a|-r	递归复制目录树时，保留|不保留文件属性
	-f|-i	强制覆盖|覆盖前询问
3.mv
	-f|-i	强制覆盖|覆盖前询问
4.rm
	-r	递归删除
	-f|-i	强制覆盖|覆盖前询问
	
二.目录操作
1.pwd
2.cd
	.	本目录
	..	父目录
	~	用户主目录
3.mkdir
	-p	递归创建多级新目录
4.rmdir
	-p	递归删除

三.显示文件
1.cat
	-n	前缀行号
	-b	非空行前缀行号
	-s	压缩连续空行
2.less
	-c	显示下一页前先清屏
	-m	显示详情百分比等
	-N	显示行号
	-r	显示控制字符，不转义
	-s	压缩连续空行
3.echo
	
四.文件属性
1.touch	快速创建文件/修改时间戳
2.stat	显示文件/文件系统重要属性
	-f	显示文件系统，而非文件本身
3.wc	统计文本字节词行数
	-c|-w|-l	只显示字节|词|行数
4.du	统计文件/文件系统所占磁盘块数
	-b|-k|-m	以Byte|KB|MB计量，而非块数
	-h	自动选择合适单位
5.file	报告文件类型
	-i	以MIME类型输出
	-b	省略文件名打印
	-z	探查压缩文件内容
	
五.文件位置
1.find	在目录树中查找文件
	-name + 路径
2.locate	创建文件索引以查找文件
	-u	从根目录开始建立索引
	-i	不区分大小写
3.which/type	搜索路径找一个可执行文件
4.whereis	从一组固定的目录中找文件(可执行文件-b|源-s|manpage-m)
	-f	给定目录列表
	*例如：whereis -B dirs... -f file.txt

六.文件文本操作
1.grep	打印文件中符合给定的正则表达式的行
	-v	打印不符合的行
	-c	打印匹配行总数
	-i	不区分大小写
	-w|-x	匹配完整的词|行
2.tr	字符转换
	*tr charset1 [charset2]
	-d	删除字符，同义于替换为空字符/空格
3.sort
	-f	大小写不敏感
	-n	以数字顺序(10大于9)而非索引序
	-c	检查是否已经有序
	-b	忽略行首空格
	-r	降序排列
4.uniq	重复行处理
	-i	大小写不敏感
	-c	统计相邻重复行
5.tee	将标准输入复制到标准输出及文件中
	-a	附加到文件
	-i	忽略错误中断
	
七.文件压缩打包
1.tar
	*tar -参数 目标文件名 源文件(夹)
	-c	创建存档
	-f	指定目标文件
	-z|-j	用gzip|bzip2压缩
	-v	输出详细
	-t	显示内容(列出存档)
	-x	提取文件

八.文件比较
1.comm	比较两个有序文件
	*产生三栏输出：file1独有行|file2独有行|共有的行
	-1|-2|-3	省略第1|2|3栏
2.diff	逐行比较两个文件或目录
	-q	不报告详细，只显示是否区别
	-b|-B	不考虑空格|空行
	-i	忽略大小写
	-r	递归子目录

九.磁盘管理&文件系统
1.df	磁盘或分区大小使用情况
	-h|-H	设定显示以2^10|10^3为基数
	-l	只显示本地文件系统
2.mount	挂载磁盘
	-l	显示已挂载的文件系统
	-r	以只读式挂载
3.umount	卸载磁盘
	-a	卸载所有
4.fsck	分区检查修复
	-A	检查所有
	-r|-a	交互|自动修复错误
5.sync	所有磁盘缓存数据写回磁盘
	
十.进程操作
1.ps	查看进程
	-ux	查看当前用户的进程
	-C [program]	查看指定程序名引发的进程
	-efH	缩排显示层次关系
2.uptime	显示自上次启动以来系统运行的时间
	*返回四个字段：当前时间；系统运行时间；当前登录用户数；平均负载(1min,5min,15min)
3.w	每个已登录用户的每个shell的当前进程
4.top	监视最活跃进程，自动更新显示
	-nN	更新N次后退出
	-dN	每N秒更新一次
	-pN	只显示PID为N的进程(最多复用20次)
	-c	显示进程参数命令行
	-b	只写入标准输出而不进行屏幕控制(脚本中常用)
5.free	内存使用情况
	-s N	连续运行，每N秒更新
	-b|-m	以byte|MB为单位(默认是KB)
	-t	显示总统计
6.kill	终止进程
	-KILL|-9	强制结束
	`pidof 进程名`	用pidof反查找到pid
7.nice	以特定优先级启动程序
	-数字	默认为设置为10级；通常进程为0级，数值越小越优先
8.renice	更改优先级
	+数字|-数值	增加减少多少级
	-p PID	指定进程PID
	-u username	影响指定用户的所有进程
	
十一.任务调度
1.sleep	系统休眠一段时间
	*后接数字，默认单位为秒，单位后缀用s|m|h|d
2.watch	以固定时间间隔重复运行指定命令
	-n 数字	指定时间间隔，默认为2秒
	-d	高亮显示与上次不同的输出信息

十二.登录注销关机
1.shutdown
	-r|-h|-k	重启|关机|假关机
	-c	取消
	-f|-F	重启时跳过|强制进程fsck
	时间	+N(N分钟后)|16:25(绝对时间)|now(立刻)

十三.用户及环境
1.logname
2.whoami
3.who
4.users
5.finger
	-l|-s	长格式|精简格式
6.last
	-N	最近N行记录
7.printenv

十四.用户账号管理
1.useradd
2.userdel
3.passwd
4.usermod
5.chfn
6.su
	-l 	运行login shell
	-m	新的shell中继承当前环境变量

十五.用户组管理
1.groups
2.groupadd
3.groupdel
4.groupmod

十六.主机信息及操作
1.uname
	-a	 详细
2.hostname
	-i	主机IP地址
	-f	完整主机名
	-d	DNS域名
	-y	NIS或YP域名
3.ip
	addr	显示网络设备的IP地址
	addr show	显示已启动的网络接口
	route	显示路由表
	monitor	开启监控网络设备
4.host	主机信息
	-a	 详细
5.whois
6.ping	发送ICMP包
	-c N	N次后停止
	-i N	N秒为间隔(默认1秒)
	-n	输出中打印IP地址而非主机名
7.ssh	远程登录
	-l	指定登录用户名，默认用当前本地账号
	*也可用 ssh usrname@host的形式

十七.屏幕输出&时间日期
1.echo
	-n	行尾不打印换行符
	-e|-E	解释|不解释转义字符
2.printf	格式化打印，基本同C语言
3.yes	不断地打印指定字符串(默认为"yes")
4.clear
5.date
6.cal
	-y	整年
	-3	当前加前后，共三个月
	-j	显示在年中的天数，而非在月中的
7.ksnapshot
