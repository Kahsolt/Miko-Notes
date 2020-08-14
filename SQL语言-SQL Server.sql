--SQL是标准查询语言
--大小写不敏感
--语句建议用分号;隔离

零.SQL Server结构
0.字符串
'单引号括起来'
[NOT] LIKE '<字符串>' [ESCAPE '<换码字符>']	--用于查询内容含有%/_/[]字符时
	通配符：
		%	任意字符
		_	单个字符
		[A-H,I-Q]	范围
		[^ICBM]	范围排除
1.固定服务器角色
	bulkadmin		执行BULK INSERT语句
	dbcreator		创建修改删除恢复数据库
	diskadmin		管理磁盘文件
	processadmin	终止T-SQL会话
	public			查看数据库的权限
	securityadmin	管理登录名和密码
	serveradmin		管理服务运行、配置
	setupadmin		管理链接服务器的定义
	sysadmin		执行任何活动
2.数据库角色
	dbo/db_owner		数据库所有者
	db_accessadmin		可管理登录名
	db_backupoperator	可备份
	db_datareader		可读表
	db_datawriter		可写表
	db_ddladmin			可执行DDL语句如建表
	db_denyreader		不能读表
	db_denywriter		不能写表
	db_securityadmin	修改数据库角色成员和管理权限
	public				可见公开数据库

一.数据库设计
0.USE语句
USE 数据库名;
1.DATABASE语句
CREATE DATABASE 数据库名
	[ON {[PRIMARY] <数据文件>}
		{FILEGROUP <文件组名><数据文件>}]
	[LOG ON {<日志文件>}];
ALTER DATABASE 数据库名;
DROP DATABASE 数据库名;
2.TABLE语句
CREATE TABLE 表名(
	列名 数据类型 列约束,	--此处列约束可为NOT NULL|NULL/DEFAULT 默认值/UNIQUE/PRIMARY KEY/FOREIGN KEY REFERENCES 另一个表名(列名)
	列名 数据类型 列约束,
	...,
	表级完整性约束	--此处约束可为[CONSTANT 约束名]NOT NULL(列名表)|NULL(列名表)/DEFAULT 默认值 FOR 列名/UNIQUE(列名表)/PRIMARY KEY(列名表)/FOREIGN KEY (列名表) REFERENCES 另一个表名(列名)
);
*.约束类型
	1>.域完整性
		空值约束
			列定义 [NULL|NOT NULL]
		默认值约束
			[CONSTRAINT 约束名] DEFAULT 默认值表达式 FOR 列名
		检查约束
			列定义 CHECK (逻辑表达式)
			ALTER TABLE 表名
				ADD CONSTRAINT 约束名 CHECK (逻辑表达式)
		规则约束
	2>.实体完整性
			主键		PRIMARY KEY
			唯一性约束	UNIQUE
			标识列		IDENTITY
			唯一标识列	UNIQUEIDENTIFER
3.INSERT语句
例：INSERT INTO Book VALUES(1,'Bible','Philosophy')
	INSERT INTO Book (ID,Name) VALUES(2,'Pali Sutra')
	INSERT INTO Book (Name,Category) VALUES('Kuran','Codex')
	INSERT INTO Book (Name,ID) VALUES('Nag Hammadi',4)
4.SELECT语句
SELECT [DISTINCT] @变量名=字段表	--可将结果存入变量
[[AS] 别名]	--数值型表的别名不用“原名 AS 别名”，而用“别名=原名”
[INTO 目标表]	--可将结果存入一个新表
FROM {源表|源视图}组
[WHERE 条件]
[GROUP BY 分组字段 HAVING 条件]	--先对某些列分组，该列行值相同的归为一组
[ORDER BY 排序字段 [ASC|DESC]]	--对结果表排序
例：SELECT 1+'51'+3.5 AS Algebra, '51'+'52' AS String
	SELECT ID,Category AS tmp_Category FROM Book
	SELECT ID tmp_ID, Category tmp_ID,tmp_Category FROM Book
	SELECT * FROM Book
		WHERE Category='Codex' OR Name<>'Bible'
	SELECT * FROM Book
		WHERE ID BETWEEN 2 AND 4
	SELECT * FROM Book
		WHERE ID in (3,5,9)
	SELECT * FROM Book
		WHERE Category IS NULL
	SELECT DISTINCT Category AS Categories FROM Book
