DokuWiki语法格式

0.非格式化
<nowiki>
This is some text which contains addresses like this: http://www.splitbrain.org and **formatting**, but nothing is done with it.
</nowiki>
The same is true for %%//__this__ text// with a smiley ;-)%%.
1.文字
	**bold**
	//italic//
	__underlined__
	''monospaced''
	<sub>subscript</sub>
	<sup>superscript</sup>
	<del>deleted</del>
	==== Headline Level 3 ====
	=== Headline Level 4 ===
	== Headline Level 5 ==
2.段落
	paragraph one\\paragraph two
	a whitespace \\this happens without it	(空行：一个空格加双斜线)
3.链接
	http://www.google.com
	www.google.com
	[[http://www.google.com|This Link points to google]]
	<andi@splitbrain.org>
	[[pagename]]
	[[pagename:namespaces]]
	[[pagename|link text]]						(用说明性文字替换原页名)
	[[http://php.net|{{wiki:dokuwiki-128.png}}]](用图标替换原外链接文字)
	[[syntax#internal|this Section]]			(链接到本页的段落)
	[[\\server\share|this]]						(windows文件共享服务)
	{{filename.ext}}
	((This is a footnote))						(脚注自动编号，括号内的文字为脚注文字)
4.媒体
	Real size:                        {{wiki:dokuwiki-128.png}}
	Resize to given width:            {{wiki:dokuwiki-128.png?50}}
	Resize to given width and height: {{wiki:dokuwiki-128.png?200x50}}
	Resized external image:           {{http://php.net/images/php.gif?200x50}}
	{{ wiki:dokuwiki-128.png}}			(左右空格标明对其方式)
	{{wiki:dokuwiki-128.png }}
	{{ wiki:dokuwiki-128.png }}
	{{ wiki:dokuwiki-128.png |This is the caption}}
	{{wiki:dokuwiki-128.png?linkonly}}	(媒体强制以只含标题的链接显示)
5.列表
  * This is a list
  * The second item
    * You may have different levels
  * Another item
  - The same list but ordered
  - Another item
    - Just use indention for deeper levels
  - That's it
6.文字语法糖
    8-) 8-)
    8-O 8-O
    :-( :-(
    :-) :-)
    =) =)
    :-/ :-/
    :-\ :-\
    :-? :-?
    :-D :-D
    :-P :-P
    :-O :-O
    :-X :-X
    :-| :-|
    ;-) ;-)
    ^_^ ^_^
    :?: :?:
    :!: :!:
    LOL LOL
    FIXME FIXME
    DELETEME DELETEME
	-> <- <-> => <= <=> >> << -- --- 640x480 (c) (tm) (r)
	"He thought 'It's a man's world'..."
7.引用
	I think we should do it
	> No we shouldn't
	>> Well, I say we should
	> Really?
	>> Yes!
	>>> Then lets do it!
8.表格
	^ Heading 1      ^ Heading 2       ^ Heading 3          ^
	| Row 1 Col 1    | Row 1 Col 2     | Row 1 Col 3        |
	| Row 2 Col 1    | some colspan (note the double pipe) ||
	| Row 3 Col 1    | Row 3 Col 2     | Row 3 Col 3        |
	
	|              ^ Heading 1            ^ Heading 2          ^
	^ Heading 3    | Row 1 Col 2          | Row 1 Col 3        |
	^ Heading 4    | no colspan this time |                    |
	^ Heading 5    | Row 2 Col 2          | Row 2 Col 3        |
	
	^ Heading 1      ^ Heading 2                  ^ Heading 3          ^
	| Row 1 Col 1    | this cell spans vertically | Row 1 Col 3        |
	| Row 2 Col 1    | :::                        | Row 2 Col 3        |
	| Row 3 Col 1    | :::                        | Row 2 Col 3        |
	
	^           Table with alignment           ^^^
	|         right|    center    |left          |
	|left          |         right|    center    |
	| xxxxxxxxxxxx | xxxxxxxxxxxx | xxxxxxxxxxxx |
9.代码
	  This is text is indented by two spaces.
	<code>
	This is preformatted code all spaces are preserved: like              <-this
	</code>
	<file>
	This is pretty much the same, but you could use it to show that you quoted a file.
	</file>
	<code java> or <file java>		(代码高亮)
		支持语言：4cs, 6502acme, 6502kickass, 6502tasm, 68000devpac, abap, actionscript-french, actionscript, actionscript3, ada, algol68, apache, applescript, asm, asp, autoconf, autohotkey, autoit, avisynth, awk, bascomavr, bash, basic4gl, bf, bibtex, blitzbasic, bnf, boo, c, c_loadrunner, c_mac, caddcl, cadlisp, cfdg, cfm, chaiscript, cil, clojure, cmake, cobol, coffeescript, cpp, cpp-qt, csharp, css, cuesheet, d, dcs, delphi, diff, div, dos, dot, e, epc, ecmascript, eiffel, email, erlang, euphoria, f1, falcon, fo, fortran, freebasic, fsharp, gambas, genero, genie, gdb, glsl, gml, gnuplot, go, groovy, gettext, gwbasic, haskell, hicest, hq9plus, html, html5, icon, idl, ini, inno, intercal, io, j, java5, java, javascript, jquery, kixtart, klonec, klonecpp, latex, lb, lisp, llvm, locobasic, logtalk, lolcode, lotusformulas, lotusscript, lscript, lsl2, lua, m68k, magiksf, make, mapbasic, matlab, mirc, modula2, modula3, mmix, mpasm, mxml, mysql, newlisp, nsis, oberon2, objc, objeck, ocaml-brief, ocaml, oobas, oracle8, oracle11, oxygene, oz, pascal, pcre, perl, perl6, per, pf, php-brief, php, pike, pic16, pixelbender, pli, plsql, postgresql, povray, powerbuilder, powershell, proftpd, progress, prolog, properties, providex, purebasic, pycon, python, q, qbasic, rails, rebol, reg, robots, rpmspec, rsplus, ruby, sas, scala, scheme, scilab, sdlbasic, smalltalk, smarty, sql, systemverilog, tcl, teraterm, text, thinbasic, tsql, typoscript, unicon, uscript, vala, vbnet, vb, verilog, vhdl, vim, visualfoxpro, visualprolog, whitespace, winbatch, whois, xbasic, xml, xorg_conf, xpp, yaml, z80, zxbasic
	<file php myexample.php>		(可下载式)
	<?php echo "hello world!"; ?>
	</file>
10.内嵌HTML和PHP
	<html>
	This is some <span style="color:red;font-size:150%;">inline HTML</span>
	</html>
	<HTML>
	<p style="border:2px dashed red;">And this is some block HTML</p>
	</HTML>
	<php>
	echo 'The PHP version: ';
	echo phpversion();
	echo ' (generated inline HTML)';
	</php>
	<PHP>
	echo '<table class="inline"><tr><td>The same, but inside a block level element:</td>';
	echo '<td>'.phpversion().'</td>';
	echo '</tr></table>';
	</PHP>