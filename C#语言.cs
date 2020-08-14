///C#是微软公司发布的一种面向对象的、运行于.NET Framework之上的高级程序设计语言
///C#封闭了指针操作
///<summary>文档注释要写成XML形式</summary>


零.基本结构
1..NET FrameWork: Code Once, Run Anywhere.
Visual Studio.NET集成开发环境：
	通用语言开发环境
	.NET基础类库
	Data和XML
	Web Service/用户接口
	通用语言规范CLS：VB、C++、C#等
2.输入输出
Console.Read();
Console.ReadLine();
Console.Write();
Console.WriteLine("Case 1: {0} and {1}\n",a,b);
	占位符："{" n ["," width] ["" format [precision]] "}"
		n			参数序号(从0开始)
		width		初始域宽，正数右对齐|负数左对齐
		format		d十进制整数,f定点小数,n三位逗号分隔数字,e浮点科学计数,c货币,x八进制,g默认
		precision	精度，整数的总位数，浮点数的小数位数

3.程序结构
using Syetem;	//引入
namespace MyCSharpProgram	//命名空间：可包含多个类，或者子命名空间
{
	class HelloWorld		//类
	{
		//属性变量
		//方法工具函数
		static void Main(string[] args)	//程序入口，暗示此类为主类；参数args不含本文件名
		{
			//主函数
		}
	}
}
4.命令行编译
csc [/out:][/target:][/platform:] <C#源文件>
	/out:D:\CSharp\HelloWorld.exe			//输出文件名
	/target:[exe|winexe|library|module]		//生成控制台可执行文件|Windows可执行文件|类库|模块
	/platform:[anycpu|x86|x64|Italium]		//指定可运行平台

一.语法基础
0.标识符
*关键字不能作标识符，除非前导@符号，如@out/@for/@int
1.数据类型
整型
	sbyte/byte		0	System.SByte/System.Byte
	short/ushort	0	System.Int16/System.Uint16
	int/uint		0	System.Int32/System.Uint32
	long/ulong	0L/0UL	System.Int64/System.Uint64
	BigInteger			需引入System.Numerics
浮点型
	float	0.0F	System.Single
	double	0.0D	System.Double
	decimal	0.0M	System.Decimal
	Complex			需引入System.Numerics
布尔型	bool	false	System.Boolean
字符型	char	'\0'	System.Char
结构体	struct
枚举型	enum	枚举下表为0的元素
				enum Color : byte {Red=1, Blue=2, Green=4};
				Color mixColor = Color.Red | Color.Blue;	//位运算，mixColor是一组值
引用型	ref		null
隐形型	var		仅用于局部变量，作动态类型处理
				常用于foreach中迭代器声明
*运算符
typeof运算符
	Type type=typeof(类型)		//获取数据类型说明
typeof运算符
	sizeof(值类型/struct)		//获取数据类型大小，对struct要使用unsafe上下文
??运算符
	x=a??b;		//左值不为null则返回左值，否则返回右值
as	类型转换
	string str=someVar as string;	//把someVar转换为string型的str，失败时返回null
is	实例判断
	if(str is MyString)		//判断str是否为MyString或其派生类的实例对象
checked	判断溢出	//抛出OverflowException
	x=checked(x*x);
	checked{
		x=x*x;
		y=y*y*y*y*y;
	}
2.引用
ref关键字：变量引用
	public void Swap(ref int a,ref int b){a^=b;b^=a;a^=b;}
	int a=5,b=3;	//b必须赋初值
	Swap(ref a,ref b);
out关键字：函数传出
	public void Copy(ref int a,out int b){b=a;}
	int a=5,b;	//b不必赋初值
	Copy(ref a,out b);
params关键字：不定参数表
	public void setHobby(params string[] strArrHobby)
	{
		for(int i=0;i<strArrHobby.Length();i++)
			this.strArrHobbies.Add(strArrHobby[i]);
	}
	person.setHobby("He","Heh","Da~");	//传多个无定量参数
delegate关键字：函数委托
	class TestDelegate
    {
        delegate void OneDelegate();
        static void x(){Console.WriteLine("This is function x.");}
        static void y(){Console.WriteLine("This is function y.");}
        static void Main(string[] args)
        {
            OneDelegate oneDelegate = x;
            oneDelegate += y;
            oneDelegate();
        }
    }
指针：
	用法同C++，但只能在标记了unsafe关键字的语句块中使用
Nullable类型：可空类型
	int? someVar=null;
数组：一维[]、多维[,]、交错[][]
	int[] elmt;elmt=new int[100];	//等价于int[] elmt=new int[100];
	int[] nVar=new int[]{1,2,3,4};	//初始化式声明
	int[,] f=new int[100100];		//矩形多维数组
	
	int[][] JaggedArr=new int[3][];	//交错数组
	JaggedArr[0]=new int[1];
	JaggedArr[1]=new int[2];
	JaggedArr[2]=new int[3];
	int[][] JaggedArr=new int[][];	//交错数组初始化式声明
	{
		new int[]{1},
		new int[]{2,3},
		new int[]{4,5,6}
	};
类/接口
	class	C#只支持类的单继承
	interface	可理解为一个纯抽象类，没有类的基本函数，用public修饰而且可被一个类多继承
		如：public interface IShape
		{
			double getArea();	//仅定义不实现
			int Color;
		}
*其他内置引用类型
	object	System.Object
	String	System.String
3.变量：可以以@前缀注明
int @m=2;
char c;
string str;
*常量：[访问说明符] const double Pi=3.1415926;
	public		全局常量
	private		局部常量
	protected	受保护常量
	internal	可在同一个链接库中访问
	new			创建新常量，不继承父类同名常量
4.类型转换
隐式转换：支持向上转换
显式转换
	float i=(int)f;
装箱：值类型转引用
	int i=10;
	object o=i;
拆箱：引用转值类型
	object o=new object();
	int j=(int)o;
5.控制语句结构：和C语言完全一样
条件：if(){}else{}
	  switch(){case:default:}
	  *case分语句中可以用goto case 某个值;	//case的本质是个label
循环：while(){}
	  do{}while();
	  for(;;){}
	  foreach(in){}
*break,continue,goto	//goto的标签形式为label:
6.异常处理
try{}
catch(FileNotFoundException fnfex){}
catch(IOException ioex){}
catch(Exception e){}	//甚至可以省略“(Exception e)”
finally{}
7.条件编译
#define	建立一个预定义符号	
#undef	取消一个预定义符号
#if		如果某预定义符号存在
#elif
#else
#endif

二.面向对象
1.命名空间namespace
namespace MyEnv	//定义新名字空间
{
	代码段
}
using MyEnv;	//引用名字空间
2.类class
[类修饰符] class 类名 : 父类名, 接口名
{
	/*访问修饰符
	public		公有，允许外部访问
	private		私有，仅本类中成员访问
	protected	保护，子类也可访问
	internal	内部，同一个命名空间中的类可访问
	*/
	
	//属性
	//方法
	public override 方法名(){}	//重写基类的方法
	public new 方法名(){}	//隐藏基类的方法
}
类修饰符：
	abstract	抽象类，不能实例化，只能作为基类被继承
	internal	只能从同一个程序集的其他类中访问
	extern
	new			嵌套的类
	private		私有嵌套类，只能在定义它的类中访问这个类
	protected	保护嵌套类，只能在定义它的类及该类的子类中访问这个类
	public		可被任意类访问
	sealed		不能被继承
	virtual		虚函数
	override	覆盖
	static		静态
3.特殊函数
构造函数
析构函数
4.域和属性
public class School
{
	//域即成员变量，可用new/public/protected/internal/static/readonly修饰
	public string name;
	internal int studentcount;
	readonly static double PI=3.1415926;
	
	//构析函数
	public School(){}
	~School(){}
	
	//属性封装，由get、set关键字声明
	public int StudentCount
	{
		get
		{return studentcount;}
		set
		{if(StudentCount!=value)StudentCount=value;}	//固定词value
	}
}
5.操作符重载
重载运算符+
public class Complex
{
	public double real{get;set;}
	public double img{get;set;}
	...
	public static Complex operator+(Complex c1,Complex c2)	//注意是static函数
	{
		return new Complex(c1.real+c2.real,c1.img+c2.img);
	}
}
重载索引[]
class MonthlySales {
	int[] apples = new int[12];
	int[] bananas = new int[12];
	...
	public int this[int i] {	// set method omitted => read-only
		get { return apples[i-1] + bananas[i-1]; }
	}

	public int this[string month] {  	// overloaded read-only indexer
		get {
			switch (month) {
				case "Jan": return apples[0] + bananas[0];
				case "Feb": return apples[1] + bananas[1];
				...
			}
		}
	}
}
MonthlySales sales = new MonthlySales();
Console.WriteLine(sales[1] + sales["Feb"]);
重载逻辑符号
class TriState {
	int state;  // -1 == false, +1 == true, 0 == undecided
	public TriState(int s) { state = s; }
	public static bool operator true (TriState x) { return x.state > 0; }
	public static bool operator false (TriState x) { return x.state < 0; }
	public static TriState operator & (TriState x, TriState y) {
		if (x.state > 0 && y.state > 0) return new TriState(1);
		else if (x.state < 0 || y.state < 0) return new TriState(-1);
		else return new TriState(0);
	}
	public static TriState operator | (TriState x, TriState y) {
		if (x.state > 0 || y.state > 0) return new TriState(1);
		else if (x.state < 0 && y.state < 0) return new TriState(-1);
		else return new TriState(0);
	}
}
6.代理delegate

