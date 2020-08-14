rem 命令提示符是在操作系统中，提示进行命令输入的一种工作提示符
rem 在Windows中32位命令解释器为cmd.exe程序

零.脚本基础
1.cmd.exe解释器
	/c|/k "cmd"	执行一个命令块后退出|进入交互模式
	/a|/u		管道的输出为ANSI|Unicode模式
	/t:fg		控制台颜色
	/e:on|off	命令扩展启用|关闭
2.命令路径&后缀
	path %PATH%;<path_new>			rem 本次会话改变
	setx PATH "%PATH%;<path_new>"	rem 永久改变
	echo %PATHEXT%	rem 查看默认的可执行文件扩展
3.文件关联
	assoc .pl=perlfile
	ftype perlfile=Perl.exe "%1" %*
4.重定向符号
	|		管道传递处理
	>/>>	正常输出重定向到文件，覆盖/追加模式
	2>		错误输出重定向
	<		输入重定向到文件
	<&/>&	从句柄输入/向句柄输出
			*标准输出的句柄：&1
5.命令组结链
	&		然后，顺序执行
	&&		且，成功则继续执行
	||		或，失败则继续执行
	()		并，合并为命令组、整合结果
6.脚本程序常用预处理
	rem <description>
	@echo off
	title <str>
	color <fg>
7.脚本参数
	%0		脚本自身的文件名
	%1-%9	前9个实际参数
	%*		所有参数
	shift	将参数表值逐个前移，第一个值被抛弃，以此能访问到第10个及以后的参数
	shift /i	从第三个参数(%2)处之后开始前移，即%3被抛弃
8.脚本变量
	set var=He llo	rem 默认处理为可含空格的字符串
	set /a num=2	rem /a指明了理解为数字
					rem 算术运算支持加减乘除模(%)，支持加等(+=)等等
	set x=			rem 删除变量
	echo %what%		rem %引用变量时要括起来%
	*换码符^：
		用于对@<>&|^等字符的转义
		当用于显示时要连用三个换码符，因为cmd会重复分析
			set sqt=2^^^&3=5
			echo %sqt%		rem 显示为"2&3=5"
	*常用的特殊变量：
		%errorlevel%
			0	正常执行
			1	常规错误
			2	执行错误，命令没有正确执行
			-2	算数错误
9.代码局部化
	setlocal
		rem 这里set的变量只在内部有效
	endlocal
10.控制语句
条件
	if [not] <逻辑条件> (命令组1) else (命令组2)
		*条件可以为
			x==str			rem 字面字符串比较
			"%x%"=="str"	rem 有变量参与时一般加引号以防止有空格
			equ|neq|lss|leq|gtr|geq
	if [not] errorlevel <错误等级> (命令组1) else (命令组2)
		*也可写成条件式：if [not] "%errorlevel%"=="<错误等级>" (命令组1) else (命令组2)
	if [not] defined <变量名> (命令组1) else (命令组2)
	if [not] exist <文件名> (命令组1) else (命令组2)
		*if exist a.txt del a.txt /f
	嵌套if:
	if <逻辑条件> (
		@if <逻辑条件> (命令组1) else (命令组2) 	rem 嵌套的if必须以@开头
	) else (命令组3)
迭代
	for <迭代变量> do (命令组)
		*迭代变量是局部性的，可以是%%A-%%Z和%%a-%%z且大小写敏感
	for %%var in (fileSet) do (命令组)				rem 迭代文件集合
		*for %%f in (*.txt C:\*.log) do rename %%f *.cmd
	for /D %%var in (directorySet) do (命令组)		rem 迭代目录集合
		*for /d %%d in (%SystemRoot%\*) do echo %%d
		*for /d %%d in (%SystemRoot%\*) do (	rem 嵌套for
			@for %%f in (%%d\*.txt) do echo %%f)
	for /R [path] %%var in (fileSet) do (命令组)	rem 自动递归子目录中的文件
		*for /r C:\ %%f in (*.txt) d echo %%f 
	for /L %%var in (start,step,end) do (命令组)		rem 迭代值序列
		*for /l %%x in (10,-2,0) do echo %%x
	for /F ["options"] in (source) do (命令组)		rem 迭代分析文本
选择
	choice /c 可选按键字母表 /M "选项提示信息表"
		*以errorlevel的数值返回选择项，选项的值从1开始编号
		*choice /c YN /M "Yes,No"
			if errorlevel 2 echo Refused！	rem 从编号大的开始处理比较好？
			if errorlevel 1 echo Accepted!
11.子程序
	:start
		rem 这里就是子程序
	goto start
	goto eof	rem 会自动跳到文件尾，然后退出
12.过程：即一个另外的脚本
	call <脚本名>	rem 会传递调用者的参数栈，只是把%0修改为调用者脚本
				  rem 过程完成后返回调用者脚本
一.基础命令
1.系统监视配置
	date
	time
	whoami
	where
	driverquery
	systeminfo
	shutdown
	tasklist|taskkill
	chkdsk
	defrag
	reg			注册表
	sc			服务服务
	net			关于网络的设置
	netsh		网络设置
	diskpart	磁盘分区
	fsutil		文件系统管理
	schtasks	任务计划
	getmac		
	mountvol
	nbtstat
	netstat
	pathping
	route
	runas 
	subst
	sfc 
