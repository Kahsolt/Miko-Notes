///C#��΢��˾������һ���������ġ�������.NET Framework֮�ϵĸ߼������������
///C#�����ָ�����
///<summary>�ĵ�ע��Ҫд��XML��ʽ</summary>


��.�����ṹ
1..NET FrameWork: Code Once, Run Anywhere.
Visual Studio.NET���ɿ���������
	ͨ�����Կ�������
	.NET�������
	Data��XML
	Web Service/�û��ӿ�
	ͨ�����Թ淶CLS��VB��C++��C#��
2.�������
Console.Read();
Console.ReadLine();
Console.Write();
Console.WriteLine("Case 1: {0} and {1}\n",a,b);
	ռλ����"{" n ["," width] ["" format [precision]] "}"
		n			�������(��0��ʼ)
		width		��ʼ��������Ҷ���|���������
		format		dʮ��������,f����С��,n��λ���ŷָ�����,e�����ѧ����,c����,x�˽���,gĬ��
		precision	���ȣ���������λ������������С��λ��

3.����ṹ
using Syetem;	//����
namespace MyCSharpProgram	//�����ռ䣺�ɰ�������࣬�����������ռ�
{
	class HelloWorld		//��
	{
		//���Ա���
		//�������ߺ���
		static void Main(string[] args)	//������ڣ���ʾ����Ϊ���ࣻ����args�������ļ���
		{
			//������
		}
	}
}
4.�����б���
csc [/out:][/target:][/platform:] <C#Դ�ļ�>
	/out:D:\CSharp\HelloWorld.exe			//����ļ���
	/target:[exe|winexe|library|module]		//���ɿ���̨��ִ���ļ�|Windows��ִ���ļ�|���|ģ��
	/platform:[anycpu|x86|x64|Italium]		//ָ��������ƽ̨

һ.�﷨����
0.��ʶ��
*�ؼ��ֲ�������ʶ��������ǰ��@���ţ���@out/@for/@int
1.��������
����
	sbyte/byte		0	System.SByte/System.Byte
	short/ushort	0	System.Int16/System.Uint16
	int/uint		0	System.Int32/System.Uint32
	long/ulong	0L/0UL	System.Int64/System.Uint64
	BigInteger			������System.Numerics
������
	float	0.0F	System.Single
	double	0.0D	System.Double
	decimal	0.0M	System.Decimal
	Complex			������System.Numerics
������	bool	false	System.Boolean
�ַ���	char	'\0'	System.Char
�ṹ��	struct
ö����	enum	ö���±�Ϊ0��Ԫ��
				enum Color : byte {Red=1, Blue=2, Green=4};
				Color mixColor = Color.Red | Color.Blue;	//λ���㣬mixColor��һ��ֵ
������	ref		null
������	var		�����ھֲ�����������̬���ʹ���
				������foreach�е���������
*�����
typeof�����
	Type type=typeof(����)		//��ȡ��������˵��
typeof�����
	sizeof(ֵ����/struct)		//��ȡ�������ʹ�С����structҪʹ��unsafe������
??�����
	x=a??b;		//��ֵ��Ϊnull�򷵻���ֵ�����򷵻���ֵ
as	����ת��
	string str=someVar as string;	//��someVarת��Ϊstring�͵�str��ʧ��ʱ����null
is	ʵ���ж�
	if(str is MyString)		//�ж�str�Ƿ�ΪMyString�����������ʵ������
checked	�ж����	//�׳�OverflowException
	x=checked(x*x);
	checked{
		x=x*x;
		y=y*y*y*y*y;
	}
2.����
ref�ؼ��֣���������
	public void Swap(ref int a,ref int b){a^=b;b^=a;a^=b;}
	int a=5,b=3;	//b���븳��ֵ
	Swap(ref a,ref b);
out�ؼ��֣���������
	public void Copy(ref int a,out int b){b=a;}
	int a=5,b;	//b���ظ���ֵ
	Copy(ref a,out b);
params�ؼ��֣�����������
	public void setHobby(params string[] strArrHobby)
	{
		for(int i=0;i<strArrHobby.Length();i++)
			this.strArrHobbies.Add(strArrHobby[i]);
	}
	person.setHobby("He","Heh","Da~");	//������޶�������
delegate�ؼ��֣�����ί��
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
ָ�룺
	�÷�ͬC++����ֻ���ڱ����unsafe�ؼ��ֵ�������ʹ��
Nullable���ͣ��ɿ�����
	int? someVar=null;
���飺һά[]����ά[,]������[][]
	int[] elmt;elmt=new int[100];	//�ȼ���int[] elmt=new int[100];
	int[] nVar=new int[]{1,2,3,4};	//��ʼ��ʽ����
	int[,] f=new int[100100];		//���ζ�ά����
	
	int[][] JaggedArr=new int[3][];	//��������
	JaggedArr[0]=new int[1];
	JaggedArr[1]=new int[2];
	JaggedArr[2]=new int[3];
	int[][] JaggedArr=new int[][];	//���������ʼ��ʽ����
	{
		new int[]{1},
		new int[]{2,3},
		new int[]{4,5,6}
	};
��/�ӿ�
	class	C#ֻ֧����ĵ��̳�
	interface	�����Ϊһ���������࣬û����Ļ�����������public���ζ��ҿɱ�һ�����̳�
		�磺public interface IShape
		{
			double getArea();	//�����岻ʵ��
			int Color;
		}
*����������������
	object	System.Object
	String	System.String
3.������������@ǰ׺ע��
int @m=2;
char c;
string str;
*������[����˵����] const double Pi=3.1415926;
	public		ȫ�ֳ���
	private		�ֲ�����
	protected	�ܱ�������
	internal	����ͬһ�����ӿ��з���
	new			�����³��������̳и���ͬ������
4.����ת��
��ʽת����֧������ת��
��ʽת��
	float i=(int)f;
װ�䣺ֵ����ת����
	int i=10;
	object o=i;
���䣺����תֵ����
	object o=new object();
	int j=(int)o;
5.�������ṹ����C������ȫһ��
������if(){}else{}
	  switch(){case:default:}
	  *case������п�����goto case ĳ��ֵ;	//case�ı����Ǹ�label
ѭ����while(){}
	  do{}while();
	  for(;;){}
	  foreach(in){}
*break,continue,goto	//goto�ı�ǩ��ʽΪlabel:
6.�쳣����
try{}
catch(FileNotFoundException fnfex){}
catch(IOException ioex){}
catch(Exception e){}	//��������ʡ�ԡ�(Exception e)��
finally{}
7.��������
#define	����һ��Ԥ�������	
#undef	ȡ��һ��Ԥ�������
#if		���ĳԤ������Ŵ���
#elif
#else
#endif

��.�������
1.�����ռ�namespace
namespace MyEnv	//���������ֿռ�
{
	�����
}
using MyEnv;	//�������ֿռ�
2.��class
[�����η�] class ���� : ������, �ӿ���
{
	/*�������η�
	public		���У������ⲿ����
	private		˽�У��������г�Ա����
	protected	����������Ҳ�ɷ���
	internal	�ڲ���ͬһ�������ռ��е���ɷ���
	*/
	
	//����
	//����
	public override ������(){}	//��д����ķ���
	public new ������(){}	//���ػ���ķ���
}
�����η���
	abstract	�����࣬����ʵ������ֻ����Ϊ���౻�̳�
	internal	ֻ�ܴ�ͬһ�����򼯵��������з���
	extern
	new			Ƕ�׵���
	private		˽��Ƕ���ֻ࣬���ڶ����������з��������
	protected	����Ƕ���ֻ࣬���ڶ��������༰����������з��������
	public		�ɱ����������
	sealed		���ܱ��̳�
	virtual		�麯��
	override	����
	static		��̬
3.���⺯��
���캯��
��������
4.�������
public class School
{
	//�򼴳�Ա����������new/public/protected/internal/static/readonly����
	public string name;
	internal int studentcount;
	readonly static double PI=3.1415926;
	
	//��������
	public School(){}
	~School(){}
	
	//���Է�װ����get��set�ؼ�������
	public int StudentCount
	{
		get
		{return studentcount;}
		set
		{if(StudentCount!=value)StudentCount=value;}	//�̶���value
	}
}
5.����������
���������+
public class Complex
{
	public double real{get;set;}
	public double img{get;set;}
	...
	public static Complex operator+(Complex c1,Complex c2)	//ע����static����
	{
		return new Complex(c1.real+c2.real,c1.img+c2.img);
	}
}
��������[]
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
�����߼�����
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
6.����delegate

