/*JavaScript是基本上成为了通用Web语言*/
//但是建议只用这种注释

零.杂
0.html引入js文件
<script type="text/javascript" src="main.js"></script>

一.基础
0.数据类型
  布尔  true/false
    *布尔假值：undefined/null/0/NaN/false/''
  数值  64位的浮点数
    *特殊值：NaN/Infinity
  字符串   'squote' or "dquote"
  对象     null
  未定义   undefined
*查看类型：typeof x
*类型转换: Number(str)/parseInt(str, base)/parseFloat(str, base)
1.变量
  var x = 5;
  var y = new func();   //函数为对象搭建结构 (FIXME: ?)
2.操作符
  ==/!=     // 值相等
  ===/!==   // 值和类型相等
  +         // 加法/字符串连接
  in        // 判断在数据结构中
3.函数
  function foo(x) { }
  var add = function(a, b) {    //函数字面量，匿名函数
    return a + b;
  }
  var sub = (a, b) => { return a - b }  // Lambda
4.数据结构
  var empty_obj = {}
  var empty_array = []
  var obj = { "A": 1, "B": 2}
  var array = [ 1, 2, 3, 4, 5 ]
  var keyName = { "what-is": "dog", who_is: "ks" }  //键名是合法标识符则不必加引号，否则需要引号
  var obj = { obj2: { obj3: 123 } }    //嵌套
  x = obj.attr
  x = obj["attr"]   //点号和中括号两种方式等效
  x = obj.notattr   //树形不存在时返回undefined
  x = obj.notattr || "<Non>"  //设置默认值
  delete obj.attr   //可能会使得原型链上游的属性暴露出来
5.原型继承
  字面量对象连接到Object.prototype
  函数对象连接到Function.prototype

二.控制结构
1.遍历数组
array.forEach(function(x) { console.log(x); });
for (var i = 0; i < array.length; i++) {
  var x = array[i];
}
2.枚举字典
for (var key in object) {
  if (object.hasOwnProperty(key)) {
    var x = object[key];
  }
}
3.异常处理
try {
  throw {name: 'TypeError', msg: 'Need to be numbers'};
} catch (error) {
  alert('Exception caught');
}