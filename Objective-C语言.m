//Objective-C是面向对象的C，用于Apple设备的开发
//OC的API开发环境称为Cocoa

零.基础
1.OC程序结构=类接口.h+类实现.m+应用程序main.c
方法调用
	[实例 对象方法]
	[类名 类方法]
	*又称消息表达式:[接收方 消息]
含参调用
	[接收方 名字1:参数1 名字2:参数2 名字3:参数3 ...]
	*此方法名为"名字1:名字2:名字3:..."		//冒号也是方法名的一部分
2.输入输出
NSLog(@"%i days left.",days);
	%@	对象
	%c	字符
	%i	整型
	%u	无符号整型
	%o	八进制整型
	%x	十六进制整型
	%f	浮点型
	%e	指数浮点
	%g	最短指数浮点
	%p	id类型
3.指令符@：编译器使用
	@"char"									定义一个字符串常量
	@interface/@implementation/@protocol	声明一个接口/实现/协议
	@end									结束一个接口/实现/协议
	@class									声明为类
	@defs(class)							返回类结构变量的列表
	@public/@private/@protected				访问限定符
	@property(list)							声明为属性
	@try/@catch(exception)/@finally/@throw	错误处理
4.编译预处理#
宏定义
	#define 标识符 字符串
	#define 宏名(形参表) 字符串
	#undef 标识符
#运算符
	#define str(x) #x	//宏参数前加上#，则会创建C风格的字符串
条件编译
	#ifdef 标识符	//或	#ifndef
		宏1
	#else
		宏2
	#endif
	
	#if 常量表达式1
		宏1
	#elif 常量表达式2
		宏2
	#endif

一.数据、运算与变量
1.简单数据类型
整型		[unsigned]<short|int|long>
浮点型	<float|double|long double>	*后缀F/f
字符型	char
字符串	NSString*
id型		id			//万能类型Object*，自带指针
枚举型	enum
布尔型	BOOL
选择器	SEL			//指向方法的指针/函数指针
Class类	Class itsclass = [someObject class]	//获取someObject所在类的信息，返回值类型就为Class
nil		一个对象，其指针指向空；与C中NULL同义
Nil类	一个指向空的类
*OC也支持typedef类型别名
2.运算
强制类型转换
	(类型说明符)表达式

二.控制语句
1.条件
i.	if (表达式1){语句集1;}
	else if(表达式2){语句集2;}
	else{语句集3;}
ii.	switch(表达式)
	{
		case:语句集1;
		...
		case:语句集n;
		default:语句集n+1;
	}
iii.ans=表达式1?表达式2:表达式3

2.循环
i.	while(表达式)
	{语句集;}
ii.	do{语句集;}
	while(表达式);
iii.for(表达式1;表达式2;表达式3)
	{语句集;}
iv.	for(elmtType i in 数组)
	{语句集;}

3.跳转
break
continue
return

三.类
1.基本结构
/*类的声明*/
@interface 类名 : 父类名 {
	//变量定义
}
//方法定义
@end
/*类的实现*/
@implementation 类名
	//方法实现
@end
/*应用程序*/
#import <Foundation/Foundation.h>
int main(int argc, const char* argv[])
{
	NSAutoreleasepool* pool=[[NSAutoreleasepool alloc]init];
	//我的代码段
	[pool drain];
	return 0;
}
2.对象的声明/初始化
Person* p=[[Person alloc]init]
*OC中所有对象变量都是指针类型
3.变量
auto		自动局部变量，缺省
static		静态变量
const		常量变量
volatile	变量变量，用于多线程访问某个地址
extern		全局变量/外部变量，不属于任何方法，属于某个源程序文件
4.类属性及设取值
@property {属性列表} 实例变量;	//在.h中标识实例变量
	*属性列表常用取值：
		assign
		copy
		retain
		atomic/nonatomic
		readonly/readwrite
		getter=FuncName			//手动设置设取函数名，而非实例变量名
		setter=FuncName
@synthesize 实例变量;			//*在.m中整合实例变量，自动生成setter/getter方法
*点./箭头->运算符
	kahsolt.name	等价于[kasolt name]
	kahsolt->age=13	等价于[kasolt setAge:13]
*自身和父类指代
	self
	super
5.方法与参数
+|- (返回类型) 名字1:(类型1)参数1 名字2:(类型2)参数2 名字3:(类型3)参数3 ...;
	+(void)What;		//类方法
	-(NSString*)print;	//实例方法
	-(void)setX:(int)x setY:(int)y;	//多参方法声明，方法名为"setX:setY:"
	[point setX:2 setY:3]			//调用
	[point setX:2 :3]				//多参调用从第二个名字开始可省略
6.协议protocol：类似于Java中的接口
@protocol 协议名
	@required
		必选方法声明;	//缺省
	@optional
		可选方法声明;
@end
*遵守某协议：父类后用尖括号指示
	@interface Test:NSObject <Protocl1,Protocl2,...>
*协议扩展：协议的继承
	@protocol 协议名 <父协议名>
*检查对象是否遵守某个协议
	[someObject conformsToProtocol:@protocol(someProtocol)]==YES
7.异常处理
@try{//试运行代码块}
@catch(NSException* exception1){//异常处理1}
@catch(CustomException* exception2){//异常处理2}
...
@finally{//终处理}

@throw [NSException exceptionWithName:@"Heheda~"]	//抛出
8.指针
int(*ptr)[3]
char*(*ptr)[5]
类型：去掉指针名字
指向：去掉指针名字和名字左边的*
9.类别Category：为已存在的类增加方法
.h文件
	#import "类名.h"
	@interface 类名(类别名)
		//新方法声明;
	@end
.m文件
	#import "类名类别名.h"
	@implementation 类名(类别名)
		//新方法实现;
	@end
10.自定义初始化方法
-(Person*)initWithName:name Gender:gender Age:age;
{
    if(self=[super init])
    {
    	//一系列成员变量设置
        [self setName:name];
        [self setGender:gender];
        [self setAge:age];
    )
    return (self);
}

四.Foundation框架
1.NSNumber类
创建并初始化	numberWith-:	//相当于aNumber=[[NSNumber alloc]initWith-:]
初始化		initWith-:
取值			-Value
	其中-取大小写的Integer/Long/Float/Double/Char/Bool等
比较
	isEqualToNumber:(NSNumber)	//返回YES/NO
	compare:(NSNumber)			//返回NSOrderedAscending/NSOrderedSame/NSOrderedDescending
2.NSString类
	+(id)stringWithString:nsstring
	-(id)initWithString:nsstring
	+(id)stringWithContentsOfFile:path encoding:enc error:err
	-(id)initWithContentsOfFile:path encoding:enc error:err
	-(UNSIgned int)length
	-(unichar)characterAtIndex:i
	-(NSString*)substringFromInedx:i
	-(NSString*)substringToInedx:i
	-(NSString*)substringWithRange:range
	-(NSComparator*)compare:nsstring
	-(BOOL)hasPrefix:nsstring
	-(BOOL)hasSuffix:nsstring
	-(BOOL)isEqualToString:nsstring
	-(NSString*)capitalizedString
	-(NSString*)uppercasedString
	-(NSString*)lowercasedString
	-(int)intValue
	-(NSInteger)integerValue
	-(float)floatValue
	-(double)doubleValue
3.NSMutableString类
	+(id)stringWithCapacity:size
	-(id)initWithCapacity:size
	-(void)setString:nsstring
	-(void)appendingString:nsstring
	-(void)deleteCharactersInRange:range
	-(void)insertString:nsstring atIndex:i
	-(void)replaceCharactrsInRange:range withString:nsstring
	-(void)replaceOccurrencesOfString:nsstring withString:nsstring options:opts range:range
4.NSArray类
	+(id)arrayWithObjects:obj1,obj2,...,nil		//必须以nil结束
	-(BOOL)containsObject:obj
	-(NSUInteger)count
	-(NSUInteger)indexOfObject:obj
	-(id)objectAtIndex:i
*数组遍历
	NSArray* letters=[NSArray arrayWithObjects:@"A",@"B",@"C",nil];
	for(NSString* i in letters)
		[i print];
5.NSMutableArray类
	+(id)arrayWithCapacity:size
	-(id)initWithCapacity:size
	-(void)addObject:obj
	-(void)insertObject:obj atIndex:i
	-(void)removeObject:obj
	-(void)removeObjectAtIndex:i
	-(void)removeAllObjects
	-(void)replaceObjectAtIndex:i withObject:obj
	-(void)sortUsingSelector:(SEL)selecter
5.NSDictionary类
	+(id)dictionaryWithObjectsAndKeys:obj1,key1,obj2.key2,...,nil
	-(id)initWithObjectsAndKeys:obj1,key1,obj2.key2,...,nil
	-(unsigned)count
	-(id)objectForKey:key
	-(NSEnumerator*)keyEnumerator
	-(NSEnumerator*)objectEnumerator	
6.NSMutableDictionary类
	+(id)dictionaryWithCapacity:size
	-(id)initWithCapacity:size
	-(void)setObject:obj forKey:key
	-(void)removeObjectForKey:key
	-(void)removeAllObjects
7.NSSet类
	+(id)setWithObjects:obj1,obj2,...,nil
	-(id)initWithObjects:obj1,obj2,...,nil
	-(NSUInteger)count
	-(BOOL)containsObject:obj		//或者member:obj
	-(BOOL)isSubsetOfSet:nsset
	-(BOOL)intersectsSet:nsset		//是否存在交集
	-(BOOL)isEqualToSet:nsset
	-(NSEnumerator*)objectEnumerator
8.NSMutableSet类
	+(id)setWithCapacity:size
	-(id)initWithCapacity:size
	-(void)addObject:obj
	-(void)removeObject:obj
	-(void)removeAllObjects
	-(void)unionSet:nsset
	-(void)minusSet:nsset
	-(void)intersectSet:nsset
	
五.文件操作
1.NSFileManager类：文件和目录都可以视为文件
NSFileManager* fm=[NSFileManager defaultManager];
文件管理
	-(BOOL)contentsAtPath:path
	-(BOOL)createFileAtPath:path contents:(NSData*)data attributes:attr		//attr默认为nil
	-(BOOL)removeFileAtPath:path handler:handler
	-(BOOL)movePath:from toPath:to handler:handler
	-(BOOL)copyPath:from toPath:to handler:handler
	-(BOOL)contentsEqualAtPath:path1 andPath:path2
	-(BOOL)fileExistsAtPath:path
	-(BOOL)isReadableFileAtPath:path
	-(BOOL)isWritableFileAtPath:path
	-(NSDictionary*)fileAttributesAtPath:path traverseLink:(BOOL)flag
	-(BOOL)changeFileAttributes:attr atPath:path
目录管理
	-(NSString*)currentDirectoryPath
	-(BOOL)changeCurrentDirectoryPath:path
	-(BOOL)copyPath:from toPath:to handler:handler
	-(BOOL)createDirectoryAtPath:path attributes:attr
	-(BOOL)fileExistAtPath:path isDirectory:(BOOL)flag
	-(NSArray*)directoryContentsAtPath:path			//非递归的
	-(NSDirectoryEnumerator*)enumertorAtPath:path	//递归的
	-(BOOL)removeFileAtPath:path handler:handler
	-(BOOL)movePath:from toPath:to handler:handler
临时文件目录获取
	NSString* NSUserName()
	NSString* NSFullUserName()
	NSString* NSHomeDirectory()
	NSString* NSHomeDirectoryForUser(NSString* user)
	NSString* NSTemporaryDirectory()
	-(NSString*)lastPathComponents
	-(NSString*)pathExtension
	-(NSString*)stringByAppendingPathComponent:path
	-(NSString*)stringByAppendingPathExtension:ext
	-(NSString*)stringByDeletingLastPathComponent
	-(NSString*)stringByDeletingPathExtension
	-(NSString*)stringByStandardizingPath		//解析～/./../符号
2.NSData类：相当于缓冲区
NSData* fd=[fm contentsAtPath:@"Test.txt"]
	*NSData转NSString
	NSString* str=[[NSString alloc] initWithData:[fm contentsAtPath:path] encoding:NSUTF8StringEncoding];
3.NSFileHandle类
	+(NSFileHandle*)fileHandleForReadingAtPath:path
	+(NSFileHandle*)fileHandleForWritingAtPath:path
	+(NSFileHandle*)fileHandleForUpdatingAtPath:path
	-(NSData*)availableData
	-(NSData*)readDataToEndOfFile
	-(NSData*)readDataOfLength:(unsigned)bytes
	-(void)writeData:data
	-(unsigned long long)offsetInFile:offset
	-(void)seekToFileOffset:offset
	-(unsigned long long)seekToEndOfFile
	-(void)truncateFileAtOffset:offset
	-(void)closeFile
4.NSProcessInfo类
	+(NSProcessInfo*)processInfo
	-(NSArray*)arguments
	-(NSDictionary*)environment
	-(int)processIdentifier
	-(NSString*)processName
	-(NSString*)globallyUniqueString
	-(NSString*)hostName
	-(NSUInteger)operatingSystem
	-(NSString*)operatingSystemName
	-(NSString*)operatingSystemVersionString

六.内存管理
1.基本
申请内存alloc
	alloc创建的对象需要用release释放，被设置为autorelease的对象除外
*例如：
	NSNumber* a=[[NSNumber alloc]initWithFloat:1.5];	//使用alloc创建的必须手动release
	NSNumber* b=[NSNumber numberWithFloat:1.5];			//不是alloc的可以不管
	[a release];
释放内存dealloc
	-(void)dealloc		//类似析构函数
	{
		[someAllocedObj release];
		[super dealloc];
	}
	release对象内的变量后，让父类来清除整个对象
2.引用计数retainCount
*用alloc/copy创建一个对象时，计数器为1
 用[obj retain]时，计数器+1
 用[obj release]时，计数器-1
 当计数器为0时，系统自动调用dealloc方法
3.自动释放池NSAutoReleasePool类
	NSAutoReleasePool* pool=[[NSAutoReleasePool alloc]init];
		//obj被放入自动释放池中，系统自动检查并释放计数器为0的对象
		[obj autorelease]
	[pool drain];	//释放池中所有对象
	[pool release];	//释放池子本身，也会释放所有对象

七.数据保存
1.NSData/NSString/NSNumber/NSDate/DSArray/NSDictionary对象读写
	[NSKVobj writeToFile:path atomically:YES];	//写入XML文件
	[NS- -WithContentOfFile:path];	//读出XML文件，-用类型名取代
2.NSKeyedArchiver类<NSCoding>协议
	*手动实现encodeWithCoder:和initWithCoder:方法
	archiveRootObject:toFile:	//存储
	unArchiveObjectWithFile:	//读取
