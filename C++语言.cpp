//C++是一门编译型语言，可流程化也可面向对象感觉什么都能干

零.标准C++语言基础
0.版本
C++98 => (c++03) => C++11 => C++14 (=>C++17)
1.头文件
标准C头文件
	标准C语言的头文件，以.h为扩展名，如<stdio.h>
具有C库功能的新C++头文件
	无.h扩展名而以c开头，全部在名字空间std中，如<cstdio>与<stdio.h>头文件对应，提供类似功能
旧的C++头文件名
	早期以.h为扩展名的C++头文件，没有名字空间，如<iostream.h>，已不在官方标准中！
标准C++头文件
	不再使用.h扩展名，全部在名字空间std中，如<iostream>，所包含功能和对应旧头文件类似

例如：
<string.h>：旧的C头文件
<cstring>：旧C头文件的std版
<string>：新的标准C++头文件，属于STL

2.名字空间
namespace 名字空间名
{
	成员表
	(即一些变量或标识符)
}
通过作用域访问符::(双冒号)的方式访问某个成员
名字空间名::成员名

using关键字
using namespace 名字空间名;	//表示该名字空间里面的所有成员可以直接访问，而不需要再使用前缀"名字空间名::"
using 名字空间名::成员名;	//表示该名字空间里面的指定成员可以直接访问

3.强制类型转换运算符
static_cast<目标类型>(需转换的表达式)
	标准转换及其逆转换，如void*转换为char*、int转换为float
reinterpret_cast<目标类型>(需转换的表达式)
	非标准强制转换，如void*转换为int、double转换为int
const_cast<目标类型>(需转换的表达式)
	转换const或volatile，将转换掉将转换掉表达式的常量性
dynamic_cast<目标类型>(需转换的表达式)
	进行类对象间的转换

4.动态内存分配
C的头文件<stdlib.h>
void* malloc(size);
	申请大小为size的内存块，返回首地址指针，若失败返回NULL；size常用例如：sizeof(int)*500
	一般要作类型转换，否则默认void型指针
void free(void* block);
	释放由malloc()申请的内存块，block是指向此块首地址的指针(即当时malloc()的返回值)

C++中动态内存管理的运算符：malloc和free的语法糖
new	分配内存
	指针标识符=new 类型标识符;
	指针标识符=new 类型标识符(初始化值);
	指针标识符=new 类型标识符[数组维度];
delete	释放内存
	delete 指针标识符;
	delete[] 指针标识符;

5.函数指针：指向函数起始地址的一个指针
类型名 (*指针名)(参数表);
	int (*pf)(int,char);
	void (*pA)(char);
	例如：int Max(int a,int b){return a>b?a:b;}
		  int (*pf)(int,int);
		  pf=Max;	//函数指针赋值，注意参数表匹配
		  cout<<pf(27,19);	//调用
	
一.类Class的基本结构
0.C中的结构体
struct 结构体名
{
	成员变量表;
};
struct 结构体名 结构对象名;	//声明一个对象，通过点运算符(.)访问成员变量
struct 结构体名* 结构对象名;	//声明一个对象类型的指针，通过箭头运算符(->)访问成员变量

1.C++中的类
class 类名
{
	//私有数据成员与成员函数(默认)
	public:
	//公有，如get/set函数，友元函数
	protected:
	//保护
	private:
	//私有，通常是成员变量以及工具函数
};
!成员函数一定不能返回私有数据的指针或引用，否则破坏了封装性
*大小： sizeof(class-type)
	   sizeof object-name

2.接口.h和实现.cpp的分离
.h预处理封套(.置换为_)
#ifndef 文件名_H
#define 文件名_H
类的定义
#endif
*或者写在.h开头
#pragma once

.h文件中的类成员函数实现(作为内联函数inline直接实现)
[const?] 返回类型 成员函数名(参数列表) [const?]		// 后const表示成员函数不修改成员变量
{
	函数体;
}
.cpp文件中的类成员函数实现(作用域::运算符)
[const?] 返回类型 类名::成员函数名(参数列表) [const?]
{
	函数体;
}

3.初始化类对象
类名 类对象名;	//声明一个对象，指针指向类则用点运算符(.)访问成员，指针指向类成员则用点星运算符(.*)访问成员
类名& 类对象名;	//声明一个对象的引用/别名
类名* 类对象名;	//声明一个对象类型的指针，指针指向类则用箭头运算符(->)访问成员，指针指向类成员则用箭头星运算符(->*)访问成员
*对简单的只含若干变量的类，可用初始化列表：
类名 类对象名={为类的成员变量依次赋值，以逗号分隔};

