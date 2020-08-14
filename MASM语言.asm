;汇编语言是助记符化的机器语言
;包括汇编指令集、伪指令集以及使用规则
;这里关于Windows上的MASM汇编器

零.基础
1.80x86系列CPU的寄存器：
	*此处以16位CPU为例；32位比16位多5个32位控制寄存器、8个调试寄存器、2个测试寄存器，但都是系统使用对程序员透明
	数据寄存器：可拆分高低两个8位寄存器
		AX	累加器		常用于运算，一些指令规定了必须使用它
		BX	基址寄存器	一段内存的起始偏移地址
		CX	计数寄存器	重复操作的次数
		DX	数据寄存器	32位数据的高16位
	地址寄存器
		SP	堆栈指针		堆栈栈顶指针
		BP	基址指针		内存中数据的偏移地址
		SI	源变址寄存器	内存中源数据区的偏移地址
		DI	目的变址寄存器	内存中目标数据区的偏移地址
	段寄存器：在32位CPU中也是16位
		CS	代码段寄存器	当前正在执行的程序段基址
		SS	堆栈段寄存器	堆栈段基址
		DS	数据段寄存器	数据段基址
		ES	附加段寄存器	另一个数据段基址
		FS				32位CPU中有，类似于ES
		GS				32位CPU中有，类似于ES
	指令指针寄存器
		IP	指令指针寄存器	即将执行指令的偏移地址
	标志寄存器
		FLAGS	存放CPU两类标志
			状态标志：每次运算后自动产生
				位名	意义		标志为1	标志为0	置为1的意义
				OF	溢出		OV		NV		两个有符号数运算溢出
				DF	方向		DN		UP		源或目的地址指针用加法自动修改
				IF	中断		EI		DI		允许处理器响应中断请求
				SF	符号		NG		PL		运算结果最高位为1
				ZF	零		ZR		NZ		运算结果为0
				AF	辅助进位	AC		NA		两个BCD数运算时第3位上的进位
				PF	奇偶		PE		PO		运算结果低8位中有偶数个1
				CF	进位		CY		NC		两个无符号数加法有进位、或减法有借位
			控制标志：由指令设置
				TF	单步/陷阱
2.存储器
	实模式：20位地址线寻址1M内存
		20位物理地址=>16位段地址+16位偏移地址
			物理地址=段地址*16+偏移地址		;相当于段地址左移4位bit(段地址必定能被16整除)，左移1位十六进制数码hex
			逻辑地址即写作[段地址:偏移地址]
		*段地址确定后则一段内存的开始地址就决定了，两个极端情况：
			1.段大小为64kB，1MB内存分为16个段，段地址为[0000H,F000H;1000H]，段内偏移地址为[0000H,FFFFH;0001H]
			2.段大小为16Byte，1MB内存分为65536个段，段地址为[0000H,FFFFH;0001H]，段内偏移地址为[0000H,000FH;0001H]
			*例如：段地址为82260H，假定段长度为64kB，则段地址范围为[8226H:0000H]-[8226H:FFFFH]，物理地址是82260H-9225FH
	存储器分配：一种可能的分配情况
		00000	系统区
				用户数据区	DS
				用户程序区	CS
		A0000	系统显存区
				系统区
		FFF00   ROM区(BIOS)
		FFFFF
	常用寻址组合：
		[CS:IP]				    CODE段：指向下一条即将运行的指令地址
		[DS:指令中的偏移地址]	DATA段：指向要取得值的内存地址
		[BP|BX:SI|DI]		    指向数据区的地址
		[SS:SP]                 STACK段：栈顶指针
3.寻址方式
	立即寻址
	寄存器寻址
	直接寻址
	寄存器间接寻址
	寄存器相对寻址
	基址变址寻址
	相对基址变址寻址
4.CPU对内存读写
	读
		CPU|地址线=>	|内存
			<=数据线
			控制线=>
	写
		CPU|地址线=>	|内存
			数据线=>
			控制线=>
5.INT 21H中断：DOS适用
	AH值	功能				入口参数					出口参数
	01	键盘读入字符有回显							AL=输入字符
	02	显示输出字符		DL=输出字符
	07	键盘读入字符无回显							AL=输入字符
	09	显示字符串		DS:DX=串地址
						串以‘$’结束
	0A	键盘输出到缓冲区	DS:DX=缓冲区首地址		(DS:DX+1)=实际字节数
						(DS:DX)=缓冲区字节数		(DS:DX+2)=输入的串地址
						DS:DX=数据区区首地址
	40	写文件/设备		BX=文件代号				AX=错误码(成功=0)
						CX=写入字节数
	4C	程序结束			AL=返回码

