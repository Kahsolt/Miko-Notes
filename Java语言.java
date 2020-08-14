//Java语言是一个解释型语言，长得很像C家族
//Program Once, Run Anywhere

零.基础
1.JDK目录
	bin		开发所需工具，如javac.exe、java.exe
	demo	开发工具包自带演示程序
	db		嵌入式数据库Derby开发所需资源及案例
	include	用于编译本地方法的C++头文件
	jre		Java运行环境
	lib		类库文件集
	sample	自带示例程序
	src.zip	类库API的源代码文件
*环境变量设置：将\bin目录引入系统的%Path%变量中
javac HelloWorld.java		编译命令产生.class文件
java HelloWorld				运行命令，不加.class后缀
2.注释
//单行注释
/*区域注释*/
/**文档注释*/
3.输入输出
import java.util.Scanner;
Scanner input=new Scanner(System.in);
i=input.nextInt();
System.out.println(i);
4.简单结构示例
/**Add.java*/
import java.util.Scanner;	//引入包package(一个)和类库import(多个)
public class Add	//主类名须与文件名相同
{
    public static void main(String args[])	//主方法，程序入口
    {
        Scanner input=new Scanner(System.in);
        int a=input.nextInt();
        int b=input.nextInt();
        System.out.println(a+b);
    }
}
*程序=运行代码+类代码
 代码=包+引入+主类+其他类+接口
	类=属性+方法(构造+工具)
	
一.变量与赋值
0.常量		true
			false
			null
1.整型		byte	1字节	初值0
			short	2字节	初值0
			int		4字节	初值0
			long	8字节	初值0L	后缀L/l
				十进制		无前缀
				八进制		前缀0
				十六进制	前缀x0/X0
2.浮点型	float	4字节	初值0.0f	后缀F/f
			double	8字节	初值0.0d	后缀D/d
				指数表示	介标E/e
3.字符型	char	2字节	初值'\u0000'	//使用Unicode编码
4.布尔型	boolean	1字节	初值false
5.数组		String 	不限	初值null	//+号作字符串连接
			int Array[];		//声明时不指定大小，等价于int[] Array;
			Array=new int[5];	//创建时指定大小
			char charArray[]=new char[5];	//声明时创建，要指定大小
6.类类型	class
7.接口类型	interface
*强制类型转换
(int)d、(float)f等
*类型判断
表达式(对象 instanceof 类/接口)为true或false

二.控制语句
1.选择判断
if(){}else{}
switch(){}
2.循环
for(;;){}
while(){}
do{}while();
*控制
break [<label>];	//从label处跳出
continue [<label>];	//从label处继续
<label>:			//设定label
3.断言
assert <逻辑表达式>;					//失败时会抛出AssertionError
assert <逻辑表达式>:<提示信息>;
*关闭断言编译：加参数-source 1.3	//因为JRE1.3还不支持断言
 执行时启动断言代码：加参数-ea/-enableassertions
4.异常处理
抛出	throw new someException("神秘的东方错误...","#9985");
处理	try{}
		catch(){}	//try和finally之间可以有多个catch
		finally{}

三.面向对象
1.类class=属性+方法(构造+工具)
[修饰符] class 类名 [extends 父类名] [implements 接口名]	//类仅可单继承，接口可多继承
{
	//属性
	//构造
	//工具方法
	public static void main(String args[]){}	//主方法
}
类的修饰符
	public		公有，可跨类跨包访问
	protect		保护，可被该类和子类对象访问
	private		私有，仅被该类对象访问
	default		不加访问修饰符，仅同包访问
	abstract	抽象，不可实例化
	final		最终，不能被继承 
	static		静态
类属性方法的修饰符
	public		公有，可跨类跨包访问
	protected	保护，可被该类和子类对象访问
	private		私有，仅被该类对象访问
	abstract	抽象，此方法应该在某子类中实现
	final		最终，常量、不能覆盖可被重载
	static		静态，可用类名直接调用
*内部类：定义在其他类内部的类
	成员内部类：可在外部类外被定义和使用
		new 外部类构造().new 内部类构造();
		new 外部类名.new 内部类构造();	//外部类为静态时
		外部类实例.new 内部类构造();
	方法内部类：仅在该方法内被定义和使用
*匿名类：创建对象后不保存至任何变量中
	new 类构造();
*抽象类：不可实例化，仅作被继承的父类使用
*属于类的成员变量可由系统初始化值
 属于方法的局部变量必须自己赋初值
*重载：方法名相同参数表不同，可共存
 覆盖：方法名相同参数表相同，子类中的方法将替代父类的
*this	指称本类成员
 super	指称父类成员
2.对象声明
类名 对象名;			//声明
对象名=new 类构造();	//创建
类名 对象名=new 类构造();	//声明时创建
*对象的析构清理由垃圾回收器自行决定
 System.gc()和Runtime.getRuntime()将发送清理消息给回收器，但并不立刻执行清理
3.接口interface
<访问限制修饰符> [abstract] interface 接口名 [extends 父接口名]	//abstract关键字可省略，系统会默认为abstract型
{
	//常量成员变量，可省略public static final修饰符
	//工具方法声明，可省略public abstract修饰符
}
*不可实例化，但可以声明为引用(类似指针)
 People stu=new Student();	//此处Student类实现了People接口

四.Java类库
1.Object类
toString()	//System.out.println()默认输出toString()返回值
equals()	比较两个实例的内容，一般的==仅判断引用指向是否同一
hashCode()
2.数据类型类
toString()/toBinaryString()/toOctalString()/toHexString()
xxxValue()			封装类中提取值
parseXxx(String)	字符串转数值
parseXxx(String,int)字符串转int进制数值
3.集合框架
ArrayList
LinkedList
Vector
Map
Hashtable

