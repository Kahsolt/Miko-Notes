//用于Arduino开发板的C语言，一说是Processing语言
//Arduino C是ANSI C的一个子集

零.Arduino Uno/Nano
0.硬件
	处理器		ATmega328
		*中断向量表，每个中断2字节
		0x0000	RESET
		0x0002	INT0~1		外部中断
		0x0006	PCINT0~2	引脚变化中断
		0x000C	WDT			看门狗定时器
		0x000E	TIMERx		三个定时器/计数器相关
		0x0022	SPI			SPI串行传输完成
		0x0024	USART		USART接收/清空/发射
		0x002A	ADC			模数转换完成
		0x002C	EE_READY	EEPROM准备完成
		0x002E	ANA_COMP	模拟比较器
		0x0030	TWI			两线接口IIC事件
		0x0032	SPM_READY	自定义事件
		*状态寄存器SREG的位定义：用BSET/BCLR指令来修改
		0	C	进位
		1	Z	零
		2	N	负数
		3	V	溢出
		4	S	符号:=N^V=>1&&N&V=>0
		5	H	半进位
		6	T	测试位
		7	I	全局中断允许
		*AVR指令集
		ATmega328	131条
			算数和逻辑	ADD、AND等
			跳转		JMP等
			数据传输	MOVx、LDx、LPM、STx、IN/OUT
			位操作		SBR/CBR、SBI/CBI
			系统控制	SLEEP/WDR/NOP
	Flash		32KB	=硬盘，放程序，擦写次数有限
	SRAM		2KB		=内存，放数据，断电丢失
	EEPROM		1KB		=CMOS，放配置，比Flash耐擦写
	IO引脚		D14+AI6，默认输入
		*总线最大电流200mA，而建议管脚最大出入电流40mA
		D0~D13	端口D+端口B=>PD0~PD7+PB0~PB5
			RX	D0
			TX	D1
			PWM	D3/D5/D6/D9/D10/D11	可伪模拟输出
			LED	D13
		A0~A5	端口C=>PC0~PC5	
			*=D14~D19	仅模拟输入
	Reset引脚	低电平触发
	USART		串口
	时钟频率	4MHz	1.8V
				10MHz	2.7V
				20MHz	4.5V
	定时器/计数器
		0号	8位		通过配置寄存器TCNT0直接读写，产生PWM-D5/D6
		1号	16位	带输入捕获单元，产生PWM-D9/D10
		2号	8位		可异步运行，产生PWM-D11/D3
1.编译
	avr-gcc					编译代码
	Arduino标准库+avr-lib	链接库
	binutil+avr-gcc			产生可执行映像，并格式化为Intel的HEX文件格式
	avrdude					上传HEX文件至开发板
	*AVR工具目录：<安装目录>/hardware/tools/avr
	*手工编译C：
		#include<avr/io.h>
		avr-gcc -mmcu=atmega328p src.c -o src.o
		avr-objcopy -O ihex src.o src.hex
		avrdude -p atmega328p -c stk500v1 -P \\.\COM1 -U flash:w:src.hex:i
			-p 芯片型号
			-c 与Arduino引导装载程序的协议
			-P 串口号，win下若COMx中x不为单数字则必须前缀"\\.\"
			-U 内存编程指令-所用内存区域(flash存储器):操作(w=写):文件名(.hex):文件格式(i=Intel HEX)
	*输出详细：
		Arduino的配置文件preferrence.txt中添加build.verbose=true
