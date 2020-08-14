-- MySQL数据库管理

一.MySQL
0.软件工具
  表级管理：mysql
	-u root
	-h localhost
	-p  #单独一个p，会提示输入密码
    mysql -u root -pkahsolt   #或者用密码紧跟着-p，但会明文传输
	--protocol=TCP
	< new_query.sql   # 恢复
  备份
    mysqldump --user='root' -p <数据库名> [表名] > save.sql
  库级管理：mysqladmin
  	ping/kill
    create/drop
    processlist
    version
    status
    shutdown
    mysqladmin -u root -p flush-previleges password ["new_pswd"]
  存取为.csv文件：FIELDS TERMINATED BY
  	LOAD DATA INFILE 'filename.csv' INTO TABLE details FIELDS TERMINATED BY ',';
	  SELECT artist_name, album_name FROM artist, album WHERE artist.artist_id=album.artist_id INTO OUTFILE '/tmp/outputfile.csv' FIELDS TERMINATED BY ',';
  自动登录
  	修改配置文件my.conf，增加节：
		[mysql]
		user=root
		password=kahsolt
    [mysqld]
    default_character_set=utf8
    datadir=/data/mysql
  数据库引擎
	MyISAM：
		non-transaction
		table-locking
		Files:
			Table format file(.frm)
			Data file(.myd)
			Index file(.myi)
		Tools:
			myisampack(compress)
			myisamchk(optimize,repair)
	InnoDB：
		transactional
		foreign keys
		row-locking 
		B-tree clustered indexes
		Online non-blocking backup
  用户及授权
  	CREATE USER 'paola'@'localhost' IDENTIFIED BY 'her_password';
    DROP USER 'partmusic'@'localhost';
    GRANT ALL PRIVILEGES ON music.* TO 'allmusic'@'localhost' IDENTIFIED BY 'the_password';
    GRANT GRANT OPTION ON music.* TO 'hugh'@'localhost';	# 用户可以继续分发自己的权利
    GRANT USAGE ON *.* to 'partmusic'@'localhost' WITH
      MAX_QUERIES_PER_HOUR 100
      MAX_UPDATES_PER_HOUR 10
      MAX_CONNECTIONS_PER_HOUR 5;
    REVOKE SELECT (track_id) ON music.track FROM 'partmusic'@'localhost';
    SHOW GRANTS FOR CURRENT_USER|CURRENT_USER()|'user'@'host';
    SELECT CURRENT_USER|CURRENT_USER();
  改密码
  	GRANT USAGE ON *.* TO 'selina'@'localhost' IDENTIFIED BY 'another_password';  #USAGE只读权限
    SET PASSWORD = PASSWORD('the_password');
    SET PASSWORD FOR 'selina'@'localhost' = PASSWORD('another_password');
  重置root密码
    mysqld_safe --skip-grant-tables
    FLUSH PRIVILEGES;
    SET PASSWORD for 'root'@'localhost'= PASSWORD('the_new_mysql_root_password');
    FLUSH PRIVILEGES;
  工作状态
  	status
  更改提示符
    prompt MySQL:\d>\_  #\d表示当前数据库，\_表示空格
  环境变量
    SHOW STATUS
    SHOW GLOBAL STATUS (All users)
    SHOW GLOBAL STATUS LIKE ‘%tmp%’;
    SHOW GLOBAL VARIABLES LIKE ’%tmp\_%’;
2.模型设计
  关系型数据库范式
	第一：关系型
		列为不可分割的基本数据型，行仅能存单条记录
	第二：主键
		行能够被唯一区分(通过主键解决)，其余列必须依赖这个主键
	第三：外键
		除了主键之外的列，不能再重复出现在多个表中(通过外键解决)
  ERD图
    属性A		椭圆，主键加下划线
	实体E		矩形，两边用单线连接两个R
	弱实体WE	双线矩形
	中间实体IE	矩形，两边用双线连接两个R，用于分解N:M的关系
	关系R		菱形
	线		连接E和R，重数关系1:1，1:N，M:N
