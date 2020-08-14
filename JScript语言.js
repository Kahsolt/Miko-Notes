//JScript是Microsoft对ECMA 262语言规范的一种实现
/*这是多行注释*/

零.基础
0.变量声明
	var count;  // 单个声明
	var count, amount, level;  // 用单个 var 关键字声明的多个声明
	var count = 0, amount = 100;  // 一条语句中的变量声明和初始化
	noStringAtAll = ""; // 隐式声明变量 noStringAtAll。
	*未赋值变量自动取值 undefined
1.数据类型
	字符串
		'"Avast, ye lubbers!" roared the technician.' 
		"42"
	数值
		整型值
		浮点值
		特殊值数字
			NaN
			正无穷大和负无穷大 
			正0和负0
	布尔
		true
		false
	对象 
	数组
	Null
		该变量没有保存有效的数、字符串、Boolean、数组或对象
	Undefined
		对象属性不存在，或着声明了变量但未赋值
		检测方法
			if (typeof(x) == "undefined")	//对于单变量
				// 作某些操作
			if ("prop" in someObject)		//对于对象的属性
				// someObject 有属性 'prop'
2.运算符
	%	模除
	!=	不等
	===	严格相等，不自动类型转化
	!==	不严格相等，不自动类型转化
	>>>	无符号右移
	new
	delete
	typeof
	instanceof
	void
	in
3.控制结构
	if..else..
	?:
	switch..case
	while
	do..while
	for..in
	for
4.函数
	function 函数名(参数表) 
	{
	   //函数体
	   return <返回值>;
	}
5.对象：类似于字典
	var myObj = new Object();
	myObj.name = "Fred";	// expando 属性
	myObj.age = 42;
	myObj["not a valid identifier"] = "This is the property value";
	myObj[100] = "100";
6.数组：自带length属性的Object
	var myArray = new Array(3);
	myArray[0] = "Hello";
	myArray[1] = 42;
	myArray[2] = new Date(2000, 1, 1);
	window.alert(myArray.length);
	// 添加某些 expando 属性
	myArray.expando = "JScript!";
	myArray["another Expando"] = "Windows";
	// 仍然显示 3，因为两个 expando 属性并不影响长度。
	window.alert(myArray.length);
	*多维数组需要用多个一维数组去嵌套生成
7.伪类
	function pasta(grain, width, shape, hasEgg)
	{
		// 是用什么粮食做的？
		this.grain = grain;
		// 多宽？（数值）
		this.width = width;     
		// 横截面形状？（字符串）
		this.shape = shape;   
		// 是否加蛋黄？（boolean）
		this.hasEgg = hasEgg;
		// 这里添加 toString 方法（如下定义）。注意在函数的名称后没有加圆括号；
		// 这不是一个函数调用，而是对函数自身的引用。
		this.toString = pastaToString;
	}
	function pastaToString()
	{
		// 返回对象的属性。
		return "Grain: " + this.grain + "\n" +
			"Width: " + this.width + "\n" +
			"Shape: " + this.shape + "\n" +
			"Egg?: " + Boolean(this.hasEgg);
	}

	var spaghetti = new pasta("wheat", 0.2, "circle", true);
	var linguine = new pasta("wheat", 0.3, "oval", true);
	// spaghetti 的附加属性。
	spaghetti.color = "pale straw";
	spaghetti.drycook = 7;
	spaghetti.freshcook = 0.5;
	var chowFun = new pasta("rice", 3, "flat", false); // chowFun 对象或其他现有的 pasta 对象都没有添加到 spaghetti 对象的三个新属性。
	// 将属性‘foodgroup’加到 pasta 原型对象中，这样 pasta 对象的所有实例都可以有该属性，包括那些已经生成的实例。
	pasta.prototype.foodgroup = "carbohydrates"
	// 现在 spaghetti.foodgroup、chowFun.foodgroup，等等均包含值“carbohydrates”。