2.C语言智商化
	并口
		D	0~7
		B	8~13
		C	A0~A5
	寄存器：p取D/B/C
		DDRp	0	输入
				1	输出
		PORTp	0	LOW		内部电阻上拉状态
				1	HIGH
		PINp	0			读取的外部引脚状态(只读)
				1	
		*对应关系
			0 0 x	输入，高阻态，PINp不确定，无拉
			0 1 1	输入，正常，上拉
			1 0 0	输出，0，无拉
			1 1 1	输出，1，无拉
		*set
			PORTA |= (1<<n);
		 clear
		 	PORTA &= ~（1<<n);
		#define BitGet(Number,pos) ((Number) >> (pos)&1)) //用宏得到某数的某位
		#define BitGet(Number,pos) ((Number) |= 1<<(pos)) //把某位置1
		#define BitGet(Number,pos) ((Number) &= ~(1<<(pos)) //把某位置0
		#define BitGet(Number,pos) ((Number) ^= 1<<(pos)) //把Number的POS位取反
	pinMode()设置
		bitSet(DDRB,5);	//D13=PB5(端口B,位5)，设为输出
		*或者展开宏bitSet()为DDRB|=1<<5;	//DDRB在avr/io.h中
	pinMode()翻转
		bitSet(PINB,5);	//将PINx对应位置1，翻转D13的INPUT/OUTPUT
	delay()延时
		extern volatile unsigned long timer0_millis;	//定义在wiring.c中,TIMER0的中断函数会使得这个变量递增
		while(timer0_millis<1000);	//等1秒
		timer0_millis=0;	//重置定时器，这会使标准的millis()失效
	Serial简化：发送单字节数据时
		usart_init() {
			#define BAUD_RATE 9600
			#define BAUD_RATE_DIVISOR (F_CPU/16/BAUD_RATE-1)
			UBRR0=BAUD_RATE_DIVISOR;
			//其余位会由编译器自动填0
			UCSR0A=0;	//设备当前状态
			UCSR0B=1<<TXEN0;	//数据发送位
			UCSR0C=1<<UCSZ01|1<<UCSZ00;	
		}
		void usart_putc(char c) {
			/*等待当前设备状态UCSR0A中数据寄存器空位UDRE0置1*/
			loop_until_bit_is_set(UCSR0A,UDRE0);	//或展开宏定义为while(bitRead(UCSR0A,UDRE0));
			UDR0=c;	//单字节字符c存入数据寄存器UDR0以发送
		}
		void usart_puts(char *s) {
			while(*s) {
				usart_putc(*s);	//usart_putc(*(s++));
				s++;
			}
		}
		void usart_puti(long i) {
			char s[25];
			itoa(i,s,10);//把以10为基底的整数i转化为字符串s
			usart_puts(s);
		}
		void setup() {
			/*Test*/
			usart_putc('!');
			usart_puts("Hello, World!")
		}
	节约SRAM
		*avr-size工具：告知一个程序启动时会用多少SRAM
			avr-size -C --mmcu=atmega328p src.cpp.elf
		#include <avr/pgmspace.h>
		const PROGMEM int longarr[] = {};
		或者宏F()	F("This string is stored in flash.")
3.降低功耗
	降频：不影响串口
		void setup() {
			noInterrupts();//=cli();
			CLKPR=1<<CLKPCE;	//CLKPCE置1，启动时钟预分频写入过程
			CLKPR=8;	//CLKPR寄存器设置时钟分频比为2^8=256，可以为0-8对应分频比1-256，现在频率为基频16MHz/256=62.5kHz
			interrupts();//=sei();
			//等效于<avr/power.h>中的clock_prescale_set(x)函数
			//参数x取值为clock_div_i,i取1,2,4,8...256
		}
	睡眠
		#include<arv/sleep.h>
		extern volatile unsigned long timer0_millis;
		void setup() {
			pinMode(13,OUTPUT);
		}
		void loop() {
			while(timer0_millis<1000) {
				set_sleep_mode(SLEEP_MODE_IDLE); //设置为轻度睡眠模式
				sleep_mode();	//开始睡眠
			}
			timer0_millis=0;	//重置计数器
			bitSet(PINB,5);	//翻转pinMode
		}

二.Arduino语言：数据
1.常量
HIGH|LOW
INPUT|OUTPUT|INPUT_PULLUP
LED_BUILTIN
2.变量
boolean
char	//1字节
byte=unsigned char
int		//2字节
word=unsigned int
long	//4字节
float=double
string		//ASCII字符串，空结尾
array
	int arr[]={1,2,3,4,5};//arr[0]==1
*类型转换
	char()	byte()	int()
	word()	long()	float()
3.修饰符
const
static
volatile
4.工具
sizeof()
PROGMEM	内存管理，大量静态数据建议存入Flash Memory而非SRAM
	#include <avr/pgmspace.h>
	const PROGMEM int longarr[] = {};

