%Prolog是一门逻辑型语言，基本原理为Horn子句的消去规则
%这里例举Swi-Prolog的实现

零.流程
1.写知识库KnowledgeBase.pl
	事实：已知的要素
		关系(对象1, 对象2, ...).
		likes(kahsolt, dog).
	规则：从已知事实进行推断
		规则头:- 规则体
		likes(kahsolt, Something):-
      colorful(Something).
2.载入kb.pl源文件
    [myKb].
    consult('myKb.pl').
    [user].   % pseudo file for adding rules on console
3.询问
	likes(kahsolt, What).

一.语法
0.常用语句
    pwd.|cd.|ls.|shell(:Cmd).
    consult(:File). % or just [:File]
    edit(file('test.pl')).
    make.           % reload file changes
    listing.        % show predictats in current ENV or decompile
    help(+What).|apropos(Pattern).|explain(+Object).
    trace.|gtrace.  % enter debug mode
    halt.|statistics.
    !h.             % history command help list
1.类型
    数字
    字符串
    原子  小写字母开头
    变量  大写字母或单下划线开头
    复合  一系列关系嵌套
2.逻辑运算
    ;   或
    ,   且
3.代数运算is
    12 is 6 * 2.
    -2 is 6 - 8.
    3 is 6 / 2.
    3 is 7 // 2
    R is mod(7, 2).