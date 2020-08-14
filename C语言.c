/* C是结构化编译型语言，怼死了B语言而成为了万物的起源 */

零.标准C语言基础
0.主函数
main()
void main()
int main()
1.含参主函数m
int main(int argc, char* argv[]);
argc	命令行参数的个数，argc的取值为参数个数+1
argv	字符型指针数组，其各指针分别指向命令行中命令名和各个参数的字符串，其中argv[0]指向命令名字符串
*注：参数含空格则用引号括起来
2.存储类型标志
auto		局部，在声明的函数内可见
static		局部，函数返回后仍可见
extern		全局，对所有函数可见
register	局部，保存在寄存器
3.变量修饰符
const				常量，赋值后不能修改
volatile
volatile const


一.指针
1.指向数组的指针
	int a[10]; int *p; p=a;
指向字符串：
	char a[10]; char *p; p=a;
	
2.指向二维数组的指针
&	取地址运算符，把管辖范围上升一级
*	取值运算符，把管辖范围下降一级
	例：int a[3][4]={{1,2,3,4},{5,6,7,8},{9,10,11,12}};
	则: a		等价于	&a[0]
		a[0]	等价于	&a[0][0]	等价于	*a
		a[0][0]	等价于	**a
	!数组名相当于指向数组首元素的一个指针，此处a[0]为指向一个“含有4个int型元素的一维数组”的指针
	定义为：int (*p)[4];	一个指针数组
	
	例：p=a;	
	则:*(*(p+i)+j)等价于a[i][j]

3.指向结构体的指针：
struct date{int year,month,day;};
date birth={1995,6,3};
date *d=&birth;
.	点运算符，(*d).day
->	箭头运算符，d->year

二.位运算
1.&与	将变量中某些位清零，获取变量中的某一位
	1.将n的低八位清零
		n&=0xffffff00;	//int n;
		n&=0xff00;	//short n;
	2.判断n的第七位是否是1
		n&0x80==0x80	//0x80=1000 0000
	3.求x的第n位
		(a>>n)&1
		或	(x&(1<<n))>>n
2.|或	将变量中某些位置1
	1.将n的低八位置1
		n|=0xff;
3.^异或	将变量中某些位取反	//性质：若a^b=c，则c^b=a且c^a=b
	1.将n的低八取反
		n^=0xff;
	2.交换a、b的值
		a=a^b;b=a^b;a=a^b;	//a^=b;b^=a;a^=b;
4.~非

5.<<左移	将变量乘2
6.>>右移	将变量除2并下取整
	*无符号数补0，有符号数补符号位的值

三.引用
1.作为变量的引用
类型名 &引用名=变量名;
	void swap(int &a,int &b)
	{
		int tmp;
		tmp=a;a=b;b=tmp;
	}
	swap(x,y);
等价于:
	void swap(int *a,int *b)
	{
		int tmp;
		tmp=*a;*a=*b;*b=tmp;
	}
	swap(&x,&y);
2.作为函数返回值的引用
返回类型 &函数名(参数表){函数体;}
	int n;
	int &SetValue(){return n;}
	int main(){cout<<(SetValue()=40)<<endl;}
*常引用：const int &r=n;	//不能用r去修改n的值

四.const常量
1.常量指针:不能通过指针去修改值
const int *p=&n;
*不能把常量指针赋值给非常量指针<除非强制类型转换p2=(int *1)p1>，反过来可以