二.汇编程序
0.MASM汇编器
	EDIT hello
	MASM hello
	LINK hello
	DEBUG hello.exe
1.结构：
【MASM实例1】
CODE    SEGEMENT		;SEGMENT和ENDS中间所包含的为代码段，段名为CODE
        ASSUME CS:CODE	;说明语句，指定CODE段和CS寄存器关联
START:  MOV AH,1		;START为标号，MOV一句把功能号1(代表键盘输入)送入AH
        INT 21H			;调用中断，(执行功能号1，读入的字符存入AL)
        MOV DL,AL
        ADD DL,1		;读入的字符ASCII码加1
        MOV AH,2		;功能号2(代表显示DL中的字符)送入AH
        INT 21H			;调用中断，(执行功能号2)
        MOV AH,4CH		;功能号4CH(代表程序结束)送入AH
        INT 21H			;调用中断，(执行功能号4CH)
CODE    ENDS
        END     START	;汇编结束，启动地址为标号START的那条指令
【MASM实例2】
DATA	SEGMENT
	string	DB 'Hello, world!$'	;名为string的字符串，$是串结束标志
DATA	ENDS
CODE	SEGMENT
	ASSUME	CS:CODE,DS:DATA
START:	MOV AX,DATA
	MOV DS,AX
	MOV DX,OFFSET string
	MOV AH,9	;9号功能，屏幕显示[DS:DX]处的字符串
	INT 21H
	MOV AH,4CH
	INT 21H
CODE	ENDS
	END	START
【MASM实例3】
DATA	SEGMENT
	x DW	4
	Y DW	2
	z DW	20
	v DW	24
DATA	ENDS
CODE	SEGMENT
	ASSUME	CS:CODE,DS:DATA
CODE	ENDS
START:	MOV AX,DATA
	MOV DS,AX
	MOV AX,X
	IMUL y		;x*y
	MOV CX,AX
	MOV BX,DX
	MOV AX,z
	CWD		;Expand z
	ADD CX,AX
	ADC BX,DX
	SUB CX,16
	SBB BX,0
	CWD		;Expand v
	SUB AX,CX	;v-(x*y)
	SBB DX,BX
	IDIV X
	MOV AH,4CH
	INT 21H
CODE	ENDS
	END START

三.指令系统
1.数据传送指令
	通用数据传送
		MOV DST,SRC		;DST和SRC等长，不能同为存储器，DST不能为CS或IP
			MOV BYTE PTR[BX],0
			MOV WORD PTR[BX],0	;加类型符以说明0是字节还是字
		PUSH SRC	;DST由[SS:SP]默认给定，SP-2以存入字SRC
		POP DST		;SRC由[SS:SP]默认给定，弹出字DST并SP+2
		XCHG OPR1,OPR2
	累加器专用数据传送
		IN AL|AX,PORT|DX	;DST只能是AL或AX，SRC只能是PORT(仅限端口号00-FFH时，否则先将端口号存入DX再用IN AX,DX读入)或DX(存着一个字长的端口号)
		OUT PORT|DX,AL|AX
		XLAT	;即MOV AL,(BX+AL)
	地址传送
		LEA	REG,SRC		;LEA BX,TABLE等效于MOV BX,OFFSET TABLE，偏移量OFFSET可理解为取地址
		LDS	REG,SRC		;等效于REG<-(SRC) DS<-(SRC+2)
		LES	REG,SRC		;等效于REG<-(SRC) ES<-(SRC+2)
	标志寄存器传送
		LAHF	;AH<-FLAGS低字节
		SAHF	;FLAGS低字节<-AH
		PUSHF	;栈顶<-FLAGS低字节
		POPF	;FLAGS低字节<-栈顶
