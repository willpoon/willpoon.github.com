Title: 主流数据库安装、维护、开发与管理
Category: Tech
Tags: DB,database,数据库,db2,oracle,mysql
Slug: play-databases
Authors: Poon

记录数据库 安装、维护、开发与管理 的各种操作&技巧。包含但不仅限于db2,oracle , mysql , sqlite...

[TOC]

# DB2

##  在db2上授权一个用户db2etl，让这个用户具备dbadm & schema创建权限。

2015-12-15 Tue 20:57 PM

--db2 列出schema下所有的tables

db2 list tables for schema syscat | grep -i auth

poon@Wills-MacBook-Pro:~$ db2 list tables for schema metadata




-- 指定当前schema 
set current schema = 'KALIE'


--database 已经默认为当前connect 的用户, 例如sample :

GRANT DBADM ON DATABASE to db2admin  --- 是不行的，必须声明是 user , e.g:


[db2inst1@iZ281s312fdZ ~]$ db2 grant dbadm on database to db2etl

DB21034E  The command was processed as an SQL statement because it was not a 
valid Command Line Processor command.  During SQL processing it returned:
SQL0569N  Authorization ID "DB2ETL" does not uniquely identify a user, a group 
or a role in the system.  SQLSTATE=56092

--解释：

SEPGG_9.5.0/com.ibm.db2.luw.messages.sql.doc/doc/msql00569n.html


SQL0569N
Authorization ID authorization-name does not uniquely identify a user, a group or a role in the system.

Explanation

The authorization ID specified by the GRANT or REVOKE statement does not uniquely identify a user, a role, or a group in the security namespace. The reference to authorization-name is ambiguous. Note that when using DCE security, the USER, GROUP or ROLE keyword is always required.

User response

Change the statement to explicitly specify the USER, GROUP or ROLE keyword to uniquely identify the specified authorization id.


ref: http://www-01.ibm.com/support/knowledgecenter/#!/S


--正确的姿势：使用db2inst1 ：

[db2inst1@iZ281s312fdZ ~]$ db2 grant dbadm on database to user db2etl

DB20000I  The SQL command completed successfully.

--具备dbadm权限的用户，就具备了创建 db2 schema 的权限：

poon@Wills-MacBook-Pro:~$ db2 create schema skm1 AUTHORIZATION db2etl

DB20000I  The SQL command completed successfully.


---查看某schema 下的表名：

poon@Wills-MacBook-Pro:~$ db2 "select TABSCHEMA,tabname from syscat.tables where tabschema = 'METADATA'"

set current schema = 'METADATA'

--db2look 是本地客户端的命令，如果客户端版本和服务器有差别，db2look 可能用不了哦：


db2look -d sample -e -l -x  -z metadata -i db2etl -w db2etlpassword


--注意事项：

CREATE TABLE "METADATA"."tmplst"  (
          "TO_inst_id" VARCHAR(64) , 
          "nLevel" INTEGER , 
          "sCort" VARCHAR(8000) )   
         IN "IBMDB2SAMPLEREL" ; 

         这种建表语句是很坑人的，因为大小写混在一起了。请全部用大写。
如下：

CREATE TABLE "METADATA"."TMPLST"  (
          "TO_INST_ID" VARCHAR(64) , 
          "NLEVEL" INTEGER , 
          "SCORT" VARCHAR(8000) )   
         IN "IBMDB2SAMPLEREL" 




--- 现在 db2etl 已经具备了创建schema的权限&建表权限。所以可以直接用db2etl来管理schema及其下的tables权限分配。


poon@Wills-MacBook-Pro:~/sunline$ db2 -tvf db2.sql 
CREATE TABLE "METADATA"."TMPLST"  ( "TO_INST_ID" VARCHAR(64) , "NLEVEL" INTEGER , "SCORT" VARCHAR(8000) ) IN "IBMDB2SAMPLEREL" 
DB20000I  The SQL command completed successfully.

poon@Wills-MacBook-Pro:~/sunline$ db2 grant select on METADATA.TMPLST to public
DB20000I  The SQL command completed successfully.


以上，除了给db2etl赋 dbadm 权限用到db2inst1，其他操作都不需要。 只需要用db2etl即可。





## 启动&连接&测试

 su - db2inst1

 db2stop

 db2start

 db2 connect to sample

