//Java������һ�����������ԣ����ú���C����
//Program Once, Run Anywhere

��.����
1.JDKĿ¼
	bin		�������蹤�ߣ���javac.exe��java.exe
	demo	�������߰��Դ���ʾ����
	db		Ƕ��ʽ���ݿ�Derby����������Դ������
	include	���ڱ��뱾�ط�����C++ͷ�ļ�
	jre		Java���л���
	lib		����ļ���
	sample	�Դ�ʾ������
	src.zip	���API��Դ�����ļ�
*�����������ã���\binĿ¼����ϵͳ��%Path%������
javac HelloWorld.java		�����������.class�ļ�
java HelloWorld				�����������.class��׺
2.ע��
//����ע��
/*����ע��*/
/**�ĵ�ע��*/
3.�������
import java.util.Scanner;
Scanner input=new Scanner(System.in);
i=input.nextInt();
System.out.println(i);
4.�򵥽ṹʾ��
/**Add.java*/
import java.util.Scanner;	//�����package(һ��)�����import(���)
public class Add	//�����������ļ�����ͬ
{
    public static void main(String args[])	//���������������
    {
        Scanner input=new Scanner(System.in);
        int a=input.nextInt();
        int b=input.nextInt();
        System.out.println(a+b);
    }
}
*����=���д���+�����
 ����=��+����+����+������+�ӿ�
	��=����+����(����+����)
	
һ.�����븳ֵ
0.����		true
			false
			null
1.����		byte	1�ֽ�	��ֵ0
			short	2�ֽ�	��ֵ0
			int		4�ֽ�	��ֵ0
			long	8�ֽ�	��ֵ0L	��׺L/l
				ʮ����		��ǰ׺
				�˽���		ǰ׺0
				ʮ������	ǰ׺x0/X0
2.������	float	4�ֽ�	��ֵ0.0f	��׺F/f
			double	8�ֽ�	��ֵ0.0d	��׺D/d
				ָ����ʾ	���E/e
3.�ַ���	char	2�ֽ�	��ֵ'\u0000'	//ʹ��Unicode����
4.������	boolean	1�ֽ�	��ֵfalse
5.����		String 	����	��ֵnull	//+�����ַ�������
			int Array[];		//����ʱ��ָ����С���ȼ���int[] Array;
			Array=new int[5];	//����ʱָ����С
			char charArray[]=new char[5];	//����ʱ������Ҫָ����С
6.������	class
7.�ӿ�����	interface
*ǿ������ת��
(int)d��(float)f��
*�����ж�
���ʽ(���� instanceof ��/�ӿ�)Ϊtrue��false

��.�������
1.ѡ���ж�
if(){}else{}
switch(){}
2.ѭ��
for(;;){}
while(){}
do{}while();
*����
break [<label>];	//��label������
continue [<label>];	//��label������
<label>:			//�趨label
3.����
assert <�߼����ʽ>;					//ʧ��ʱ���׳�AssertionError
assert <�߼����ʽ>:<��ʾ��Ϣ>;
*�رն��Ա��룺�Ӳ���-source 1.3	//��ΪJRE1.3����֧�ֶ���
 ִ��ʱ�������Դ��룺�Ӳ���-ea/-enableassertions
4.�쳣����
�׳�	throw new someException("���صĶ�������...","#9985");
����	try{}
		catch(){}	//try��finally֮������ж��catch
		finally{}

��.�������
1.��class=����+����(����+����)
[���η�] class ���� [extends ������] [implements �ӿ���]	//����ɵ��̳У��ӿڿɶ�̳�
{
	//����
	//����
	//���߷���
	public static void main(String args[]){}	//������
}
������η�
	public		���У��ɿ���������
	protect		�������ɱ����������������
	private		˽�У���������������
	default		���ӷ������η�����ͬ������
	abstract	���󣬲���ʵ����
	final		���գ����ܱ��̳� 
	static		��̬
