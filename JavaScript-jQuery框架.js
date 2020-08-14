// http://jquery.com/ 优秀的前端js框架

一.DOM对象与jQuery对象
0.概念
  父元素	直接上级
  子元素	直接下级
  兄弟元素	拥有相同的父元素
  祖先元素	直接及间接上级
  后代元素	直接及间接下级
1.构造
DOM对象
  var test=document.getElementByTagName("h3");
  var testHTML=test.innerHTML;
jQuery对象
  var $test=$("h3");	// 建议jQuery对象都前缀$命名以示区别
  var testHTML=$test.html();
转换
  jQuery转DOM
    var test=$("li").get();	// 获取所有<li>的DOM对象数组
    var test=$("li").get(5);	// 获取第五个<li>对象
    var test=$("li")[5];
  DOM转jQuery
    var $test=$(document.getElementByTagName("li"));	// 调用构造函数$()即可
2.选择器
基本选择器
  *		$("*")
  element	$("p")
  #id		$("#username")
  .class	$(".w3-container")
    *组合	$("div.menu")		// 选取class=menu的<div>
过滤选择器
  基本(所有结果无差别连接成数组)
    :first	$("p:first")
    :last	$("p:last")
    :even	$("p:even")
    :odd	$("p:odd")
    :eq(idx)	$("p:eq(-1)")
    :gt(idx)	$("p:gt(6)")
    :lt(idx)	$("p:lt(10)")
    :not(sel)	$("p:not(:lt(3), .hide)")// 指定一组用于排除的选择器
    :header	$("p:header")
    :animated	$("p:animated")
  子元素(在每一组兄弟元素间筛选，类似聚合函数group by)
    :first-child
    :last-child
    :only-child
    :nth-child(idx)		// 选每组中序号为idx的元素
    :nth-child(odd|even)	// 此处odd和even为不加引号的字面字符串
    :nth-child(equation)	// 方程必须形如xn/xn+y/xn-y/-xn+y，例如 3n+1 为不加引号的字面字符串
  内容
    :contains(text)	// 内部html文本含有指定字符串
    :has(sel)		// 如$("div:has(p)")，含有指定选择器的元素
    :parent		// 选取含有后代或文本非空的元素
    :empty		// 选取没有后代或文本为空的元素
  可见性
    :hidden		// display=none，input[type="hidden"]，宽高为0
    :visible
  属性
    [attr]		// 使用了属性attr的元素
    [attr=val]		// 属性值等于val
    [attr!=val]		// 属性值不等于val
    [attr~=val]		// 属性值以空格拆散，其中有片段的值为val
    [attr^=val]		// 属性值以val开头
    [attr&=val]		// 属性值以val结尾
    [attr*=val]		// 属性值含有val
      *多个属性	$("div[class=top][id]")
层次选择器
  sel1 sel2	从sel1选出的后代元素中按sel2再选
  sel1>sel2	从sel1选出的子元素中按sel2再选
  sel1+sel2	从sel1选出的第一个兄弟元素中按sel2再选
  sel1~sel2	从sel1选出的所有兄弟元素中按sel2再选
表单选择器
  :input	// 选input/textarea/select/button
  :text		// 即$("input[type=text]")，下同
  :password
  :radio
  :checkbox
  :image
  :file
  :hidden
  :button
  :submit
  :reset
  :enable
  :disable
  :checked	// 用于input(通常应该是type=checkbox)
  :selected	// 用于<option>
3.元素再筛选(相对路径选择)
  .child(sel)	// 在子元素中选择，sel为空时默认全选
  .find(sel)	// 在后代元素中选择，sel为空时默认选空
  .contents()	// 选择其子元素和文本块
  .parent()	// 在父元素中选择
  .parents()	// 在祖先元素中选择
  .parentUntil(sel)	// 选择祖先，直到遇到匹配sel的元素停止
  .offsetParent()
  .closest()
  .next()/.prev()	// 下/上一个兄弟元素
  .nextAll()/.prevAll()/.siblings()
  .nextUntil()/.prevUntil()
  .add(sel)	// 并集
  .andSelf()	// 并上当前
  .eq()/.first()/.last()
  .slice()
  .filter()/.not()
  .has()
  .end()	// 还原

二.文档处理
1.移动元素
  .append()/.appendTo()
  .prepend()/.prependTo()
  .after()/.insertAfter()
  .before()/.insertBefore()
2.添加元素
  $("<div></div>")	// 参数为任意HTML
  .clone()
3.替换元素
  .replaceWith()
  .replaceAll()
4.包裹元素
  .wrap()/.unwrap()
  .wrapAll()
  .wrapInner()
5.删除清空元素
  .remove()/.detach()
  .empty()

三.属性处理
  .attr("type")/.attr("width", 200)/.removeAttr()
  .addClass()/.removeClass()/.toggleClass()/.hasClass()
  .html()/.text()
  .val()
  .css()
  .height()/.width()