4.特殊的类函数
*构造函数：默认存在，可重载(如缺省构造、拷贝构造)，无返回值
类名::构造函数名即类名(参数列表)
	:成员初始化表，逗号分隔
{
	函数体;
}
	例：class Test
		{
			public:
				Test(int n){};
				Test(int n,int m){};
				Test(){};
		};
		Test x={{1, 2}};			//调用了2号构造函数
		Test x[3]={1,Test(5,6)};	//生成3个对象，分别调用了1/2/3号构造函数
		Test *px[3]={new Test(7),new Test(0,0)};	//生成2个对象，调用1/2号构造函数
		*下列三个相似等价：
		Test x(1);
		Test x[1]={1};
		Test x[1]={Test(1)};
*拷贝构造函数：默认存在，注意传递引用，无返回值
类名::构造函数名即类名(类名& 拷贝对象)
	:类成员变量=拷贝对象.对应成员变量,
	 所包含的其他类对象的拷贝构造
{
	函数体;
}
*类型转换构造函数：作一个隐式的类型转换
例：class Complex
{
	public:
		Complex(int i)		//类型转换构造函数
		{real=i;imag=0;}
		Complex(double r,double i)
		{real=r;imag=i;}	//一般构造函数
	private:
		double real,imag;
};
int main()
{
	Complex c1(7,8);	//调用一般构造函数
	Complex c4={7, 8};
	Complex c2=12;	//调用类型转换构造函数
	Complex c3=9;	//调用类型转换构造函数，9被自动转换成一个临时Complex对象，再调用拷贝构造函数
	return 0;
}
*explicit构造函数：防止隐式的类型转换构造函数被调用
例：class Number
{
	public:
		explicit Number(double i)	//explicit构造函数
		{num=i;}
	private:
		double num;
};
int main()
{
	Number n=12.5;	//编译出错
	return 0;
}
*析构函数：默认存在，不可重载，系统自动调用，无返回值
[virtual?] 类名::~构造函数名即类名()
{
	函数体;//通常是delete申请的空间
}

5.友元friend：提高效率，破坏封装；不传递不继承
*友元函数：可以直接访问类的私有成员的非成员函数，是定义在类外的普通函数；但需要在友元类中作friend函数声明，可以放在公有或私有部分；友元函数调用和普通函数一样
例：class Number
{
	public:
		Number(int i){num=i;}
		friend void Addone(Number &);	//声明为友元函数
	private:
		int num;
};
void Addone(Number &i){i.num++;}	//定义函数
int main()
{
	Number x(5);
	Addone(x);	//正常调用
	return 0;
}
*友元类：友元类的所有成员函数都是另一个类的友元函数，可以访问另一个类的私有和保护成员
例：class B
{
	public:
		chg(int i){x=i};
}；
class A
{
	public:
		friend class B;	//B是友元类
	private:
		int x;
};

6.this指针：指向成员函数所作用于的对象
class A
{
	public:
		void Hello(){cout<<"Hello"<<endl;}
	private:
		int i;
};
main()
{
	A *p=NULL;	//对于*p可以任意赋值
	p->Hello();	//都会正确执行
	return 0;
}

7.静态与常量
static	静态关键字，静态成员被类所共有(可视作全局)
	.cpp文件中的类static成员赋初值(作用域::运算符)：
	static 类名::成员名=初值;
	static 类名::成员名(初值);

const	常量关键字
	常量对象：冻结变量不能被修改
		const int p=5;
	常量成员函数：说明类成员函数不能修改类成员变量(静态变量除外)的值，也不能调用同一个类的非常量成员函数(静态函数除外)
		int getValue(){return value;} const;
		int getValue(){return value>=0?(value==0?0:1):-1;};	//视为函数重载
	常引用：不能通过常引用别名去修改变量的值
		const int &r=n;
		
mutable	可变关键字
	即使在const类对象以及const成员函数作用下，其值依旧可以改变

8.运算符重载：关于运算符的一个重载函数
返回值类型 operator 运算符(参数表){函数体}
重载为普通函数(参数个数等于操作数)：
	例：Complex operator+(const Complex &a,const Complex &b)
		{return Complex(a.real+b.real,a.imag+b.imag);}
	调用：Complex a(1,2),b(3,4),c;
		  c=a+b;	//相当于c=operator+(a,b)
重载为类的成员函数(参数个数比操作数少1)：
	例：Complex Complex::operator+(const Complex &b)
		{return Complex(real+b.real,img+b.imag);}
	调用：Complex a(1,2),b(3,4),c;
		  c=a+b;	//相当于c=a.operator+(b)
		  