�����Է��������η�
	public		���У��ɿ���������
	protected	�������ɱ����������������
	private		˽�У���������������
	abstract	���󣬴˷���Ӧ����ĳ������ʵ��
	final		���գ����������ܸ��ǿɱ�����
	static		��̬����������ֱ�ӵ���
*�ڲ��ࣺ�������������ڲ�����
	��Ա�ڲ��ࣺ�����ⲿ���ⱻ�����ʹ��
		new �ⲿ�๹��().new �ڲ��๹��();
		new �ⲿ����.new �ڲ��๹��();	//�ⲿ��Ϊ��̬ʱ
		�ⲿ��ʵ��.new �ڲ��๹��();
	�����ڲ��ࣺ���ڸ÷����ڱ������ʹ��
*�����ࣺ��������󲻱������κα�����
	new �๹��();
*�����ࣺ����ʵ�������������̳еĸ���ʹ��
*������ĳ�Ա��������ϵͳ��ʼ��ֵ
 ���ڷ����ľֲ����������Լ�����ֵ
*���أ���������ͬ������ͬ���ɹ���
 ���ǣ���������ͬ��������ͬ�������еķ�������������
*this	ָ�Ʊ����Ա
 super	ָ�Ƹ����Ա
2.��������
���� ������;			//����
������=new �๹��();	//����
���� ������=new �๹��();	//����ʱ����
*����������������������������о���
 System.gc()��Runtime.getRuntime()������������Ϣ��������������������ִ������
3.�ӿ�interface
<�����������η�> [abstract] interface �ӿ��� [extends ���ӿ���]	//abstract�ؼ��ֿ�ʡ�ԣ�ϵͳ��Ĭ��Ϊabstract��
{
	//������Ա��������ʡ��public static final���η�
	//���߷�����������ʡ��public abstract���η�
}
*����ʵ����������������Ϊ����(����ָ��)
 People stu=new Student();	//�˴�Student��ʵ����People�ӿ�

��.Java���
1.Object��
toString()	//System.out.println()Ĭ�����toString()����ֵ
equals()	�Ƚ�����ʵ�������ݣ�һ���==���ж�����ָ���Ƿ�ͬһ
hashCode()
2.����������
toString()/toBinaryString()/toOctalString()/toHexString()
xxxValue()			��װ������ȡֵ
parseXxx(String)	�ַ���ת��ֵ
parseXxx(String,int)�ַ���תint������ֵ
3.���Ͽ��
ArrayList
LinkedList
Vector
Map
Hashtable

��.�ַ�������
1.String��
	Length()
	startsWith(String)
	endsWith(String)
	indexOf(char/String)
	indexOf(char/String,int)	��id֮��ʼ��
	lastIndexOf(char/String)
	lastIndexOf(char/String,int)	��id֮��ʼ��
	equals(Object)
	equalsIgnoreCase(String)
	compareTo(String)
	concat(String)		������β
	replace(char,char)
	toLowerCase()
	toUpperCase()
2.StringBuffer��
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
3.StringTokenizer��
	StringTokenizer(String,String)	Ϊstr����һ���ַ��������������ַ���delim��ÿ���ַ�Ϊ�ָ���
	nextToken()
	hasMoreTokens()
	countTokens()
4.��ʽ���ı�
	DateFormat��
	NumberFormat��
5.������ʽ
	[]		�ַ���Χ���б�
	?		���ַ�ͨ��
	*		���ַ�ͨ��
	\t\n\r\f\a\e	�����ַ����Ʊ����С��س�����ҳ�����桢ת��
	^		��
	\d \D	��ֵ�ַ�����д��ȡ��
	\s \S	�հ��ַ�
	\w \W	�����ַ����ȼ���[a-zA-Z0-9_]
	\b \B	�ֱ߽�
	\A		���뿪ʼ
	\z		�������
	^$		����Ŀ�ʼ�ͽ���λ��
	X?		�ַ�X��ѡ
	X*		�ַ�X��0������
	X+		�ַ�X��1������
	X(n) X(n,) X(x,m)	n��X������n��X��n-m��X
	XY		X�е������ַ����Y�������ַ�
	X|Y		X��Y���κ��ַ�
	
