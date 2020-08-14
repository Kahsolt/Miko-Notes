Rem VB是微软公司发布的一种面向对象的、运行于.NET Framework之上的高级程序设计语言
Rem 注释用rem，续行符为空格加下划线 _，一行多语句分隔符为冒号:
'这也是注释

一.基础
1.变量定义
Dim|Public|Private|Static 变量名 [As 数据类型]	Rem 默认为变体Variant型
*定义长n的字符串
	Dim str As String * n
*定义结构体：
	[Public|Private] Type 结构体名
		变量名 As 类型
		...
	End Type
2.逻辑连接词
=	等于
<>	不等于
And|Or|Not
3.输出输出框
输入框	InputBox(提示,标题,缺省值,X坐标,Y坐标,帮助文件)
消息框	MsgBox(提示,按钮形式,标题,帮助文件)

二.控制结构
1.If条件
If 条件1 Then
	语句1
Else If 条件2 Then
	语句2
Else
	语句3
End If
2.IIF函数
IIF(表达式,true返回值,false返回值)
3.Case分支
Select Case 表达式
	Case 表达式表1
		语句组1
	Case 表达式表2
		语句组2
	Case Else
		语句组3
End Select
4.For循环
For 计数器=初值 To 终值 [Step 步长]
	循环体
	[Exit For]	Rem 即Break
Next 计数器名	Rem单层循环可省略计数器名
5.While循环
While 表达式
	循环体
End While
6.Do循环
Do {While|Until} 表达式
	循环体
	[Exit Do]
Loop
Do
	循环体
	[Exit Do]
Loop {While|Until} 表达式

三.高级结构
1.函数Function
[Public|Private][Static] Function 函数名 ([形参表 As 类型]) As 返回类型
	函数体
	函数名=返回值
	[Exit Function]
End Function
2.子过程Sub
[Public|Private][Static] Sub 过程名 ([形参表 As 类型])
	过程体
	[Exit Sub]
End Sub
*调用Sub
	1.Call 过程名([实参表])
	2.过程名 [实参表]	Rem 没有括号！
3.数组
{Dim|Public|Private} 数组名(维度数) [As 类型]
*维度数表达方式
	1.下界 To 上界[,下界 To 上界]
	2.仅给出上界(默认下界为0)->可存上界+1个元素