<?PHP
	/*PHP超文本解析脚本语言，
	  可以混在HTML文本里，
	  代码用<?PHP ?>括起来*/
	//语句间有分号隔离
	# 单行注释也可以用井号
	print("Hello PHP！");
?>

零.元结构
1.引入
include('some.php');	//引入
require('another.php');	//在一个php文件中只解释引入第一个，之后的require命令会被忽略
require_once('another.php');
2.Cookie
	setcookie('var','data',存活时间，缓存路径，网域名称，是否安全模式);
		*存活时间可以是：
			time()+100	缓存100秒
			maketime(24,0,0,1,1,2100)	缓存至公元2100年1月1日24:00:00
	setcookie('var');	//删除某个cookie
3.Seesion：使用前不能向浏览器有(HTML/JS等的)输出
	sesion_start();	//开启Session表
	session_register('var');$var=3;session_unregister('var');	//注册|注销一个session变量
	session_unset();	//注销所有seesion变量
	session_destroy();	//删除Session文件
	session_is_registered('var');	//返回变量是否已被注册

一.基础
1.数据类型
	boolean
	integer
	float
	string	单引号字符串不转义
	array
	object
*强制类型转换
	$d=(integer)$f;
2.运算符
	赋值	=
	算数	支持四则运算和四则赋值运算
	位运算	支持位运算
	比较	==		等于
			!=/<>	不等
			===		全等，要求对象类型相同
			!==		不全等，值不等或者类型不同
	执行	··		反引括号，相当于shell_exec()执行一个系统命令
	自增	++|--
	逻辑	&&等效于and，||等效于or，非!，异或xor
	连接	.		点号，用于字符串连接$a.="Hello"等效于$a=$a."Hello"
3.变量
	常量	define("PI",3.1415926);echo(PI);	注意define中常量名要加引号
	变量	$var	以$开头的标识符
	地址	$a=&$b	用&取地址
	超全局变量
		$GLOBALS	所有全局变量
		$_SERVER	保存关于报头、路径和脚本位置
		$_REQUEST	收集 HTML 表单提交的数据
		$_POST		收集 method="post" 的数据，也常用于传递变量
		$_GET		收集 method="get" 的数据，也用于收集 URL 中的发送的数据
		$_FILES		HTTP 文件上传变量
		$_ENV		通过环境方式传递给当前脚本的变量的数组
		$_COOKIE	HTTP Cookies
		$_SESSION	先使用session_start();-启动新会话或者重用现有会话，才能使用；unset($_SESSION["newsession"]);取消一个对象变量
4.语句结构
	条件
		if(){}
		elseif(){}
		else{}
	选择
		switch()
		{case :break;
		default :break;}
	循环
		while(){}
		do{}while()
		for(;;){}
		foreach($arr as [$key=>] $value){}
		*break/continue

*应用：表单
/*Form.html*/
	<form id="login" name="login" method="post" action="ShowInfo.php">
	<table width="200" border="1" align="canter" summary="芝麻开门~">
		<caption>
			管理员登录
		</caption>
		<tbody>
			<tr><td>
				账号：<br />
				<input type="text" id="username" name="username"/>  <!--POST用name字段来作键值对-->>
				密码：<br />
				<input type="password" id="password" name="password"/>
			</td></tr>
			<tr><td>
				<input type="reset" id="reset" name="reset" value="重置"/>
				&nbsp;
				<input type="submit" id="submit" name="submit" value="登录"/>
			</td></tr>
		</tbody>
	</table>
	</form>
/*ShowInfo.php*/
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<?PHP 
	/*$_POST接收一个POST方法传来的数据表*/
	if($_POST['submit']) {
		echo("下面是信息\n");
		echo("账号：".$_POST['username']."\n"); //$_POST按照name字段来查找键值对
		echo("密码：".$_POST['password']."\n");
	}
	else
		echo("并没有信息_(:з」∠)_");
?>
*网址参数
	http://<网址>/<文件名>?<参数>=<值>[&<参数n>=<值n>]
	在PHP中用$_GET['参数名']获取