## 密码带特殊字符时，如果连接

db2 'connect to sample user db2etl using "db2etl!QAZ"'

使用'' 包住connect 语句

使用 "" 包住 密码串。

但是！ 这种方法由于有' ' 的出现，导致变量不能被解释！这样的话，在shell中调用db2 就会遇到一些麻烦了！

## SQL3001C  An I/O error 
SQL3001C  An I/O error (reason = "sqlofopn -2079391743") occurred while  opening the output file.
报这个错的原因是路径不存在或路径没有写入权限。

## 统计表大小，用户空间大小

从 SYSIBMADM.ADMINTABINFO  统计。


##  如何catalog 一个远程数据库

    Wills-MacBook-Pro:bin db2inst1$ db2 UNCATALOG DATABASE sample
    DB20000I  The UNCATALOG DATABASE command completed successfully.
    DB21056W  Directory changes may not be effective until the directory cache is 
    refreshed.
    Wills-MacBook-Pro:bin db2inst1$ db2 UNCATALOG node devnode   
    DB20000I  The UNCATALOG NODE command completed successfully.
    DB21056W  Directory changes may not be effective until the directory cache is 
    refreshed.
    Wills-MacBook-Pro:bin db2inst1$ db2 catalog tcpip node devnode remote 120.xx.xx.xx server 50000
    DB20000I  The CATALOG TCPIP NODE command completed successfully.
    DB21056W  Directory changes may not be effective until the directory cache is 
    refreshed.
    Wills-MacBook-Pro:bin db2inst1$ db2 catalog database sample at node devnode
    DB20000I  The CATALOG DATABASE command completed successfully.
    DB21056W  Directory changes may not be effective until the directory cache is 
    refreshed.
    Wills-MacBook-Pro:bin db2inst1$ db2 terminate
    DB20000I  The TERMINATE command completed successfully.
    Wills-MacBook-Pro:bin db2inst1$ db2 connect to sample
    SQL30082N  Security processing failed with reason "3" ("PASSWORD MISSING").  
    SQLSTATE=08001
    Wills-MacBook-Pro:bin db2inst1$ db2 connect to sample user db2inst1       
    Enter current password for db2inst1: 

       Database Connection Information

     Database server        = DB2/LINUXX8664 9.7.0
     SQL authorization ID   = DB2INST1
     Local database alias   = SAMPLE

    Wills-MacBook-Pro:bin db2inst1$ pwd
    /Users/db2inst1/sqllib/bin
    Wills-MacBook-Pro:bin db2inst1$ db2 "select count(0) from syscat.tables"

    1          
    -----------
            426

      1 record(s) selected.


## DB2 on mac 很难找！

我找mac版的艰辛过程：
本来我打算在mac上安装一个client版的就行了，然后远程到云服务器上。google了半天，发现了一个v9.5版本的，但我的mac是10.10 ， 报错，不支持。

    DBI1189E There has been an attempt to use db2setup 
    on an image for a platform that does not match the current platform 
    'Darwin [x86_64]' on which it is being run.

    Explanation:

    Possible causes include:

    - This DB2 install image is not valid for the current 
    platform.

    - The current platform is not supported by DB2.


    User Response:

    Install DB2 using the DB2 install image that corresponds 
    with the current platform 'Darwin [x86_64]'.

没办法，只能装个最新的完整版的：

根据这个链接：

    https://www-01.ibm.com/marketing/iwm/iwm/web/pick.do?source=swg-db2expressc&S_PKG=dlmacosx&S_TACT=100KG31W&lang=en_US

进入，注册，然后按要求填写，就可以得到一个下载地址。

还没安装，晚点再写安装&使用体验。


## db2 一个系统用户管理多个schema  . 

-- 使用 db2inst1 操作

	db2 => create schema skma AUTHORIZATION  db2etl 

	DB20000I  The SQL command completed successfully.


	db2 => select * from  skma.testskma

  	0 record(s) selected.

  db2 => create table  skma.testskma(id integer)

  DB20000I  The SQL command completed successfully.

--使用 db2etl 操作

	db2 => select * from skma.testskma;

	SQL0551N  "DB2ETL" does not have the required authorization or privilege to perform operation "EXECUTE" on object "NULLID.SQLC2J23".  SQLSTATE=42501

