Rem VB��΢��˾������һ���������ġ�������.NET Framework֮�ϵĸ߼������������
Rem ע����rem�����з�Ϊ�ո���»��� _��һ�ж����ָ���Ϊð��:
'��Ҳ��ע��

һ.����
1.��������
Dim|Public|Private|Static ������ [As ��������]	Rem Ĭ��Ϊ����Variant��
*���峤n���ַ���
	Dim str As String * n
*����ṹ�壺
	[Public|Private] Type �ṹ����
		������ As ����
		...
	End Type
2.�߼����Ӵ�
=	����
<>	������
And|Or|Not
3.��������
�����	InputBox(��ʾ,����,ȱʡֵ,X����,Y����,�����ļ�)
��Ϣ��	MsgBox(��ʾ,��ť��ʽ,����,�����ļ�)

��.���ƽṹ
1.If����
If ����1 Then
	���1
Else If ����2 Then
	���2
Else
	���3
End If
2.IIF����
IIF(���ʽ,true����ֵ,false����ֵ)
3.Case��֧
Select Case ���ʽ
	Case ���ʽ��1
		�����1
	Case ���ʽ��2
		�����2
	Case Else
		�����3
End Select
4.Forѭ��
For ������=��ֵ To ��ֵ [Step ����]
	ѭ����
	[Exit For]	Rem ��Break
Next ��������	Rem����ѭ����ʡ�Լ�������
5.Whileѭ��
While ���ʽ
	ѭ����
End While
6.Doѭ��
Do {While|Until} ���ʽ
	ѭ����
	[Exit Do]
Loop
Do
	ѭ����
	[Exit Do]
Loop {While|Until} ���ʽ

��.�߼��ṹ
1.����Function
[Public|Private][Static] Function ������ ([�βα� As ����]) As ��������
	������
	������=����ֵ
	[Exit Function]
End Function
2.�ӹ���Sub
[Public|Private][Static] Sub ������ ([�βα� As ����])
	������
	[Exit Sub]
End Sub
*����Sub
	1.Call ������([ʵ�α�])
	2.������ [ʵ�α�]	Rem û�����ţ�
3.����
{Dim|Public|Private} ������(ά����) [As ����]
*ά������﷽ʽ
	1.�½� To �Ͻ�[,�½� To �Ͻ�]
	2.�������Ͻ�(Ĭ���½�Ϊ0)->�ɴ��Ͻ�+1��Ԫ��