二.高级
1.数组(键值对列表)
定义：	array([key=>]value,[[key=>]value,,...])
	*默认key为从0起的序列
	$arr=array('Type'=>"Ursa","CPU Core"=>4);
	$arr2=arry('Line1'=>array(1,2),'Line2'=>array(3,4);	//多维数组
增加：
	$arr[3]="ABC";	关键字为3的值改为/设为"ABC"
	$arr[]=50;	末尾追加，自动分配关键字
多维数组：直接填充式赋值使用
	$arr2[2][4]="hehe"
*数组内嵌函数：
	int count($arr)	长度
	void print_r(array arr)	数组友好打印
	array array_change_key_case(array arr,CASE_LOWER|CASE_UPPER)	返回一个关键字全部大小写之后的数组
	array array_count_values(array arr)	重复值归类统计
	array array_fill(int index,int num,mixed value)	返回从index关键字起填充num个value值数组
	bool array_key_exists(mixed key,array arr)	查找arr数组中是否已经存在key
	array array_keys(array arr[,mixed search_value])	检查所有关键字
	array array_values(array)
	array array_merge(array arr[,array arr2[,...]])	数组合并，后值覆盖前值
	mixed array_pop(array &arr)
	int array_push(array,value[,value...])
	array array_reverse(array)
	number array_sum(array)
	array array_unique(array)
	array asort(array)	升序排序
	array arsort(array)	降序排序
	*遍历数组
		for($i=0;i<sizeof($arr);i++) {
			echo(current($arr)." ");	#echo当前指针下的数据
			next($arr);		#指针后移
		}
		foreach($a in $arr)
			echo($a." ");
2.函数
定义：
	function 函数名(参数表=默认值) {	//传递引用则形参要前缀&符号
		global 全局变量表;	//声明使用全局变量
		<函数体>
		return 返回值;
	}
	*调用：函数名(实参表);
不定参数函数：
	function 函数名() {	//形参表留空
		params_arr=func_get_args();	//获取所有参数	
		for($i=0;$i<func_num_args();$i++)	//获取参数个数
			echo("第".$i+1."个参数：".func_get_args($i));	//获取指定编号的参数
	}
3.类
定义：
	[abstract] class 类名 extends 父类名{
		/*属性表*/
		var $i;
		public $pub;
		private $prvt;	//类内访问：$this->prvt，注意后者没有$前缀
		static public $stat;	//静态变量，类内访问：self::$stat			
		
		/*方法组*/
		public function __construct() {
			//构造函数
		}
		public function __destruct() {
			//析构函数
		}
		public function __clone() {
			//深拷贝函数，定义之后会自动调用此函数，而非进行浅拷贝
			$this->vars = clone $this->vars;	//类的所有成员var都要拷贝一次
		}
		abstract function AbstrctFunc();	//抽象函数没有方法体
		function Func(){};
	}
	*对象声明：$dog=new Dog("Ks","Boew!");
	 对象浅拷贝：$dogge=clone $dog;
	 属性和方法访问：echo("$dog->name");$dog->Bark();
	*对象类型判断
		if($object instanceof Human){};

三.更高级
1.嵌入Javascript脚本
结构：
	<script language="javascript">
		document.write("在这里写JS代码咯~");
		document.close();
	</script>
数据类型：
	数值
	字符串
	布尔	True或False
	空		null
变量：
	[var] x=2;
	*运算符同C++语言
语句：
	if(){}else if(){}else{}
	while(){}
	for(;;){}
	*break/continue
内置类：
	Array(initLen)
		length
		join(",")
		reverse()
		sort()
	Date("1995-6-3")
		set|get系列()
		toString()
		valuOf()
	Math
		random	0~1伪随机数
	String
		length
		一系列与HTML交互的函数()
	Navigator：包含一系列常用子类
		document.write()
		window.alert()
		window.confirm()
		window.prompt()
		window.open(url,窗口名，属性列表)
2.文件系统编程
磁盘信息
	disk_free_space("C:\\")
	disk_total_space("D:\\")
目录操作
	函数：
		chdir("..\Web")
		opendir()
		readdir()
		rewinddir()
		closedir()
		isdir()
		mkdir()
		rmdir()
	类：dir
		path
		handle
		dir(path)	构造函数
		read()		读取一个文件
		rewind()	重置目录句柄
		close()
文件操作
	basename()
	dirname()
	pathinfo()
	filesize()
	filetype()
	copy()
	rename()
	unlink()	删除
	is_executable()
	is_file()
	is_readable()
	is_writable()
	file_exists()
	parse_ini_file()
	fopen(filename,"r+")
	...一系列兼容C的文件操作函数

*应用：文件上传
	参见PHP文件夹

四.数据库：与MySQL关联的mysqli
0.引用链接库
	在php.ini中启用extension=php_mysqli.dll，启用ext目录
1.基本流程
	$mysql=mysqli_connect("localhost","root","passwd","library");
	if(empty($mysql)) {
		die("Connection Failed: ".mysqli_connect_error());
	}
	mysqli_query($mysql,"SET NAMES utf8");
	$result=$mysql->query("SELECT * FROM book");
	while($row=$result->fetch_row()) {
		print_r($row);
	}
	$result->free();
	$mysql->close();
	
*应用1：分页
分页显示函数
function getPageCount($table) {
	$PageSize=10;
	
	$result=$mysql->query("SELECT COUNT(*) FROM ".$table);
	$row=$result->fetch_row();
	$RecordCount=$row[0];
	
	if($RecordCount) {
		if($RecordCount<$PageSize)
			$PageCount=1;
		elseif($RecordCount%$PageSize)
			$PageCount=$RecordCount%/PageSize+1;
		else
			$PageCount=$RecordCount%/PageSize;
	}
	else $PageCount=0;//查询失败，默认返回0条记录
	return $PageCount;
}
function getPageContent($table,$PageNumber,$PageSize) {
	$PageResults=mysql->query("SELECT * FROM ".$tabel." LIMIT ".($PageNumber-1)*$PageSize.",".$PageSize);
	return $PageResults;
}
网址参数传递
	http://localhost/viewPage.php?page=2
参数接收
	$page=$_GET['page'];
	if($page==0)$page==1;//界修正
翻页连接
	echo("<a href=viewPage.php?page=1>首页</a>");
	echo("<a href=viewPage.php?page=".($PageNumber-1).">上一页</a>");
	echo("<a href=viewPage.php?page=".($PageNumber+1).">下一页</a>");
	echo("<a href=viewPage.php?page=".$PageCount.">末页</a>");

*应用2：登录
1.数据库创建
CREATE DATABASE Ksland COLLATE 'gb2312_chinese_ci';//Ksland是数据库名
CREATE TABLE User(
	Username VARCHAR(50) PRIMARY KEY,
	Password VARCHAR(50),
	DisplayName VARCHAR(50)
);
2.定义访问类
/*../Class/User.php*/
class User {
	var $mysql;
	
	public $Username;
	private $Password;
	public $DisplayName;
	
	function __construct() {
		$this->$mysql=mysqli_connect("localhost","root","passwd","Ksland");
		mysqli_query($mysql,"SET NAMES gbk");
		if(empty($mysql)) {
			die("Connection Failed: ".mysqli_connect_error());
		}
	}
	function __destruct() {
		$this->mysql_close();//或者mysql_close($this->mysql);
	}
	
	function loadUsers() {
		$result=$this->mysql->query("SELECT * FROM User");
		return $result;
	}
	function addUser() {
		//此处有效性判断
		$this->mysql->query("INSERT INTO User VALUES(".$this->Username.",".$this->Password.",".$this->DisplayName.")");
	}
	function deleteUser() {
		$this->mysql->query("DELETE FROM User WHERE Username=".$this->Username);
	}
	function isUserExist($username) {
		$result=$this->mysql->query("SELECT * FROM User WHERE Username=".$username);
		if($row=$result->fecth_row()) {
			$this->Username=$usename;
			$this->Password=$row[1];
			$this->DisplayName=$row[2];
			return true;
		}
		else
			return false;
	}
	function isVerified($username,$password) {
		$result=$this->mysql->query("SELECT * FROM User WHERE Username=".$username." AND Password=".$password);
		if($row=$result->fecth_row()) {
			$this->Username=$usename;
			$this->Password=$password;
			$this->DisplayName=$row[2];
			return true;
		}
		else
			return false;
	}
}
3.登录模块
<?PHP
include("User.php");
$user=new User();
if(!isset($_SESSION['Passed']))
	$_SESSION['Passed']=false;
if(!$_SESSION['Passed']) {	//未登录
	$Username=$_POST['Username'];
	$Password=$_POST['Password'];
	if(empty($Username)||empty($Password))
		$ErrorMsg="请输入用户名和密码~";
	else
	{
		if(!$user->isVerified($Username,$Password))
			$ErrorMsg="用户名或密码不正确的啦……";
		else {
			$_SESSION['Passed']=true;	//登陆成功
			$_SESSION['Username']=$Username;
			$_SESSION['Password']=$Password;
			$_SESSION['DisplayName']=$DisplayName;
		}
	}
>
	<!--还未登陆成功，则画出登录表单-->
	<html>
		<body>
			<form>BLABLABL</form>
		</body>
	</html>
<?PHP
}
else {
>
	<!--已经登录-->
	<html>
		<body>
			<p>已经登录了哦~</p>
		</body>
	</html>
<?PHP
}
?>
