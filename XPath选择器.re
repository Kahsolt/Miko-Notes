[XPath]
/s		s的直接子元素
//s		s的间接子元素
*		所有
@attr	属性
text()	内嵌文本
[k=v]	条件筛选

eg.
  //h1[@id="heading"]/span/text()
  //div[@id="toc"]/ul//a/@href
  //*[contains(@class, "ltr") and contains(@class, "skin")]//h1//text()
  //table[@class="info"]//img[1]/@src
  //*[text()="ref"]/../following-sibling::div//a
  //img/@src

bookstore	选取 bookstore 元素的所有子节点
/bookstore	选取根元素 bookstore
		注释：假如路径起始于正斜杠( / )，则此路径始终代表到某元素的绝对路径！
bookstore/book	选取属于 bookstore 的子元素的所有 book 元素
//book		选取所有 book 子元素，而不管它们在文档中的位置
bookstore//book	选择属于 bookstore 元素的后代的所有 book 元素，而不管它们位于 bookstore 之下的什么位置
//@lang		选取名为 lang 的所有属性

/bookstore/book[1]		选取属于 bookstore 子元素的第一个 book 元素
/bookstore/book[last()]		选取属于 bookstore 子元素的最后一个 book 元素
/bookstore/book[last()-1]	选取属于 bookstore 子元素的倒数第二个 book 元素
/bookstore/book[position()<3]	选取最前面的两个属于 bookstore 元素的子元素的 book 元素
//title[@lang]			选取所有拥有名为 lang 的属性的 title 元素
//title[@lang='eng']		选取所有 title 元素，且这些元素拥有值为 eng 的 lang 属性
/bookstore/book[price>35.00]		选取 bookstore 元素的所有 book 元素，且其中的 price 元素的值须大于 35.00
/bookstore/book[price>35.00]/title	选取 bookstore 元素中的 book 元素的所有 title 元素，且其中的 price 元素的值须大于 35.00

/bookstore/*	选取 bookstore 元素的所有子元素
//*		选取文档中的所有元素
//title[@*]	选取所有带有属性的 title 元素

//book/title | //book/price	选取 book 元素的所有 title 和 price 元素
//title | //price		选取文档中的所有 title 和 price 元素
/bookstore/book/title | //price	选取属于 bookstore 元素的 book 元素的所有 title 元素，以及文档中所有的 price 元素

child::book	选取所有属于当前节点的子元素的 book 节点
attribute::lang	选取当前节点的 lang 属性
child::*	选取当前节点的所有子元素
attribute::*	选取当前节点的所有属性
child::text()	选取当前节点的所有文本子节点
child::node()	选取当前节点的所有子节点
descendant::book	选取当前节点的所有 book 后代
ancestor::book		选择当前节点的所有 book 先辈
ancestor-or-self::book	选取当前节点的所有 book 先辈以及当前节点（如果此节点是 book 节点）
child::*/child::price	选取当前节点的所有 price 孙节点