解决：

    Resolving the problem:
    The NULLID.SQLC2H21 package is created by db2clpcs.bnd, which is only in DB2 v9.7. The SQL0551N error may be seen if you have not ran any bind commands from a v9.7 client to the v9.1 or v9.5 database server.

 参考：
 
 	http://www-01.ibm.com/support/docview.wss?uid=swg21440573


-- 使用db2inst1 操作

	db2 => grant execute on package NULLID.SQLC2J23 to public 

  	DB20000I  The SQL command completed successfully.


  --使用db2etl 登陆：

  	db2 => select * from  skma.testskma

    0 record(s) selected.

## DB2 grant 无法针对 schema 授权

如果要对某个schema 下的所有表 做批量授权，需要 做批处理。因为db2没有可以直接对schema授权的方法。

具体方法如下：

    db2 -tnx "select distinct 'GRANT ALL ON TABLE '||
        '\"'||rtrim(tabschema)||'\".\"'||rtrim(tabname)||'\" TO USER winuser1;'
        from syscat.tables
        where tabschema = 'myschema' "  >> grants.sql

    db2 -tvf grants.sql


### 更灵活的操作：

    ksh grant_privs.ksh DB_X USER_X SCHEMA_X insert,delete,update,select

脚本如下：

    #!/bin/ksh
    # Grant privileges for a user or group on a specified schema
    #---------------------------------------------------------------------------------------------

    . ~/sqllib/db2profile

    NUMARGS=$#

    if [[ $NUMARGS -ne "4" ]]; then
            echo "Usage: $0 database userid schema privilege,..."
            echo "SYSADM authority required."
            exit -2
    fi

    typeset -u SCHEMA=$3
    $(db2 connect to $1)
    STMT="db2 select tabname from syscat.tables where tabschema='$SCHEMA'"
    TABLES_TO_GRANT=$($STMT|egrep -v "TABNAME|----|selected.")
    for TAB in $TABLES_TO_GRANT; do
         cmd="db2 grant $4 on $3.$TAB to $2"
         echo $cmd
         ret=$($cmd)
         echo $ret
    done


Grant privileges for a user or group on a specified schema

http://www.dbatodba.com/db2/scripts-db2/shell-scripts-to-db2/grant-privileges-for-a-user-or-group-on-a-specified-schema/


# MYSQL 

## mysql : 1040 too many connections  的解决

1. 修改 /etc/my.cnf ( 因系统安装环境而异 )
2. 添加一行参数，例如1000：max_connections = 1000   
3. 切换到 mysql 运维账户，我这里就是 su - mysql
4. 重启： nohup mysqld 2>&1  > mysql.out &

另外，
1. 有一个类似的参数，max_user_connections ， 网上说似乎无效，未验证。
2. 使用 show processlist 查看当前连接数。
3. 使用 show variables like "max_connections"  查看参数值。



## MYSQL 不支持 full outer join 

解决办法：

    SELECT * FROM t1
    LEFT JOIN t2 ON t1.id = t2.id
    UNION
    SELECT * FROM t1
    RIGHT JOIN t2 ON t1.id = t2.id

## MYSQL 不支持 except or minus 

## mysql -A 参数

如果想快点进入mysql交互界面，就使用这个参数。否则，表多的时候，就要等好长时间。

    mysql -umeta -pxxxx metadata -h120.xx.xx.xx

Reading table information for completion of table and column names You can turn off this feature to get a quicker startup with -A

No automatic rehashing. One has to use 'rehash' to get table and field completion. This gives a quicker start of mysql and disables rehashing on reconnect.








## mysql limit 的用法：

    mysql> SELECT * FROM table LIMIT 5,10; // 检索记录行 6-15  

limit m,n 解释:

m(5) -- 表示偏移量。也就是要skip掉m行。

n(10) --  表示从第m行之后，最大可以提取n行。

##  关联技巧:恢复空表


    INSERT INTO ${PDM_SCH}.LI_COL
    SELECT B.*
    FROM ${PDM_SCH}.LI_COL_BAK B,
    (
        SELECT COUNT(1) AS CNT
            FROM ${PDM_SCH}.LI_COL LIMIT 0,1
            ) O
            WHERE O.CNT=0;