*重载“=”：只能作为成员函数重载(同理还有()、[]、->)
class String
{
	public:
		String():str(NULL){}
		String(String &s)	//拷贝构造函数
		{
			if(s.str)
			{
				str=new char[strlen(s.str)+1];
				strcpy(str,s.str);
			}
			else str=NULL;
		}
		const char* c_str(){return str;}	//返回字符串首地址
		char* operator=(const char* s);	//重载=符号使得str="Hello"成立
		String& String::operator=(const String &s)	//重载=符号使得str1=str2成立
		~String(){if(str)delete []str;}
	private:
		char* str;
}
char* String::operator=(const char* s)	//重载=符号使得str="Hello"成立
{
	if(str)delete []str;
	if(s)
	{
		str=new char[strlen(s)+1];
		strcpy(str,s);
	}
	else str=NULL;
	return str;
}
String& String::operator=(const String &s)	//重载=符号使得str1=str2成立
{
	if(str==s.str)return *this;	//str=str自身赋值，直接返回自身
	if(str)delete []str;
	str=new char[strlen(s.str)+1];
	strcpy(str,s.str);
	return *this;
}
->浅复制：逐个字节拷贝；指针复制危险！
  深复制：利用拷贝构造函数、=符号重载，制作指针对象的副本

#实例：变长数组
class CArray
{
	public:
		CArray(int s=0):size(s)
		{
			if(s==0)ptr=NULL;
			else ptr=new int[s];
		}
		CArray(CArray &a)
		{
			if(!a.ptr)
			{ptr=NULL;size=0;}
			else
			{ptr=new int[a.size];
			memcpy(ptr,a.ptr,sizeof(int)*a.size);}
		}
		~CArray(){if(ptr)delete []ptr;}
		void push_back(int v)	//末尾加入v
		{
			if(ptr)
			{
				int *tmpPtr=new int[size+1];
				memcpy(tmpPtr,ptr,sizeof(int)*size);
				delete []ptr;
				ptr=tmpPtr;
			}
			else ptr=new int[1];
			ptr[size++]=v;
		}
		CArray &operator=(const CArray &a)
		{
			if(ptr==a.ptr)return *this;
			if(a.ptr==NULL)
			{
				if(ptr)delete []ptr;
				ptr=NULL;size=0;
				return *this;
			}
			if(size<a.size)
			{
				if(ptr)delet []ptr;
				ptr=new int [a.size];
			}
			memcpy(ptr,a.ptr,sizeof(int)*a.size);
			size=a.size;
			return *this;
		}
		int length(){return size;}
		int& operator[](int i){return ptr[i];}
	private:
		int size;
		int *ptr;
};

*流插入提取运算符重载
ostream &ostream::operator<<(ostream &os,const Complex &c)
{
	os<<c.real<<"+"<<c.img<<"i";
	return os;
}
istream &istream::operator>>(istream &is,Complex &c)
{
	is>>c.real>>is.ignore()>>c.img>>is.ignore();
	return o;
}

*自增++/自减--运算符重载
重载为成员函数：
	T operator++(int);
	T operator--(int);
重置为全局函数：
	T operator++(T,int);
	T operator--(T,int);
	
*类型强制转换运算符重载
operator int (){return n;};	//(int) s等效于s.int()

二.继承与派生
1.继承关系：类A被类B蕴含
class 派生类名: public 基类名
{
	……
};
*总是先构造/后析构基类
2.复合关系：类A中有成员k，k是类B的对象
class CPoint
{double x,y;};
class CCircle
{
	double r;
	CPoint center;
};

*注意：循环定义！
class CDog;
class CMaster
{CDog dogs[10];};
class CDog
{CMaster m;};
->修正：
class CMaster;
class CDog
{CMaster *pm;};
class CMaster
{CDog *dogs[10];};

3.基类与派生类同名：加上作用域运算符::
class base
{
	public:
		int i;
		void func();
};
class derived: public base
{
	public:
		int i;
		void access()
		{
			i=5;	//派生类调用
			base::i=7;	//基类调用
			func();	//派生类调用
			base::func();	//基类调用
		}
		void func();
};
int main()
{
	derived obj;
	obj.i=1;	//派生类调用
	obj.base::i=7;	//基类调用
	return 0;
}

4.public继承的赋值兼容规则
class base{};
class derived: public base{};
base b;
derived d;
按照派生类可以赋值给基类的原则：
i>.b=d
ii>.base &br=d;
iii>.base *pb=&d;