3.SQL语句
	0.SELECT [DISTINCT] <column> [AS <column_alias>] FROM <table>
		WHERE <expr> AND|OR|NOT|XOR <expr>
		WHERE <column> LIKE <str_match>			# LIKE 'Wh%' for a string, 'Wh_' for a char
		WHERE <column> =ANY(<SELECT..>) |IN (<SELECT..>)	# 表达式子查询
		WHERE [NOT] EXISTS (<SELECT..>)	# 存在子查询
		INNER|LEFT|RIGHT JOIN <table> ON <expr> | USING (<column_in_common>)
		GROUP BY <column>	# 常用在SELECT COUNT(<column>)时，或者其他聚合函数
		HAVING <expr>		# 聚合函数在此常用，如COUNT(*)>10
		ORDER BY <column> ASC|DESC
		LIMIT <[index=1,]count>;
	  *聚合函数：AVG()MAX()MIN()STD()STDDEV()SUM()
	  *变量暂存：
	  	SELECT @artist:= artist_name FROM artist WHERE artist_id = 1;
	  	SELECT @artist;		# 也就是SELECT artist_name FROM artist WHERE artist_id = 1;
	  *插入临时表
      INSERT INTO shuffle (artist_id, album_id,track_id)	# 生成乱序表
        SELECT artist_id,album_id, track_id FROM track
        ORDER BY RAND()
        LIMIT 10；
      INSERT INTO artist.people (people_id, name)	#生成新表people
        SELECT artist_id, artist_name
      INSERT INTO artist SELECT artist_id,artist_name
        FROM music.artist;
	1.<SELECT..> UNION ALL <SELECT..>	# 纯连接，要求被链接的表column相同
	2.INSERT INTO <table> (<columns>,...) VALUES (<exprs>,...),...;	# 可同时多条记录
	  INSERT INTO <table> SET <column_i>=<expr_i>,...;;				# 只能同时一条记录
	3.DELETE FROM <table>
		WHERE <expr> AND|OR|NOT|XOR|LIKE <expr>
		ORDER BY <column> ASC|DESC
		LIMIT <[index=1,]count>;
	4.TRUNCATE TABLE <table>;	#清空表，等于DELETE FROM <table>;
								#DELETE是DML较慢，TRUNCATE是DDL较快
	5.UPDATE <expr> 	# 直接修改列
		SET <column_i>=<expr_i>
		WHERE <expr> AND|OR|NOT|XOR|LIKE <expr>;
	  REPLACE artist (artist_id, artist_name)	# 先删除行再添加
	  	VALUES (2, "Nick Cave and The Bad Seeds"), (3, "Miles Dewey Davis");
	6.CREATE DATABASE [IF NOT EXISTS] <schema>;
	  DROP DATABASE <schema>;
	7.CREATE TABLE [IF NOT EXISTS] <table> (
		<column> <datatype> <constraints_pk|nn|ai|zf|dflt..>,
		...
		<constraints_pk|fk|idx>
		CONSTRAINT fk_name FOREIGN KEY (field1, field2)
			REFERENCES other_table (fieldA, fieldB)
	  );
	  CREATE TABLE artist_2
	  	SELECT * from artist;	# 旧有数据生成新表
    SHOW CREATE TABLE artist \G
	8.SHOW CHARACTER SET;
	  SHOW COLLATION;
	9.ALTER TABLE <table>
		RENAME TO <table>
		ADD PRIMARY KEY (<column>)
		DROP  PRIMARY KEY
		ADD INDEX idx_name (<column>)
		DROP INDEX idx_name
		ADD <column> <datatype>
		DROP <column>
		MODIFY <column> <datatype_new> <constraints_new>
		CHANGE <column> <column_newname> <datatype_new>;
	10.CREATE VIEW <view> AS
		<SELECT..>;
	   DROP VIEW <view>;
	11.DELIMITER // 
		CREATE PROCEDURE GetAllProducts() 
			BEGIN 
				SELECT * FROM products; 
			END // 
	   DELIMITER ; 
       CALL GetAllProducts();
	12.CREATE TRIGGER ResetPricesTrigger
		AFTER UPDATE OF netWorth ON customers
	   REFERENCING
		OLD ROW AS OldRow,
		NEW ROW AS NewRow 
	   FOR EACH ROW
	   WHEN (OldRow.customers > NewRow.customers) 
		UPDATE customers
		SET netWorth = OldRow.netWorth WHERE cust_id# = NewRow.cust_id#;