*结构：String字符串类
构造
	String(val[,base])	//构造基底为base值为val的数字的字符串表示
	String(val[,dotpos])	//构造小数位数为dotpos的浮点数val的字符串表示
		String stringOne = "Constant String";    
		String stringOne = String('Constant String');  
属性
	length()
转换
	c_str()	//转换为char*
	toCharArray(buffer,len)	//转换为char[]
	toInt()
	toFloat()
	toLowerCase()
	ToUpperCase()
操作
	charAt()
	setCharAt()
	concat()
	remove()
	replace()
	substring()
	trim()
	getBytes(buf,len)	//拷贝长度len进buf
判断
	startsWith()
	endsWith()
	indexOf()
	lastIndexOf()
	equals()
	equalsIgnoreCase()
	compareTo()

三.Arduino语言：控制
1.程序结构
//全局区域
void setup(){
	//按下reset按钮时运行一次
}
void loop(){
	//之后一直运行
}
2.Basic IO
	pinMode(pin,INPUT|OUTPUT)
Digital
	digitalWrite(pin,LOW|HIGH)
	digitalRead(pin)
Ananlog
	analogReference(type)	//设定模拟电压峰值
		DEFAULT		5V on Uno
		INTERNAL	1.1V on ATmega168/328
		EXTERNAL	//使用AREF针脚的电压
	analogRead(pin)		//ret=>[0,1203]
	analogWrite(pin,val)	//对标有~的数字口，val=[0,255]
3.Advanced IO
	tone(pin,frequency[,duration]) //输出方波，frequency=[31,65535],duration=ms，依赖计时器timer2(D3,D11的PWM失效)
	noTone(pin)	//一个时刻只能有一个针脚输出方波
	shiftOut()	
	shiftIn()
	pulseIn(pin,value[,timeout]) //在数字pin上等待信号val，返回信号持续的时间
4.Timer
	millis()	//毫秒，约50天循环
	micros()	//微妙，约70分钟循环
	delay()
	delayMicroseconds()
5.Math
	min(x,y)/max(x,y)/abs(x)
	sin()/cos()/tan()
	pow(x,n)/sqrt(x)	//para=>double,ret=>double
	constrain(x,a,b)	//将x限制于[a,b]之间，超出则返回上下限
	map(value,fromLow,fromHigh,toLow,toHigh)	//重映射区间
		int val = analogRead(0);
		val = map(val, 0, 1023, 0, 255);	//[0,1023]压缩为[0,255]
		analogWrite(9, val);
	randomSeed(seed)	//seed=>long/int
	random([min,]max)	//ret=>long
6.Characters
	isAlphaNumeric()
	isAlpha()
	isDigit()
	isAscii()
	isUpperCase()
	isLowerCase()
	isPunct()	//标点
	isSpace()
	isWhitespace()
	isControl()
	isGraph()=isPrintable()	//可打印
	isHexadecimalDigit()	//十六进制
7.Bits & Bytes
	lowByte()		//返回任意数字数据的最低字节
	highByte()		//最高
	bitRead(x,n)	//读x的二进制右起第n位，ret=>{0,1}
	bitWrite(x,n,b)	//写为b，b=>{0,1}
	bitSet(x,n)		//置为1
	bitClear(x,n)	//置为0
	bit(n)			//计算第n个比特的权重，即2^n
8.Interrupts
	attachInterrupt(digitalPinToInterrupt(pin), ISR, mode)	//pin=>{2,3} on Uno，ISR为中断函数名
		mode取以下枚举值：
			LOW		低电平中断
			CHANGE	有变化就中断
			RISING	上升沿中断
			FALLING	下降沿中断
	detachInterrupt(pin)	//取消中断绑定
	interrupts()			//开启中断，=sei()
	noInterrupts()			//禁止中断，=cli()
9.Communication
Serial
	begin()
	available()	//可用字节数，可缓存128个字节
	read()		//读一个字节,读失败返回-1
	flush()		//清空串口
	print(data[,format])/println(data[,format])
		format取以下枚举值：
			DEC/HEX/OCT/BIN/BYTE
	parseInt()
Stream
	