三.多态与虚函数
1.虚函数virtual：可以参与多态
class base
{
	public: virtual int get();
	private: int x;
};
int base::get(){return x;}
*virtual关键字只用在函数声明中，函数体定义时不用
*构造函数、静态函数不能被声明为虚函数
2.多态
class Base
{
	public:
		virtual void VrtFunc(){}
};
class Derived: public Base
{
	public:
		virtual void VrtFunc(){}
};
int main()
{
	Derived d;
	Base *p=&d;
	p->VrtFunc();	//指针多态，调用哪一个VrtFunc()取决于p指向哪个类
	Base &q=d;
	q.VrtFunc();	//引用多态，调用哪一个VrtFunc()取决于q引用哪个类
	return 0;
}
*虚函数表：每一个含有虚函数的类(或其派生)都有一个虚函数表，该类任何对象中都放着一个指向虚函数表的指针(4个字节)，虚函数表中列出了该类的虚函数地址
3.纯虚函数：没有函数体=0
class Shape	//抽象类：包含纯虚函数的类
{
	public:
		virtual double Area()=0;	//纯虚函数，不能有函数体(函数指针指向0)
		virtual void PrintShape()=0;
};

*注意this指针：在非构造/析构的成员函数中调用虚函数，就是多态！！！
class Base
{
	public:
		void func1(){func2();}	//注意此处func2()等价于this->func2()
		virtual void func2();
};
class Derived: public Base
{
	public:
		virtual void func2();
};
int main()
{
	Derived d;
	Base *p=&d;
	p->func1();	//多态调用，调用了Derived的func2()
	return 0;
}

4.虚析构函数
*用于通过基类指针delete派生类对象时，先调用派生类析构函数，再调用基类析构函数
class Base
{
	public:
		virtual ~Base();	//把基类析构函数声明为virtual
};
class Derived: public Base
{
	public:
		~Derived();	//派生类析构函数自动继承为virtual
};

5.函数对象：若一个类重载了()运算符，则该类的对象就成为了函数对象
class CMyAverage	//函数对象类
{
	public:
		double operator()(int a,int b,int c)
		{return (double)(a+b+c)/3;}
};
CMyAverage ave;
cout<<ave(3,9,4)<<endl;

四.文件操作
#include<fstream>	//头文件
ofstream outFile("data.out",ios::out|ios::binary);	//打开文件，用构造函数
或：ofstream fout;
	fout.open("data.out",ios::out|ios::binary);	//打开文件，用open()函数
	*if(!fout)cerr<<"File Open Falure!"<<endl;	//打开成功判定

例：
ofstream fout("data.out",ios::app);	//写文件，以追加方式打开
ifstream fin("data.in",ios::in);	//读文件
//fstream iofile("sample.dat",ios::in|ios::out|ios::binary);	//打开一个读写文件
int loc;
loc=fout.tellp();	//tellp()获取写指针位置
loc=10L;	//注意L标记
fout.seekp(loc);	//将写指针移动到第10个字节处
fout.seekp(loc,ios::beg);	//从头数10个字节，另有ios::cur(从当前)，ios::end(从尾)
loc=fout.tellg();	//tellg()获取读指针位置
loc=25L;
fout.seekg(loc);	//将读指针移动到第25个字节处
fout.seekg(loc,ios::beg);	//从头数25个字节，另有ios::cur(从当前)，ios::end(从尾)
fin.close();
fout.close();
int x=10;
fout.seekp(20,ios::beg);
fout.write((const char*)(&x),sizeof(int));
fin.seekg(0,ios::beg);
fin.read((char*)(&x),sizeof(int));
*loc表示偏移量，可以为负值

五.模板：泛型程序设计
1.函数模板
template <class 类型参数1, class 类型参数2, ...>
返回值类型 模板名(形参表)
{
	函数体
}

例如：
template <class T>	//T为类型形参
void swap(T &x,T &y)
{
	T tmp=x;
	x=y;
	y=tmp;
}
template <class T1, class T2>	//函数模板也可以重载
void swap(T1 &x,T2 &y)
{
	cout<<T2<<" "<<T1<<endl;
}
template <class T>
T Max(T a[], int size) //size是数组元素个数
{
	T tmpMax=a[0];
	for(int i=1;i<size;++i )
	if(tmpMax<a[i])tmpMax=a[i];
	return tmpMax;
}
2.类模板
template <class 类型参数1, class 类型参数2, ...>
class 类模板名
{
	成员函数和成员变量
};
*其中，成员函数在类外定义函数体时写作如下：
template <类型参数表>
返回值类型 类模板名<类型参数名列表>::成员函数名(参数表)
{
	函数体
}
*调用模板定义对象时写作：
类模板名 <真实类型参数表> 对象名(构造函数实际参数表); 

