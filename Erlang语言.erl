%aErlang是一个执着于并发的函数式语言
%每个语句以句号.结束

零.解释器
q().		退出解释器
f(V).		变量解绑定，仅终端有效
m(Mod).		查看模块概览，仅终端有效

一.数据与类型
1.整数类型
  0/5/-15		十进制
  999999999999	可以任意大
  2#1010
  -16#FE
  +7#123456		其他进制(36以内)，以井号#注明基底并前置符号位
  $A/$-等		$运算，取ASCII字符对应数值
2.浮点数类型
  1.2/-5.7
  E-10
  1.234E-5		科学记数法
3.算数运算符
  +|-|*|/	对整数、浮点数有效(加、减、乘、浮点除)
  div|rem	对整数有效(整除、取余)
4.原子类型(atom)：文字常量
  name
  hash_table
  kahsolt@hospital			以小写字母开头，可用[a-zA-Z0-9@_]
  'Hello world'
  '\n\r'
  'any#thing&you\tcan/type'	以单引号封装，则可用任意字符
5.布尔类型
  true/false
  1==2
  a>z
  less<=more
6.逻辑运算符
  and/andalso	非短路/短路与
  or/orelse		非短路/短路或
  xor
  not
7.元组类型{}：通常代表一个对象
  {}
  {what, is, 123}
  {person, 'Kahsolt', {'weight', 35.5}}
  {1,3}<{2,3}	可以作比较运算
  *操作函数
    tuple_size(tup).			获取tup中元素个数
    element(idx, tup).			获取索引idx处的元素(idx从1开始计数)
    setelement(idx, tup, val).	设置tup索引idx处的元素为val
8.列表类型[]：通常代表对象集合
  []
  [1,2,'3']
  [[1],[b, "ch"], 'd']
  [{Heron},{Lista, Rotza}]
  *专有运算符
    [|]		[1,2]==[1|[2]]		构造器：籍由递归定义List::=[element | List] or []
    ++		[1,2]++[2]			列表连接
    --		[1,1,2]--[1]		列表差(右结合性)
    <无>	"Hello" "world"		字符串连接的语法糖
  *操作函数
    list:max(ls)
    list:last(ls)
    list:sum(ls)
    list:reverse(ls)
    list:member(val, ls)
    list:split(idx, ls)
    list:delete(idx, ls)
    list:nth(idx, ls)
    list:zip(ls1, ls2)
    length(ls)
9.字符/字符串伪类型
  字符用其对应的ASCII整数表示，也可语法糖写作$A之类
  字符串用ASCII整数列表表示，也可语法糖写作"Hello"之类
10.比较运算符
  ==|/=			等于|不等(自动类型同化，然后仅比较值)
  =:=|=/=		精确等于|任意不等(同时比较类型和值)
  <|>|=<|>=		!注意等于小于号是=<
  *类型比较序
    number<atom<reference<fun<port<pid<tuple<list<binary
    !因此跨类型如11<ten、{123}<[]也是可比较的
    *类型判断函数：is_*()
      其中*取：number/integer/float/atom/boolean/tuple/list
  *集合规则
    列表：逐元素比较值
    元组：先比较元素数目，等长则再逐元素比较值
11.变量：只能一次赋值，都是局部变量
  _pattern
  What
  IsDebugMode
  Name_Given	以大写字母/下划线开头，可用[a-zA-Z0-9_]
12.模式匹配=：提取值
  []=[]			完美匹配(但没有变量来提取值)
  [X,X]=[1,1]		匹配成功，产生绑定X=1
  [Y,Y]=[2,3]		匹配失败
  [H|T]=[1,2,3]	匹配成功，产生绑定H=1和T=[2,3]
  [A,B|C]=[1,2,3,4]
  {A, _, [B|_],{B}}={abc, 23, [22,23], {22}}		通配符_表示任意匹配且不产生绑定
  {_, Name, Age}={person, "Kahsot", 13}
13.函数->
  函数参数用于模式匹配，只执行第一个匹配的簇
  语句块的语句间用逗号,分隔
  函数簇间用分号;分隔
  函数定义以句号.结束
函数簇例子：
  area({square, Side}) ->
    Side * Side;
  area({circle, Radius}) ->
    math:pi() * Radius * Radius;
  area({triangle, A, B, C}) ->
    S=(A+B+C)/2,
    math.sqrt(S*(S-A)*(S-B)*(S-C));
  area(Other) ->
    {error, invalid_object}.
递归例子：
  factorial(0) -> 1;
  factorial(N) ->
    N * factorial(N-1).
14.模块
定义模块
  % demo.erl
  -module(demo).		% 模块名必须与文件名一致
  -export([double/1]).	% 导出一个函数(函数名/参数个数)

  double(Val) ->
    times(Val, 2).
  times(X, Y) ->		% 未被导出即私有工具函数
    X * Y.
使用模块
  c(demo).				% 编译demo.erl模块，产生demo.beam字节码文件
  demo:module_info().	% 查看模块概览，或者终端语法糖m()
  demo:double(10).		% 以全限定名调用导出函数



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% demo.erl
-module(demo).        % 模块名必须与文件名一致

-export([double/1]).  % 导出一个函数(函数名/参数个数)
-export([fact/1]).
-export([convert/2]).
-export([convert_length/1]).

double(Val) ->
  mult(Val, 2).
mult(X, Y) ->
  X * Y.

fact(1) -> 1;
fact(N) ->
  N * fact(N - 1).

convert(M, inch) ->
  M / 2.54;
convert(N, centimeter) ->
  N * 2.54.

convert_length({centimeter, X}) ->
  {inch, X / 2.54};
convert_length({inch, Y}) ->
  {centimeter, Y * 2.54}.