5.UPDATE语句
UPDATE 表名
	SET 列名=新值 [WHERE 条件]
例：UPDATE Book
		SET Price=Price+37.5
	UPDATE Book
		SET ID=3 WHERE Name='Kuran'
6.DELETE语句
DELETE FROM Book	--清空表数据
DELETE FROM Book
	WHERE Id=2
7.ALTER语句
ALTER TABLE 表名
	[ADD <列名> <数据类型> <列完整性约束>]
	[DROP <列名>]
	[MODIFY <列名> <新的数据类型>]
例：ALTER TABLE Book
		ADD Price FLOAT
	ALTER TABLE Book
		DROP COLUMN Price

3.多表
CREATE TABLE Order(
	uid INTEGER,
	cid INTEGER,
	product VARCHAR(50) NOT NULL,
	CONSTRAINT pk_Order PRIMARY KEY (uid, cid),
	CONSTRAINT fk_Order FOREIGN KEY (someKey)
		REFERENCES anotherTable(someColumn)
);
ALTER TABLE tb_user
	ADD CONSTRAINT pk_users PRIMARY KEY (ID);
ALTER TABLE tb_mark
	ADD CONSTRAINT fk_uid FOREIGN KEY(UID)
		REFERENCES tb_user(id);

4.表运算
SELECT Book.title AS Book,
	Book.publisher AS Publisher,
	Author.LastName AS Author
FROM Author A 
	INNER JOIN Book_Author BA ON A.ID=BA.ID_Author
	INNER JOIN Book B ON BA.ID_Book=B.ID;
	
SELECT B.Name AS Book,
	A.Name AS Author
FROM Author A 
	INNER JOIN Book_Author BA ON A.Name=BA.Author
	INNER JOIN Book B ON BA.Book=B.Name;
	
	
二.高级结构
1.游标CURSOR
	CURSOR 游标名 IS SELECT语句
	OPEN 游标名
	FETCH 游标名 INTO list_of_variables;
	FETCH 游标名 INTO PL/SQL_record;
	CLOSE 游标名
DECLARE mycursor CURSOR FOR   /*声明游标mycursor查询课程号和课程名称*/
SELECT cno,cname FROM course;
BEGIN 
   OPEN mycursor;           
   FETCH mycursor INTO @curcno,@curname; 
   WHILE(@@FETCH_STATUS=0)	/*循环控制，游标推进*/
		BEGIN
			SELECT @curavgg=AVG(grade) FROM SC  
			WHERE cno = @curcno
			INSERT INTO avggrade VALUES(@curname,@curavgg);
		END      
	CLOSE mycursor
END

2.存储过程PROCEDURE
CREATE OR REPLACE PROCEDURE TRANSFER(@inAccount INT, @outAccount  INT, @amount FLOAT)
       /*定义存储过程TRANSFER，其参数为转入账户、转出账户、转账额度*/
AS DECLARE		/*定义变量*/
	@totalDepositOut  Float;
    @totalDepositIn  Float;
	@inAccountnum  INT;
BEGIN                         /*检查转出账户的余额 */	                       
	SELECT Total INTO @totalDepositOut FROM Accout 
	    WHERE accountnum=@outAccount; 
			IF @totalDepositOut IS NULL THEN   /*如果转出账户不存在或账户中没有存款*/
	            ROLLBACK; 	   /*回滚事务*/
	            RETURN;
			END IF; 
		IF @totalDepositOut<@amount THEN    	/*如果账户存款不足*/
			ROLLBACK; 				/*回滚事务*/
			RETURN;
		END IF;
	SELECT accountnum INTO @inAccountnum FROM Account
		WHERE accountnum=inAccount;
			IF inAccount IS NULL THEN  		/*如果转入账户不存在*/                        
				ROLLBACK; 	         	 		/*回滚事务*/
				RETURN;
			ENDIF;
	UPDATE Account SET total=total-@amount
		WHERE accountnum=@outAccount;
 				/* 修改转出账户余额，减去转出额 */
	UPDATE Account SET total=total+@amount 
		WHERE accountnum=@inAccount; 
				/* 修改转入账户余额，增加转入额 */
	COMMIT;		/* 提交转账事务 */
END;
*调用过程
	EXECUTE  过程名 参数表
	
	