2.基本命令字母表
	arp
	assoc
	attrib
	bcdedit
	call
	chdir|cd
	chkdsk
	chkntfs
	choice
	cipher
	clip
	cls
	cmd
	cmdkey
	comp
	compact
	convert
	copy
	date
	dcdiag
	dcgpofix
	defrag
	del|erase
	dir
	diskcomp
	diskcopy
	diskpart
	doskey
	driverquery
	dsmgmt
	echo
	endlocal
	exit
	expand
	fc
	find
	findstr
	for
	forfiles
	format
	ftype
	goto
	hostname
	icacls
	if
	ipconfig
	label
	mkdir|md
	more
	mountvol
	move
	nbtstat
	net|netsh
	netstat
	nslookup
	path
	pathping
	pause
	ping
	popd
	print
	prompt
	pushd
	rmdir|rd
	recover
	reg
	rem
	ren
	route
	runas
	sc
	set
	setlocal
	sfc
	shift
	shutdown
	sort
	start
	subst
	systeminfo
	takeown
	taskkill
	tasklist
	time
	timeout
	title
	tracerpt
	tracert
	type
	ver
	verify
	vol
	where
	whoami

附录：
　　winver---------检查Windows版本 
　　wmimgmt.msc----打开windows管理体系结构(WMI) 
　　wupdmgr--------windows更新程序 
　　wscript--------windows脚本宿主设置 
　　write----------写字板 
　　winmsd---------系统信息 
　　wiaacmgr-------扫描仪和照相机向导 
　　winchat--------XP自带局域网聊天
　　mem.exe--------显示内存使用情况 
　　Msconfig.exe---系统配置实用程序 
　　mplayer2-------简易widnows media player 
　　mspaint--------画图板 
　　mstsc----------远程桌面连接 
　　mplayer2-------媒体播放机 
　　magnify--------放大镜实用程序 
　　mmc------------打开控制台 
　　mobsync--------同步命令
　　dxdiag---------检查DirectX信息 
　　drwtsn32------ 系统医生 
　　devmgmt.msc--- 设备管理器 
　　dfrg.msc-------磁盘碎片整理程序 
　　diskmgmt.msc---磁盘管理实用程序 
　　dcomcnfg-------打开系统组件服务 
　　ddeshare-------打开DDE共享设置 
　　dvdplay--------DVD播放器
　　net stop messenger-----停止信使服务 
　　net start messenger----开始信使服务 
　　notepad--------打开记事本 
　　nslookup-------网络管理的工具向导 
　　ntbackup-------系统备份和还原 
　　narrator-------屏幕“讲述人” 
　　ntmsmgr.msc----移动存储管理器 
　　ntmsoprq.msc---移动存储管理员操作请求 
　　netstat -an----(TC)命令检查接口
　　syncapp--------创建一个公文包 
　　sysedit--------系统配置编辑器 
　　sigverif-------文件签名验证程序 
　　sndrec32-------录音机 
　　shrpubw--------创建共享文件夹 
　　secpol.msc-----本地安全策略 
　　syskey---------系统加密，一旦加密就不能解开，保护windowsxp系统的双重密码 
　　services.msc---本地服务设置 
　　Sndvol32-------音量控制程序 
　　sfc.exe--------系统文件检查器 
　　sfc /scannow---windows文件保护
　　tsshutdn-------60秒倒计时关机命令 
　　tourstart------xp简介（安装完成后出现的漫游xp程序） 
　　taskmgr--------任务管理器 
　　eventvwr-------事件查看器 
　　eudcedit-------造字程序 
　　explorer-------打开资源管理器 
　　packager-------对象包装程序 
　　perfmon.msc----计算机性能监测程序 
　　progman--------程序管理器 
　　regedit.exe----注册表 
　　rsop.msc-------组策略结果集 
　　regedt32-------注册表编辑器 
　　rononce -p ----15秒关机 
　　regsvr32 /u *.dll----停止dll文件运行 
　　regsvr32 /u zipfldr.dll------取消ZIP支持
　　cmd.exe--------CMD命令提示符 
　　chkdsk.exe-----Chkdsk磁盘检查 
　　certmgr.msc----证书管理实用程序 
　　calc-----------启动计算器 
　　charmap--------启动字符映射表 
　　cliconfg-------SQL SERVER 客户端网络实用程序 
　　Clipbrd--------剪贴板查看器 
　　conf-----------启动netmeeting 
　　compmgmt.msc---计算机管理 
　　cleanmgr-------垃圾整理 
　　ciadv.msc------索引服务程序 
　　osk------------打开屏幕键盘 
　　odbcad32-------ODBC数据源管理器 
　　oobe/msoobe /a----检查XP是否激活 
　　lusrmgr.msc----本机用户和组 
　　logoff---------注销命令 
　　iexpress-------木马捆绑工具，系统自带 
　　Nslookup-------IP地址侦测器 
　　fsmgmt.msc-----共享文件夹管理器 
　　utilman--------辅助工具管理器 
　　gpedit.msc-----组策略