## 启动mysqld 的时候，一般加什么参数？

    ps -ef|grep -i mysql

    结果：

       74    96     1   0 10:57AM ??         0:03.49 /usr/local/mysql/bin/mysqld --user=_mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --plugin-dir=/usr/local/mysql/lib/plugin --log-error=/usr/local/mysql/data/mysqld.local.err --pid-file=/usr/local/mysql/data/mysqld.local.pid

## mysql 远程连接

    mysql -u -p -hxxx.xxx.xxx.xxx

可以添加 -A 参数， 让连接响应速度快一点

## 如果不能用 except , minus , mysql 如何比较两张表？

## mysql 使用 row() 实现 多列比较 

在where 条件中，使用row() 函数，来枚举多列。

    mysql> select host , user from user where row(host,user) not in (select '127.0.0.1' host , 'root' user from user );

## mysql 模拟 intersect  求差集

由于mysql 不支持 intersect , 如果要求两个结果集的差集，就需要另辟蹊径.

方法1： 使用 union *all*  和 group by , having count(0) = 1 求出group by 之后，只有一条的记录。

    SELECT MIN (tbl_name) AS tbl_name, PK, column_list -- min / max make no difference 
    FROM
     (
      SELECT ' source_table ' as tbl_name, S.PK, S.column_list
      FROM source_table AS S
      UNION ALL
      SELECT 'destination_table' as tbl_name, D.PK, D.column_list
      FROM destination_table AS D 
    )  AS alias_table
    GROUP BY PK, column_list
    HAVING COUNT (0) = 1
    ORDER BY PK


方法2:  使用 row() .. not in (select colList from table )  。 使用 not in 求字段差集。row() ， 在多字段的情况下使用。

    SELECT MIN (tbl_name) AS tbl_name, PK, column_list
    FROM
     (
      SELECT ' source_table ' as tbl_name, S.PK, S.column_list
      FROM source_table AS S
      UNION ALL
      SELECT 'destination_table' as tbl_name, D.PK, D.column_list
      FROM destination_table AS D 
    )  AS alias_table
    GROUP BY PK, column_list
    HAVING COUNT (*) = 1
    ORDER BY PK




## 远程数据库连接配置

1. db2 

我的工作电脑是macbook，如果要连接远程的db2，需要在本地做catalog . ibm官方网站上有 v10.1 的db2exc可以下载。可以用来做客户端或者一个简单的开发环境。mac os x 安装db2exc 要用root用户安装，安装之前要设置sysctl.conf参数，重启。然后最好给db2创建单独的用户db2inst1， 这样sqllib就会自动创建到db2inst1的目录下。使用db2icrt创建实例。使用db2sampl创建sample数据库。如果执行db2start时出现权限问题，就要给sqllib下的adm目录赋权。把原来赋给root的权限，chown到db2inst1 。 
当db2可以正常连接后，使用db2 catalog 归档远程数据库。注意：node 关键字是让你给节点起个名字，这个名字我们自己随便取，而不是服务器的特定值。先 归档 远程服务器节点，再归档数据库。端口用50000 五万。

2. mysql 

连接远程的mysql，需要装本地mysql client 。 使用-h 参数指定远程服务器。使用-A 参数，降低连接时等待rehash的时间。

<!-- ^ -->

# ORACLE

## start with ... connect by prior ...  用法

表格式：sid|pid|level ; s for son , p for parent

 start with pid=[截取的根节点nodeA] connect by prior sid = pid

[截取的根节点] : 当我们需要从哪个节点nodeA开始，就是让 pid 取为该开始节点值nodeA。

从 nodeA 开始， 取 [树的子节点son] 字段 ， 通过 prior 字段，取得son节点的祖先， 让 prior sid = pid ; 即 prior son = father ; 意思是 son的祖先＝father 。 更近一步：

 prior sunzi = fuqin

 prior fuqin = yeye

这样sunzi - fuqin - yeye 都关联起来了。

[例子](http://mengya520.blog.51cto.com/1506880/334621) ：

select ID, NAME, SYS_CONNECT_BY_PATH(pid,'/') as pid_path, SYS_CONNECT_BY_PATH(parent_name,'/') as parent_name
from test_parent1
start with pid=1 connect by prior id=pid;

如果 你写成 connect by prior pid = id , 那是不行的。 如果pid 还要取祖先，prior pid 的结果，就是爷爷了。 爷爷 ＝ 孙子 怎么行呢？乱套了！


<!-- $ -->