例如：
template <class T1, class T2>
class Pair
{
	public:
		T1 key; //关键字
		T2 value; //值
		Pair(T1 k,T2 v):key(k),value(v){};
		bool operator < (const Pair<T1,T2> & p) const;
};
template <class T1,class T2>
bool Pair<T1,T2>::operator<( const Pair<T1, T2> & p) const	//Pair的成员函数 operator <
{ return key < p.key; }
int main()
{
	Pair<string, int> student("Tom",19);	//实例化出一个类 Pair<string, int>
	cout << student.key << " " << student.value;
	return 0;
}
*类模板的派生继承
类模板->类模板
模板类->类模板
普通类->类模板
模板类->普通类

六.常用STL模板：Standard Template Library
容器	 容纳各种数据类型的通用数据结构，是类模板
迭代器	用于依次存取容器中元素，类似于指针
算法	 操作容器中元素的模板函数

[容器]
1.顺序容器
动态数组<vetctor>：vetctor
双向队列<deque>：deque
双向链表<list>：list
2.关联容器：元素是排序的
集合/重元素集合<set>：set、multiset
键值对组<map>：map、multimap
3.容器适配器
栈<stack>：stack
队列<queue>：queue
优先级队列<priority_deque>：priority_deque

常用方法：
begin	迭代器，第一个元素
rbegin	迭代器，最后一个元素
end		迭代器，最后一个元素之后
rend	迭代器，第一个元素之前
erase	删除一个或多个元素
clear	删除所有元素
front	引用，第一个元素
back	引用，最后一个元素
push_back	末尾追加
pop_back	末尾删除
erase	迭代器，被删元素或区间后一位
at		引用，取出对应位置的值
insert	插入到某位
push_front	链表最前面插入
pop_front	链表最后面删除
sort	排序
remove	删除与指定值相等的所有元素
unique	删除所有和前一个元素相同的元素
merge	合并两个链表，并清空被合并的两个链表
reverse	颠倒链表
splice	在指定位置前插入另一个链表中若干元素，并再另一个链表中删除之
find	按值查找，关联容器中(x<y&&y<x)为false也视为相等
lower_bound	找某个下界
upper_bound	找某个上界
equal_range	同时找上下界
count	计算“等于”某个数的元素个数
insert	插入一个元素或一个区间
push	压栈
pop		弹栈
top		引用，返回栈顶元素

[迭代器]：指向容器元素的指针
容器类名::iterator 变量名;	//声明一个迭代器变量
容器类名::reverse_iterator 变量名;	//声明一个反向迭代器变量
容器类名::const_iterator 变量名;	//声明一个常量迭代器变量，不能修改其指向元素的值
*迭代器变量名	//访问迭代器指向的元素
迭代器类型：
	容器			容器上的迭代器
	vetctor			随机访问
	deque			随机访问
	list			双向
	set/multiset	双向
	map/multimap	双向
	stack			不支持
	queue			不支持
	priority_deque	不支持
双向迭代器的计算：若p和p1都是双向迭代器，则可对p、p1可进行以下操作
	++p, p++使p指向容器中下一个元素
	--p, p--使p指向容器中上一个元素
	* p 取p指向的元素
	p = p1赋值
	p == p1 , p!= p1判断是否相等、不等
随机访问迭代器的计算：若p和p1都是随机访问迭代器，则可对p、p1可进行以下操作
	兼容双向迭代器的所有操作
	p += i将p向后移动i个元素
	p -= i将p向向前移动i个元素
	p + i值为: 指向p 后面的第i个元素的迭代器
	p -i值为: 指向p 前面的第i个元素的迭代器
	p[i]值为: p后面的第i个元素的引用
	p < p1, p <= p1, p > p1, p>= p1

简例：
int main()
{
	vector<int> v; //一个存放int元素的数组，一开始里面没有元素
	//vector<vector<int>> v(3);	二维动态数组，v有3个元素，每个元素是一个动态数组
	v.push_back(1); v.push_back(2); v.push_back(3); v.push_back(4);
	vector<int>::const_iterator i; //常量迭代器
	for( i = v.begin();i != v.end();++i )
	cout << * i << " ";
	cout << endl;
	vector<int>::reverse_iterator r; //反向迭代器
	for( r = v.rbegin();r != v.rend();r++ )
	cout << * r << " ";
	cout << endl;
	vector<int>::iterator j; //非常量迭代器
	for( j = v.begin();j != v.end();j ++ )* j = 100;
	for( i = v.begin();i != v.end();i++ )
	cout << * i << " ";
	return 0;
}