五.字符串处理
1.String类
	Length()
	startsWith(String)
	endsWith(String)
	indexOf(char/String)
	indexOf(char/String,int)	从id之后开始找
	lastIndexOf(char/String)
	lastIndexOf(char/String,int)	从id之后开始找
	equals(Object)
	equalsIgnoreCase(String)
	compareTo(String)
	concat(String)		连接至尾
	replace(char,char)
	toLowerCase()
	toUpperCase()
2.StringBuffer类
	capacity()
	setLength(int)
	length()
	append(Object/String/StringBuffer)
	insert(int,Object/String)
	delete(int,int)
	deleteCharAt(int)
	setCharAt(int)
	replace(int,int String)
	toString()
3.StringTokenizer类
	StringTokenizer(String,String)	为str构造一个字符串分析器，以字符串delim中每个字符为分隔符
	nextToken()
	hasMoreTokens()
	countTokens()
4.格式化文本
	DateFormat类
	NumberFormat类
5.正则表达式
	[]		字符范围或列表
	?		单字符通配
	*		多字符通配
	\t\n\r\f\a\e	控制字符：制表、换行、回车、换页、警告、转义
	^		非
	\d \D	数值字符，大写则取反
	\s \S	空白字符
	\w \W	单词字符，等价于[a-zA-Z0-9_]
	\b \B	字边界
	\A		输入开始
	\z		输入结束
	^$		输入的开始和结束位置
	X?		字符X可选
	X*		字符X有0个或多个
	X+		字符X有1个或多个
	X(n) X(n,) X(x,m)	n个X、至少n个X、n-m个X
	XY		X中的任意字符后接Y中任意字符
	X|Y		X或Y中任何字符
	
六.图形化Swing
0.引用库
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
1.Color类颜色构造器
	Color(DT r,DT g,DT b)
	Color(DT r,DT g,DT b,DT a)	//DT为float[0,1)或int[0,225]
2.Timer类计时器
	Timer(int delay,ActionListener listener)
	isRunning()
	start()/stop()/restart()
	setDelay(int)/getDelay()		//单位为毫秒ms
	setInitalDelay(int)/getInitalDelay()
	addActionlistener(ActionListener)/removeActionlistener(ActionListener)
3.面板与容器
	JFrame类
		setSize(int,int)
		setVisible(boolean)
		setBounds(int,int,int,int)	//位置和宽高
		setDefaultCloseOperation(enum)
			参数：	EXIT_ON_CLOSE			退出
					DISPOSE_ON_CLOSE		释放JFrame，继续运行
					DO_NOTHING_ON_CLOSE		不操作
					HIDE_ON_CLOSE			对话框关闭，继续运行
	JDialog类
		JDialog(JFrame,String,boolean)	//true为响应模式
		setTitle(String)/getTitle()
		setSize(int,int)
		setVisible(boolean)
		setModal(boolean)
	JPanel类
	JButton类
		JButton(void/String/Icon/String,Icon)
		addActionlistener()
		actionPerformed(ActionEvent)
	JTextField类
		JTextField(Document,String,int)
		setText(String)/getText()
	JPasswordField类
		JPasswordField(Document,String,int)
	JTextArea类
		JTextArea(Document,String,int,int)
		setText()/getText()
		insert(String,int)
		append(String)
		replaceRange(String,int,int)
		textValueChanged(TextListener)
	JLabel类
		JLabel(String/Icon,int)
		setText()/getText()
		setBackground()/setForeground()
		setFont()
	JRadioButton类/JCheckBox类
		JRadioButton(String,Icon,bool)
		itemStateChanged(ItemEvent)
	JComboBox类
		JComboBox(ComboBoxModel/Object[]/Vector)
		setEditable(boolean)
		addItem(Object)
		insertItemAt(Object,int)
		removeItem(Object)
		removeItemAt(int)
		removAllItems()
		getSelectedItem()
		itemStateChanged(ItemEvent)
	JSlider类
		JSlider(BoundedRangeModel/int,int,int,int)
		setPaintTicks(boolean)
		setMajorTickSpacing(int)/setMinorTickSpacing(int)
		setPaintLabels(boolean)
	JProgressBar类
		JProgressBar(int,int,int)
		setMinimun(int)/setMaximun(int)
		setValue(int)
		getNumberOfFiles()
		setStringPainted(boolean)
		stateChanged(ChangeEvent)
	JMenu类
		JMenu(Action/String,boolean)
		JMenuItem(Action/String,Icon)
		JToolBar(String,int)
4.事件处理
	ActionListener
	FocusListener
	ItemListener
	KeyListener
	MouseListener
	MouseMotionListener
	AdjustmentListener
	WindowListener
	*注册：Object.addEventListener(eventObject e)
5.布局管理
	边框式	BorderLayout(int,int)
	流式	FlowLayout(int,int,int)
	卡片式	CardLayout
	网格式	GridLayout(int,int,int,int)
		add(String,Container)
		show(Container,String)

七.I/O输入输出流
1.InputStream类/Read类
	available()		获得可用字节数
	mark(int)		当前位置作标记
	reset()
	markSupported()
	skip(long)
	read()
	read(byte[])
	read(byte[],int,int)	存入byte[]，从int开始写入int个字符
	close()
2.OutputStream类/Write类
	flush()
	write()
	write(byte[])
	write(byte[],int,int)	从byte[]读出，从int开始打印int个字符
	close()
3.File类
	File(String/File,String)
	exist()/canRead()/canWrite()
	isFile()/isDirectory()/isAbsolutePath()
	getName()/getPath()/getAbsolutePath()/getParent()
	list()
	lastModified()
	length()
	createFile()
	renameTo()
	delete()
4.RandomAccessFile类
5.ZipEntry/ZipInputStream/ZipOutputStream类