��.ͼ�λ�Swing
0.���ÿ�
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
1.Color����ɫ������
	Color(DT r,DT g,DT b)
	Color(DT r,DT g,DT b,DT a)	//DTΪfloat[0,1)��int[0,225]
2.Timer���ʱ��
	Timer(int delay,ActionListener listener)
	isRunning()
	start()/stop()/restart()
	setDelay(int)/getDelay()		//��λΪ����ms
	setInitalDelay(int)/getInitalDelay()
	addActionlistener(ActionListener)/removeActionlistener(ActionListener)
3.���������
	JFrame��
		setSize(int,int)
		setVisible(boolean)
		setBounds(int,int,int,int)	//λ�úͿ��
		setDefaultCloseOperation(enum)
			������	EXIT_ON_CLOSE			�˳�
					DISPOSE_ON_CLOSE		�ͷ�JFrame����������
					DO_NOTHING_ON_CLOSE		������
					HIDE_ON_CLOSE			�Ի���رգ���������
	JDialog��
		JDialog(JFrame,String,boolean)	//trueΪ��Ӧģʽ
		setTitle(String)/getTitle()
		setSize(int,int)
		setVisible(boolean)
		setModal(boolean)
	JPanel��
	JButton��
		JButton(void/String/Icon/String,Icon)
		addActionlistener()
		actionPerformed(ActionEvent)
	JTextField��
		JTextField(Document,String,int)
		setText(String)/getText()
	JPasswordField��
		JPasswordField(Document,String,int)
	JTextArea��
		JTextArea(Document,String,int,int)
		setText()/getText()
		insert(String,int)
		append(String)
		replaceRange(String,int,int)
		textValueChanged(TextListener)
	JLabel��
		JLabel(String/Icon,int)
		setText()/getText()
		setBackground()/setForeground()
		setFont()
	JRadioButton��/JCheckBox��
		JRadioButton(String,Icon,bool)
		itemStateChanged(ItemEvent)
	JComboBox��
		JComboBox(ComboBoxModel/Object[]/Vector)
		setEditable(boolean)
		addItem(Object)
		insertItemAt(Object,int)
		removeItem(Object)
		removeItemAt(int)
		removAllItems()
		getSelectedItem()
		itemStateChanged(ItemEvent)
	JSlider��
		JSlider(BoundedRangeModel/int,int,int,int)
		setPaintTicks(boolean)
		setMajorTickSpacing(int)/setMinorTickSpacing(int)
		setPaintLabels(boolean)
	JProgressBar��
		JProgressBar(int,int,int)
		setMinimun(int)/setMaximun(int)
		setValue(int)
		getNumberOfFiles()
		setStringPainted(boolean)
		stateChanged(ChangeEvent)
	JMenu��
		JMenu(Action/String,boolean)
		JMenuItem(Action/String,Icon)
		JToolBar(String,int)
4.�¼�����
	ActionListener
	FocusListener
	ItemListener
	KeyListener
	MouseListener
	MouseMotionListener
	AdjustmentListener
	WindowListener
	*ע�᣺Object.addEventListener(eventObject e)
5.���ֹ���
	�߿�ʽ	BorderLayout(int,int)
	��ʽ	FlowLayout(int,int,int)
	��Ƭʽ	CardLayout
	����ʽ	GridLayout(int,int,int,int)
		add(String,Container)
		show(Container,String)

��.I/O���������
1.InputStream��/Read��
	available()		��ÿ����ֽ���
	mark(int)		��ǰλ�������
	reset()
	markSupported()
	skip(long)
	read()
	read(byte[])
	read(byte[],int,int)	����byte[]����int��ʼд��int���ַ�
	close()
2.OutputStream��/Write��
	flush()
	write()
	write(byte[])
	write(byte[],int,int)	��byte[]��������int��ʼ��ӡint���ַ�
	close()
3.File��
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
4.RandomAccessFile��
5.ZipEntry/ZipInputStream/ZipOutputStream��



