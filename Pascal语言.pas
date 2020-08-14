{Pascal是C时代的编译型语言}
//但是大小写不敏感

零.程序框架
program 程序名;
uses
  已知单元说明;
label
  标号说明;
const
  常量说明;
type
  类型说明;
var
  变量说明;
function
  函数说明;
procedure
  过程说明;
begin
  语句;
  语句;
end.

一.基础集
1.标准保留标识符
常量
  false/true/maxint/nil
类型
  integer/real/boolean/char/text
过程
  read/readln/write/writeln/new/get/put
  pack/unpack/page/reset/rewrite/dispose
函数
  exp/ln/sqr/sqrt/pred/succ/abs
  sin/cos/arctan/round/trunc/odd/ord/chr/eof/eoln
文件
  input/output
2.算符
  div	//整除
  mod
  =	//逻辑等于
  <>	//逻辑不等
  not/add/or/xor/shl/shr	//位运算
3.常量变量
const
  Pi=3.1415;
  E=2.718;
var
  width, height:interger;
  price:real;
begin
  price:=5.2;	//变量可以赋值
end.
4.数组
type
  myArray=array[1..20] of integer;	//数组名=array[下标1..下标2] of 类型;
  duoArr=array[1..10, 1..10] of char;
var
  dist:myArray;	//数组作为一个类型
  dictionary:array['A'..'Z'] of real;	//数组
  duArray:array[1..10] of array[1..10] of char;	//二维数组
begin
  dist[1]:=0;
  duArray[1][0]='A';
  duArray[1,1]='B';
end.
5.字符串
type
  str=string[100];	//[]省略时默认为255个字符
var
  s, p:str;
begin
  s='Hello world!';
  p='Hallo';
  write(s,p);
{ 字符串处理函数
  len:=length(s);
  copy(st,m,n);
  s:=concat(s1,s2,s3);
  delete(st,m,n);
  idx:=pos(substr, motherstr);
  insert(src, dist, idx);
  val(s,n,errorcode);
  str(x,s);
}
end.
6.输入输出
read(price);
readln(a,b,c);		//读取一行后逐个填值，多余的舍弃
readln;			//读一行并舍弃
write('A','B','C');	//等价于write('ABC');
writeln;		//写一个空行
writeln('P=', price);
writeln(10:8);		//域宽为8
writeln(3.14159:8:3);	//域宽为8，其中小数3位

二.控制结构
顺序
  begin <语句集>; end;
条件
  if <布尔> then 语句;
  if <布尔> then 语句 else 语句;
分支
  case 表达式 of
    值表: 语句;
    值表: 语句;
    ...
    [else: 语句;]
  end;
枚举
  for i:=1 to 100 do <语句>;
  for i:=100 downto 1 do <语句>;
循环
  while <布尔> do <语句>;
重复
  repeat
    语句;
    ...
    语句;
  until <布尔>;
*循环控制
  continue;
  break;
  halt;		//终止程序
  exit;/exit();	//递归时返回到上一层函数

三.函数过程
函数
  function 函数名(形参表):函数类型;	//函数必有返回值
  var
    函数局部变量;
  begin
    函数体;
    [exit(返回值);]	// 或者 函数名:=返回值;
  end;
过程
  procedure 过程名(形参表;var 传出参数表);	//传出参数必须是定义过的全局变量
						//无参数时可省略形参表，不返回时可省略返回类型
  var
    过程局部变量;
  begin
    过程体;
  end;
调用
  函数名;
  函数名(参数列表);

四.高级结构
1.文件
const
  fin='a.in';
  fout='a.out';
var
  a,b,c:integer;
procedure testfile;
begin
  assign(input, fin);	//建立文件指针
  reset(input);		//打开只读文件
  read(a,b,c);
  close(input);
  assign(output, fout);
  rewrite(output);
  writeln(a,b,c);
  close(output);
end;

2.枚举
type
  color=(red,blue,green);
  day=(Mon,Thus,Wedn,Thur,Fri,Sat,Sun);
var
  a,b;color;
  c,d:day;
  
3.子界
type
  age=18..60;
  number=0..100;
  character:'A'..'Z';
var
  a:age;
  n:number;
  
4.集合
type
  numbers=set of 1..100;
  lowercases=set of 'a'..'z';
  colors=set of color;
var
  n:numbers;
  ch:lowercases;
  
5.记录
type
  Student=record
    ID:integer;
    name:string[100];
    age:integer;
  end;
var
  stu:Student;
begin
  stu.ID=14211050;
  stu.name='Kahsolt';
  with stu do	//开域语句
  begin
    age=13;
    writeln(ID:12,name:32,age:4);
  end;
end;  

五.指针
type
  pnode=^node;
  node=record
    data:integer;
    next:pnode;
  end;
var
  list,n1,n2,n3,p:pnode;
begin
  new(n1);
  new(n2);
  new(n3);

  list:=n1;
  n1^.next:=n2;
  n2^.next:=n3;
  n3^.next:=nil;
  
  n1^.data:=1;
  n2^.data:=3;
  n3^.data:=7;

  p:=list;
  while p<>nil do
  begin
    writeln(p^.data:8);
    p:=p^.next;
  end;
end.
  