2.算术运算指令
	类型扩展
		CBW		;符号扩展，AL扩展成AX
		CWD		;符号扩展，AX扩展成DX+AX
	加法
		ADD DST,SRC
		ADC DST,SRC
		INC	OPR			;此指令不影响进位标志CF	
	减法
		SUB DST,SRC		;(DST)<-(DST)-(SRC)
		SBB DST,SRC
		DEC OPR			;此指令不影响进位标志CF	
		NEG OPR			;求相反数；OPR=0时CF=0否则为CF=1
		CMP OPR1,OPR2	;不送回结果，只改变标志位
	乘法
		MUL SRC			;SRC为字节时	(AX)<-(AL)*(SRC)；
						;SRC为字时	(DX,AX)<-(AX)*(SRC)
		IMUL SRC
	除法
		DIV SRC			;SRC为字节时	商(AL)<-(AX)/(SRC)，余数(AH)<-(AX)/(SRC)
						;SRC为字时	商(AX)<-(DX,AX)/(SRC)，余数(DX)<-(DX,AX)/(SRC)
		IDIV SRC
	BCD码(8421码)调整
		(略)
3.逻辑与位移
	逻辑
		AND DST,SRC
		OR DST,SRC
		NOT OPR
		XOR DST,SRC
		TEST OPR1,OPR2	;与操作，不保存而仅设置标志位
	移位
		SHL|SAL OPR,CNT	;CNT为1或CL寄存器
		SHR OPR,CNT		;逻辑右移，补0
		SAR OPR,CNT		;算术右移，补最高位
		ROL OPR,CNT		;循环左移
		ROR OPR,CNT
		RCL OPR,CNT		;带进位循环左移
		RCR OPR,CNT
4.串操作
	MOVS
	CMPS
	SCAS
	STOS
	LODS
5.程序转移
	JMP
	JZ|JE|JNZ|JNE|JS|JNS|JO|JNO|JC|JB|JNAE|JNC|JNB|JAE|JP|JPE|JNP|JPO
	JCXZ
	JC|JB|JNAE...
	LOOP|LOOPZ|LOOPE|LOOPNZ|LOOPNE
	CALL DST
	RET EXP
	INT|IRET
6.处理器控制
	CLC|CMC|STC
	CLD|STD
	CLI|STI
	NOP
	HLT
	WAIT
	LOCK

四.伪指令
0.处理机选择
1.段定义
	段名	SEGMENT
		;这里是段内容
	段名	ENDS
2.程序开始结束
	[label]:
		;这里是主程序
		END [label]
3.数据定义与存储器单元分配
	[变量]	伪操作码	N个操作数	[;注释]
	*伪操作码可以为：
		DB|BYTE		字节		8bit
		DW|WORD		字		16bit
		DD|DWORD	双字		32bit
		DF|FWORD	6个字节	48bit
		DQ|QWORD	四字		64bit
		DT|TBYTE	10个字节	80bit
4.类型属性操作符
	BYTE PRT	;字节类型
	WORD PRT	;字类型
5.THIS操作符和LABEL伪操作
	THIS <BYTE|WORD>
	name LABEL <BYTE|WORD>
	*使得该操作数的地址与下一个存储单元地址相同，例子：
		BUF=THIS WORD
		DAT DB 8,9			;BUF和DAT指向同一个地址，BUF为字、DAT为字节
		OPR_B LABEL BYTE
		OPR_W DW 4 DUP(2)	;OPR_B和OPR_W指向同一个地址,OPR_W为字、OPR_B为字节
6.表达式赋值
	Expression_name EQU Expression
	Expression_name = Expression
	*类似于宏常量，例如
		VALUE EQU 4
		DATA = VALUE + 5
		ADDR EQU [BP+VALUE]
7.汇编地址计数器$与定位伪指令
	地址计数器$
	ORG伪操作
	EVEN伪操作
	ALIGN伪操作
8.基数控制
	.RADIX expression	;可取2~16间任何数作基底，其余进制的数需加基底后缀
9.过程定义
	过程名 PROC	[NEAR|FAR]
		;这里是过程体
	过程名 ENDS

五.语句格式
0.语句
	[name] operation operand [;comment]
1.操作符
	算术
		+|-|*|/|MOD
	逻辑
		AND|OR|NOT|XOR
		SHL|SHR
	关系
		EQ|NE|LT|GT|LE|GE
			*真返回FFFFH，假返回0
	数值回送
		TYPE expression
			*expr类型		返回值
				变量			变量大小的字节数
				标号			NEAR=>-1;FAR=>-2
				常数			0
		LENGTH variable
			*var若是用DUP产生的则返回总变量数，否则返回1
		SIZE variable
			*var若是用DUP产生的则返回总字节数，否则返回单变量字节数
		OFFSET variable|label
			*返回变量或标号的偏移地址
		SEG variable|label
			*返回变量或标号的段地址

