Rem VBScript是WSH语言中的一员
Rem 看起来就像解释性VB
'	注释也可以这样

零.基础
0.数据子类型：Variant的变体
	Empty		0/""
	Null
	Boolean		True/False
	Byte		整数1字节
	Integer		整数2字节
	Currency	浮点固定4位小数
	Long		整数4字节
	Single		浮点2字节
	Double		浮点4字节
	Date(Time)
	String
	Object
	Error		错误号
1.变量声明
	显式声明
		Option Explicit		强制显式声明，常写在脚本开头
		Dim X, Y			不能赋初值
		Public MyArray(50)		数组，从0到50实际可访问51个元素
		Private MyMatrix(10,10)	矩阵
		Dim MyList()			动态数组
		ReDim MyList(25)		之后设置维度
		ReDim Preserve MyList(30)	修改维度，并且保留已有内容
	隐式声明
		直接用
	赋值
		X=5
		Y=X+5
		MyArray(0)=Y*X
	常数
		Const MyString = "这是一个字符串。"
		Const MyAge = 49
		Const CutoffDate = #6-1-97#
2.运算
	^	乘方
	/	除
	Mod	模除
	\	整除
	&	字符串连接
	=	等于
	<>	不等于
	Is	对象引用比较
	Not/And/Or/Xor	四则逻辑
	Eqv	逻辑等价
	Imp	逻辑蕴含
3.控制语句
	条件
		If value = 0 Then
			MsgBox value
		ElseIf value = 1 Then
			MsgBox value
		Else
			Msgbox "数值超出范围！"
		End If
	选择
		Select Case Text
		   Case "MasterCard"
			  DisplayMCLogo
			  ValidateMCAccount
		   Case "Visa"
			  DisplayVisaLogo
			  ValidateVisaAccount
		   Case Else
			  DisplayUnknownImage
			  PromptAgain
		End Select
	循环直到True
		Do <条件逻辑式>
			循环体
			[Exit Do]
		Loop
		Do
			循环体
			[Exit Do]
		Loop <条件逻辑式>
	循环直到False
		While <条件逻辑式>
			循环体
			[Exit While]
		Wend
	重复
		For i = 2 To 10 Step 2
			循环体
		Next
	枚举器
		For Each anItem in aDictionary
			循环体
		Next
4.过程
	无返回值Sub
		Sub ConvertTemp()
		   temp = InputBox("请输入华氏温度。", 1)
		   MsgBox "温度为 " & Celsius(temp) & " 摄氏度。"
		End Sub
		ConvertTemp
		Call ConvertTemp()
		*Call MyProc(firstarg, secondarg)
		 MyProc firstarg, secondarg		'不用Call时强制省略括号
	带返回值Function
		Function Celsius(fDegrees)
			Celsius = (fDegrees - 32) * 5 / 9	'给函数名赋值为返回值
		End Function
		Temp = Celsius(fDegrees)
	
一.常用函数
1.输入输出
	InputBox(prompt[,title][,default][,xpos][,ypos][,helpfile,context])
	MsgBox(prompt[, buttons][, title][, helpfile, context])
2.类型判断
	IsArray(varname)
	IsDate(expression)
	IsEmpty(expression)
	IsNull(expression)
	IsNumeric(expression)
	IsObject(expression)	'是否引用了有效的 Automation 对象
	TypeName(varname)
	VarType(varname)		'返回一个数字枚举
3.格式化
	FormatCurrency(
		expression[,NumDigitsAfterDecimal [,IncludeLeadingDigit [,UseParensForNegativeNumbers [,GroupDigits]]]]
	) 
	FormatNumber(
		expression[,NumDigitsAfterDecimal [,IncludeLeadingDigit [,UseParensForNegativeNumbers [,GroupDigits]]]]
	)
	FormatPercent(
		expression[,NumDigitsAfterDecimal [,IncludeLeadingDigit [,UseParensForNegativeNumbers [,GroupDigits]]]]
	)
	FormatDateTime(
		date[, NamedFormat]
	)
4.类型转换
	Asc(string)
	Chr(charcode)
	CBool(expression)
	CByte(expression)
	CCur(expression)
	CDate(date)
	CDbl(expression)
	CInt(expression)
	CLng(expression)
	CSng(expression) 
	CStr(expression)
	Int(number)	'负数时，返回小于或等于 number 参数的第一个负整数
	Fix(number)	'负数时，返回大于或等于 number 参数的第一个负整数
5.数学
	Abs(number)
	Sgn(number)
	Sqr(number)
	Sin(number)
	Cos(number)
	Tan(number)
	Atn(number)
	Exp(number)
	Log(number)
	Rnd[(number)]
	[result = ]Eval(expression)
		例如：
		RndNum = Int((100) * Rnd(1) + 1)
		Guess = CInt(InputBox("Enter your guess:",,0))
		If Eval("Guess = RndNum") Then	'被解释为变量名
			MsgBox "祝贺你！猜对了！"
		Else
			Guess = CInt(InputBox("对不起，请再试一次",,0))
		End If
6.字符串操作
	Hex(number)
	Oct(number)
	Space(number)
	Round(expression[, numdecimalplaces])
	String(number, character)
	StrReverse(string1)
	Len(string | varname)
	LCase(string)
	UCase(string)
	Left(string, length)
	Mid(string, start[, length])
	Right(string, length)
	LTrim(string)
	RTrim(string)
	Trim(string)
	InStr([start, ]string1, string2[, compare])
	InStrRev(string1, string2[, start[, compare]])
	StrComp(string1, string2[, compare])
	Join(list[，delimiter])
	Split(expression[, delimiter[, count[, start]]])
	Filter(InputStrings, Value[, Include[, Compare]])
	Replace(expression, find, replacewith[, compare[, count[, start]]])
7.其他
	数组
		Array(arglist)
			Dim A
			A = Array(10,20,30)
			B = A(2)   ' B 现在为 30
		LBound(arrayname[, dimension])
		UBound(arrayname[, dimension])
	对象
		CreateObject(servername.typename [, location])
		Set object.eventname = GetRef(procname)
		GetObject([pathname] [, class])
	图像
		LoadPicture(picturename)
		RGB(red, green, blue)
	环境
		GetLocale()
		SetLocale(lcid)
