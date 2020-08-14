#Windows PowerShell是基于C#的脚本语言
#完全兼容Command命令行，大小写不敏感
<#多行注释这样写#>

零.基础
1.环境
powershell		#命令行环境
powershell_ise	#集成开发环境
	启动参数：
		-Command <"cmdlet">
			脚本块：<"&{cmdlet1;cmdlet2;cmdlet3...}">
		-ExecutionPolicy
		-File <脚本路径>
		-Nointeractive
		-NoExit
		-Sta|-Mta		#单线程|多线程
		-WindowStyle	#窗口风格-最大最小隐藏正常
*脚本运行用 ./脚本名 或 .\脚本名
*断行符为反引号`
环境变量
	$PSVersionTable

2.cmdlet结构：动词-名词
动词表：Get-Verb
	Add/Clear
	ConvertFrom/ConvertTo
	Disable/Enable
	Export/Import
	Get
	Invoke
	New/Remove
	Set
	Start/Stop
	Test
	Write
3.常用cmdlet
	Show-Command
	Get-Help <cmdlet> [-Online]
		*或用封装版函数Help，或其别名Man
		Help <cmd> -full|-example
	Update-Help
	Get-Command	#查看全部命令
	Get-Alias	#查看命令别名
	Get-
		ExecutionPolicy	#脚本运行策略
		Location		#当前工作路径
		PSProvider
		PSDrive
		Host
		Process
		Counter
		Service
		Date
		Variable
		HotFix
	-Host
		Read
		Write
		Clear
	-Computer
		Stop
		Restart
	Test-Connection
	-Item|-ChildItem|-ItemProperty	#文件系统操作/注册表
		Clear-
		Copy-
		Get-
		Move-
		Invoke-
		New-
		Remove-
		Rename-
		Set-
4.常用通用参数和降低风险参数
	-Confirm
	-Debug
	-ErrorAction/-WarningAction
	-ErrorVariable/-WarningVariable
	-Verbose
5.逻辑控制
选择分支
	If(){}
	Elseif(){}
	Else{}
多项分支
	Switch()
	{
		value1{}	#匹配执行语句集后，自动跳出Switch块
		value2{}
		....
		default{}
	}
循环
	For(;;){}
	Foreach(in){}
	While(){}
	Do{} While()
	Do{} Until()


一.数据、变量
1.运算
数与字符串的结合律
	12.5+"2.5" => 15
	"12.5"+2.5 => 12.52.5
	12.5*"2.5" => 31.25
	"12.5"*2.5 => 12.512.5
	12.5-"2.5" or "12.5"-2.5 => 10
	12.5/"2.5" or "12.5"/2.5 => 5
类型转换
	[int]2.5
	[double]5
	[string]12.5
	[ref]$var
	[Hashtable]$dict
字符串转义
	'It is $(2+3)'	#不被计算
	"It is $(2+3)"	#被计算
	"This str ""has"" double quota"
	"`$myVar is $myVar"	#反引号防止被计算
	`		#反引号-转义符，相当于其他语言中的\
多行字符串
	引号前后再加上@
通配符
	[a to z]等价于[A to Z]
	[a-c]等价于[A-C]
	[abc]等价于[ABC]
	[0-9]
数据单位
	1TB/50GB => 20.48
	*支持KB、MB、GB、TB、PB
计算运算符
	%		#求模
	++/--	#自增自减
	&		#调用脚本块、命令、函数
	$()		#组合多条用分号;分割的语句
	@()		#组合多条用分号;分割的语句，结果返回一个数组
比较运算符：replace以外都返回布尔值
	$a -eq/-ne $b
	$a -lt/-gt $b
	$a -le/-ge $b	#大小写敏感比较使用-c*如-clt/-ceq，反之用-i*如-igt
	$a -contains/-notcontains $b
	$a -like/-notlike $b	#通配符?/*/[]/[-]有效
	$a -match/-notmatch $b	#正则表达式有效
	$a -replace $b,$c		#若$a中出现$b则用$c替换
字符串运算符
	+	#连接
	*	#重复
	-Join
		-Join("A","B","C")	#直接连接
		"A","B","C" -Join "-"
	-Split
		-Split "123 456 789"	#按空格分隔
		"123|456|789" -Split "|"
	-f	#格式化
		'{2} {0} {1}' -f "A","B","C"
		'{0} {2}' -f "A","B","C"	#忽略"B"
		'{0:f4}' -f [Math]::Pi	#浮点到固定精度，小数位数
		'{0:e3}' -f [Math]::Pi	#科学计数法，小数位数
		'{0:n2}' -f 1GB			#3位逗号分隔，小数位数
		'{0:p2}' -f .25			#百分数，小数位数
逻辑运算符
	-and
	-or
	-xor
	-not/!
类型运算符
	-is/-isnot	#类型判等
	-as			#类型转换
2.变量$
一般变量
	$x = 5 + 2.7
	$cmd = "Get-Process"	#此时用&$cmd可运行此令牌
	$proc = Get-Process	  #保存了一次查询结果
	$cmdpara = {Get-EventLog -newest 25 -logname application}	#带参数则用大括号命令块而非引号
构造数组
	$array = 1,2,3,4,7	    #用逗号,分割元素
	$array2 = @(1, 2, 3, 4, 5)	#强制转数组符号@()
	$range = 5..25		#用双点号..构造序列
	$seq = @(13; "String"; Get-Process)	#用分号分隔的话，元素会被优先作为命令执行然后保存结果
	访问
	$array[3, -3]           #下标选择
	$range[-2..5]           #切片
	$range[0, 1, 3+15-20]   #复合型访问
	运算
	$array += 35
	$array.SetValue(value,index)
	Remove-Item variable:array
	严格类型
	[int32[]]$intArray
	[bool[]]$boolArray
	[string[]]$stringArray
	[object[]]$objectArray
	多维数组：最多17维
	$myMatrix = New-Object 'object[,]' 4,3
	$myMatrix[1, 3] = "Heheda"
构造哈希
	$Dict = @{}
	$Dict.Name = "kahsolt"
	$Dict.Age = 13
	$d = @{"Name"="ks"; "Age"=13}	# 一步构造
	$d["Name"]
变量相关cmdlet
	Get-Variable
	New-Variable
	Set-Variable
	Remove-Variable	#删除变量
	Clear-Variable	#值清空
自动变量
	$$		#最后一个令牌（最后一行中的最后一个令牌）
	$?    #最后一个令牌的执行状态
	$^    #最后一行中的第一个令牌
	$_    #管道对象中的当前对象
	$Args
	$Profile
	$Home
  $Host
  $PID
	$PWD
3.函数
	function 函数名 {语句集}
	function 函数名
	{
		param ($参数,$参数...)
		语句集
	}
		例：function ss {param ($status) Get-Service | where {$_.status -eq $status}}
	function 函数名		#扩展的函数
	{
		param ($参数,$参数...)
		Begin{语句集}
		Process{语句集}
		End{语句集}
	}
	例如：
	function Swap([ref] $a, [ref] $b) {
	  $tmp = $a.Value
	  $a.Value = $b.Value
	  $b.Value = $tmp
	}
	Swap ([ref]$x) ([ref]$y)
		
二.写入写出格式化
1.格式化：用在管道后处理一个输出
	Format-List
	Format-Table
	Format-Wide
	Group-Object
	Sort-Object
2.写出到标准
	Write-Host [-BackgroudColor color][-ForegroudColor color][-NoNewLine][-Separator object][[-Object] object]
	Write-Output	#用在管道后强制输出
	Write-Debug [-Message] message
	Write-Error
	Write-Warning
3.写出
	Out-File
	Out-GridView	#非常有用！
	Out-Host
	Out-Null
	Out-Printer
	Out-String
4.重定向符
	|	管道
	>	文件覆盖
	>>	文件追加
	2>	错误输出的文件覆盖
	2>>	错误输出的文件追加
	2>&1如果有错误，输出到标准输出
		#例: PS C:\>tree C: > DiskC.txt 2>&1

三.常用管理
	Get-WMIObject
	Get-Acl
	Set-Location HKLM
	-Service
	-Process
	-Counter
	-EventLog
	-Computer
