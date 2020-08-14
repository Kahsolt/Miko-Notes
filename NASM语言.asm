;汇编语言是助记符化的机器语言
;这里关于NASM汇编器
;关于更加基础的内容请参考MASM.asm文件

二.汇编程序
0.NASM汇编器
	nasm -f <format> <filename> [-o <output>]
		<format>:elf aout win32 win64
	nasm -f elf myfile.asm
		输出.o文件
	nasm -f bin myfile.asm -o myfile.com
		输出.com文件/.bin文件
1.结构：
【NASM实例1】		
section	.data
	hello:	db	'Hello World!/n' ,10
	helloLen: equ	$-hello
section .text
	global _start
_start:
	mov ax,4
	mov ebx,1
	mov ecx,hello
	mov edx,helloLen
	int 80h		;Linux下为80h号中断
	mov ax,1
	mov ebx,0
	int 80h
