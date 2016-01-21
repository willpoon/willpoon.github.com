Title: 主流数据库安装、维护、开发与管理
Category: Tech
Tags: DB,database,数据库,db2,oracle,mysql
Slug: play-databases
Authors: Poon

记录数据库 安装、维护、开发与管理 的各种操作&技巧。包含但不仅限于db2,oracle , mysql , sqlite...

[TOC]

# DB2

## 使用response文件安装 db2 ese v9.7 

Response file installation of DB2 overview (Linux and UNIX)
This task describes how to perform response file installations on Linux or UNIX. You can use the response file to install additional components or products after an initial installation. A response file installation might also be referred to as a silent installation or an unattended installation.

About this task
Restrictions

Be aware of the following limitations when using the response files method to install DB2 on Linux or UNIX operating systems:
If you set any instance or global profile registry keywords to BLANK (the word "BLANK"), that keyword is, in effect, deleted from the list of currently set keywords.
Ensure that you have sufficient disk space before installing. Otherwise, if the installation fails, manual cleanup is required.
If you are performing multiple installations or are installing DB2 database products from multiple DVDs, it is recommended that you install from a network file system rather than a DVD drive. Installing from a network file system significantly decreases the amount of time it will take to perform the installation.
If you are planning on installing multiple clients, set up a mounted file system on a code server to improve performance.
Before you begin
Before you begin the installation, ensure that:
Your system meets all of the memory, hardware, and software requirements to install your DB2® database product.
All DB2 processes are stopped. If you are installing a DB2 database product on top of an existing DB2 installation on the computer, you must stop all DB2 applications, the DB2 database manager, and DB2 processes for all DB2 instances and DB2 DAS related to the existing DB2 installation.
Procedure
To perform a response file installation:

Mount your DB2 database product DVD or access the file system where the installation image is stored.
Create a response file using the sample response file. Refer to Creating a response file using the sample response file (Linux and UNIX).
Response files have a file type of .rsp. For example, ese.rsp.

Install DB2 using the response file. Refer to Installing a DB2 database product using a response file (Linux and UNIX).
Creating a response file using the sample response file (Linux and UNIX)
Installing a DB2 database product using a response file (Linux and UNIX)
Installing database partition servers on participating computers using a response file (Linux and UNIX)
In this task you will use the response file you created using the DB2 Setup wizard to install database partition servers on participating computers.
Response file error codes (Linux and UNIX)
Uninstalling a DB2 database product, feature, or language using a response file (Linux and UNIX)
To silently uninstall DB2 database products, features, or languages in a DB2 copy, use the db2_deinstall command with the -r option.


ref: https://www-01.ibm.com/support/knowledgecenter/#!/SSEPGG_9.7.0/com.ibm.db2.luw.qb.server.doc/doc/t0007298.html
ref: http://db2commerce.com/2012/06/25/installing-db2-using-a-response-file/

## db2 ese 安装相关的几个问题

1. 如何使用响应文件安装 db2 ese ?

	db2setup -r /path/to/response_file

2. response 文件模版哪里有？

	安装包目录中有模版。

3. ese 如何 添加 license ?

	db2licm -a /path/to/license ?

4. 一台机器是否可以按装多套不同版本的db2 产品？

	可以。使用 db2ls 查看各个安装版本的安装情况。

	同时：同一个版本，可以创建多个instance，一个instance可以创建多个数据库。

5. db2 安装前，要创建用户和组，为什么？ 

	https://bytes.com/topic/db2/answers/181692-what-db2-users-db2fenc1-dasusr1

说说我自己的理解：

a. 权限隔离－－什么的功能，就用什么样的用户来管理。隔离了权限，不至于混乱。否则一个文件谁都可以改，就乱套了。

b. 安全考虑。 其实 1 也就是安全考虑。

	http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSEPGG_9.7.0/com.ibm.db2.luw.qb.server.doc/doc/c0011931.html

	http://www.ibm.com/developerworks/data/library/techarticle/dm-0508wasserman/

	https://www-01.ibm.com/support/knowledgecenter/#!/SSEPGG_9.5.0/com.ibm.db2.luw.admin.sec.doc/doc/c0005375.html

c. 如何创建的问题：

	https://www-304.ibm.com/support/knowledgecenter/#!/SSEPGG_10.5.0/com.ibm.db2.luw.qb.server.doc/doc/t0007016.html

d. The fenced user is a user under which some stored procedures ("fenced"
stored procedures) can run to have reduced operating system authority.
This can help prevent fenced stored procedures from overwriting
instance files since the OS will prevent it.

	The DB2 administration server (DAS) user is the user under which the
DAS service runs. It is this service which you are really using with
the Control Center. In this case, the service is set up for the
opposite reasons from the fenced user: it's to prevent db2inst1 from
overwriting your admin configuration.


6. 强制重建 sample (testdb) 数据库：

    db2sampl  -force -sql -verbose -name testdb




7. 有哪些值得参考的 best practice ?

	http://blog.csdn.net/reaper1022/article/details/16370135

	http://www.douapp.com/post/52762

	http://www.centoscn.com/CentosServer/sql/2015/0516/5452.html

	http://db2commerce.com/2012/06/25/installing-db2-using-a-response-file/




## 分页大小测试

### 8k PAGESIZE 分页测试：

	create table testvarchar( c1 varchar(30000) ,c2 varchar(2000) ,c3 varchar(662) ) 
	DB20000I  The SQL command completed successfully.

32662 is ok  !
32663 is not ok !

	SQL0670N  The row length of the table exceeded a limit of "32677" bytes. 

说明，还有一些字节被其他东西占用了。


	create table testvarchar( c1 varchar(30000) ,c2 varchar(2000) ,c3 varchar(660) ) in testtbs01

	DB21034E  The command was processed as an SQL statement because it was not a 
	valid Command Line Processor command.  During SQL processing it returned:
	SQL0670N  The row length of the table exceeded a limit of "4005" bytes. (Table 
	space "TESTTBS01".)  SQLSTATE=54010


### 4K pagesize 分页测试：

	CREATE BUFFERPOOL testbpool  SIZE 2000 PAGESIZE 4K ;

	CREATE TABLESPACE testtbs01 PAGESIZE 4K MANAGED BY DATABASE USING (FILE '/tmp/UMPSYS01.dms' 10M)  BUFFERPOOL testbpool;

	drop table testvarchar;

	create table testvarchar(
     c1 varchar(4000)
     ) in testtbs01;



 可见:

     1.根据表空间分页大小的不同，对于行的存储大小也不同。这直接导致了varchar(n) 中 n 的大小限制。

     2.所谓分页，其实就是表中每条纪录的总长度限制。不管字段多少，算的是总和。

     3. sql messages 中提示的 limit 值，其实是偏大的。比如 4k的表空间 ，提示 limit ＝ 4005 ， 其实你只能 对varchar(n )  指定最大的n值为
     varchar(4000)  , varchar(4001) 都会报错。





##  在db2上授权一个用户db2etl，让这个用户具备dbadm & schema创建权限。

2015-12-15 Tue 20:57 PM

### db2 列出schema下所有的tables

	db2 list tables for schema syscat | grep -i auth

	db2 list tables for schema metadata




### 指定当前schema 
	
	set current schema = 'KALIE'


### database 已经默认为当前connect 的用户, 例如sample :

	GRANT DBADM ON DATABASE to db2admin  --- 是不行的，必须声明是 user , e.g:


	db2 grant dbadm on database to db2etl

DB21034E  The command was processed as an SQL statement because it was not a 
valid Command Line Processor command.  During SQL processing it returned:
SQL0569N  Authorization ID "DB2ETL" does not uniquely identify a user, a group 
or a role in the system.  SQLSTATE=56092

#### 解释：


SQL0569N
Authorization ID authorization-name does not uniquely identify a user, a group or a role in the system.

Explanation

The authorization ID specified by the GRANT or REVOKE statement does not uniquely identify a user, a role, or a group in the security namespace. The reference to authorization-name is ambiguous. Note that when using DCE security, the USER, GROUP or ROLE keyword is always required.

User response

Change the statement to explicitly specify the USER, GROUP or ROLE keyword to uniquely identify the specified authorization id.


ref: http://www-01.ibm.com/support/knowledgecenter/#!/S


#### 正确的姿势：使用db2inst1 ：

	[db2inst1@localhost ~]$ db2 grant dbadm on database to user db2etl

	DB20000I  The SQL command completed successfully.

#### 具备dbadm权限的用户，就具备了创建 db2 schema 的权限：

	db2 create schema skm1 AUTHORIZATION db2etl

	DB20000I  The SQL command completed successfully.


#### 查看某schema 下的表名：

	db2 "select TABSCHEMA,tabname from syscat.tables where tabschema = 'METADATA'"

set current schema = 'METADATA'

#### db2look 是本地客户端的命令，如果客户端版本和服务器有差别，db2look 可能用不了哦：


db2look -d sample -e -l -x  -z metadata -i db2etl -w db2etlpassword


#### 注意事项：

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


	user@localhost:~/sunline$ db2 -tvf db2.sql 
	CREATE TABLE "METADATA"."TMPLST"  ( "TO_INST_ID" VARCHAR(64) , "NLEVEL" INTEGER , "SCORT" VARCHAR(8000) ) IN "IBMDB2SAMPLEREL" 
	
	DB20000I  The SQL command completed successfully.

	user@localhost:~/sunline$ db2 grant select on METADATA.TMPLST to public
	
	DB20000I  The SQL command completed successfully.


以上，除了给db2etl赋 dbadm 权限用到db2inst1，其他操作都不需要。 只需要用db2etl即可。



##  一个union 语句引发的错误：

SELECT CD_ID, COLUMN_NAME, COMMENT, TYPE_NAME, INTEGER_IDX, ' ' AS PDKFLAG
FROM MPZ.DI_HIV_COLUMNS_V2
WHERE F_STARTDATE <= TO_DATE('20151202100600','YYYY-MM-DD HH24:MI:SS')
          AND F_ENDDATE > TO_DATE('20151202100600','YYYY-MM-DD HH24:MI:SS')
          AND DB_ID = 'WWW'
UNION
SELECT SD1.CD_ID, PKEY_NAME AS COLUMN_NAME, PKEY_COMMENT AS COMMENT, PKEY_TYPE AS TYPE_NAME, (COLUMN_SUM + INTEGER_IDX) AS INTEGER_IDX, 'P' AS PDKFLAG
FROM MPZ.DI_HIV_PARTITION_KEYS TPK
LEFT JOIN (
                SELECT TBL_ID, SD_ID
                FROM MPZ.DI_HIV_TBLS
                WHERE F_STARTDATE <= TO_DATE('20151202100600','YYYY-MM-DD HH24:MI:SS')
                      AND F_ENDDATE > TO_DATE('20151202100600','YYYY-MM-DD HH24:MI:SS')
                      AND DB_ID = 'WWW'
    ) T1
        ON TPK.TBL_ID = T1.TBL_ID
LEFT JOIN (
                SELECT SD_ID, CD_ID
                FROM MPZ.DI_HIV_SDS
                WHERE F_STARTDATE <= TO_DATE('20151202100600','YYYY-MM-DD HH24:MI:SS')
                      AND F_ENDDATE > TO_DATE('20151202100600','YYYY-MM-DD HH24:MI:SS')
                      AND DB_ID = 'WWW'
    ) SD1
    ON T1.SD_ID = SD1.SD_ID
LEFT JOIN (
                SELECT CD_ID, COUNT(*) AS COLUMN_SUM
                FROM MPZ.DI_HIV_COLUMNS_V2
                WHERE F_STARTDATE <= TO_DATE('20151202100600','YYYY-MM-DD HH24:MI:SS')
                      AND F_ENDDATE > TO_DATE('20151202100600','YYYY-MM-DD HH24:MI:SS')
                      AND DB_ID = 'WWW'
                GROUP BY CD_ID
        ) CS
        ON SD1.CD_ID = CS.CD_ID
WHERE F_STARTDATE <= TO_DATE('20151202100600','YYYY-MM-DD HH24:MI:SS')
          AND F_ENDDATE > TO_DATE('20151202100600','YYYY-MM-DD HH24:MI:SS')
          AND DB_ID = 'WWW'

其中 union 前面的语句有一个 varchar(4000) 的字段 。

union 后面 的 语句 有两个 varchar(4000) 字段。

union 的使用，触发了system  TEMPORARY TABLESPACE  的使用。

而使用 

[db2inst2@dmp ~]$ db2 "SELECT CHAR(TBSP_NAME,20) TBSP_NAME, TBSP_CONTENT_TYPE, TBSP_PAGE_SIZE 
     FROM SYSIBMADM.SNAPTBSP"

TBSP_NAME            TBSP_CONTENT_TYPE TBSP_PAGE_SIZE      
-------------------- ----------------- --------------------
SYSCATSPACE          ANY                               8192
TEMPSPACE1           SYSTEMP                           8192
USERSPACE1           LARGE                             8192
IBMDB2SAMPLEREL      LARGE                             8192
IBMDB2SAMPLEXML      LARGE                             8192
SYSTOOLSPACE         LARGE                             8192
US_METADATA          LARGE                            32768
MY32KSPACE           SYSTEMP                          32768

查询得知 TEMPSPACE1  是 8k 的表空间。执行union操作，需要使用 TEMPSPACE1 , 显然 对于有两个 varchar(4000) ＋ n个其他小字段的语句来说，8k不够。所以，要新增一个 pagesize 大一点的。如上，我新增了 MY32KSPACE 。 


SQL1585N  A system temporary table space with sufficient page size does
      not exist.

      Explanation: 

      One of the following conditions could have occurred:

      1. The row length of the system temporary table exceeded the limit that
         can be accommodated in the largest system temporary table space in
            the database.
            2. The number of columns required in a system temporary table exceeded
               the limit that can be accommodated in the largest system temporary
                  table space in the database.

                  The system temporary table space limits depend on its page size. These
                  values are:

                  Max          Max   Page size of
                  Record       Cols  temporary
                  Length             table space
                  -----------  ----  ------------
                  4005  bytes  500   4K
                  8101  bytes  1012  8K
                  16293 bytes  1012  16K
                  32677 bytes  1012  32K

                  User response: 

                  Create a system temporary table space of a larger page size supported,
                  if one does not already exist. If such a table space already exists,
                  eliminate one or more columns from the system temporary table. Create
                  separate tables or views, as required, to hold additional information
                  beyond the limit.

                   sqlcode: -1585

                    sqlstate: 54048


### 解决办法

--create bufferpool bpdefault32k IMMEDIATE  SIZE 5000 PAGESIZE 32 K;

CREATE TEMPORARY TABLESPACE MY32KSPACE 
  IN DATABASE PARTITION GROUP IBMTEMPGROUP 
  PAGESIZE 32K 
  MANAGED BY SYSTEM 
  USING 
  ('MY32KSPACE')
  EXTENTSIZE 32 
  PREFETCHSIZE 16 
  BUFFERPOOL bpdefault32k 
  OVERHEAD 24.10 
  TRANSFERRATE 0.90 
  DROPPED TABLE RECOVERY OFF; 


释疑1 ： 需要重新创建 tempspace1 吗？

不需要。 只需要增加一个就行。 db2 会选择合适的临时表空间来使用。


释疑2 ： tempspace1 能删除吗？

可以，但是需要先建一个备用的 同类型表空间。

释疑3 ： 不叫 tempspace1 的表空间，是否需要给它一个默认属性，以便执行查询的时候好匹配？

系统自动选择合适的表空间来执行语句，无需特意指定默认，也无法指定，貌似。

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


## db2 V10.5 ， 表行大小不再跟 表空间pagesize 分页大小挂钩

也就是说，一个 4k 的pagesize 表空间，也能创建 varchar(5000)字段。


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

## db2 字段1 like 字段2 匹配 问题－－使用 locate() 函数。

db2 like 不支持 函数。db2也不支持 || .  

http://stackoverflow.com/questions/6807593/sql-like-column-value-plus-wildcard-db2
https://bytes.com/topic/db2/answers/442801-how-compare-two-columns-db2-please-help
你要的功能是：字段1  like 字段2 ； 而db2 不支持 ||  , 所以 你用 concat()   .  但是 db2 的 like  , 又不支持 concat  . 所以你可以参考上面url的方法。
db2 ? SQL0132N 

FYI    

update: 新版db2 支持 ||  了。 但是还是不能用在 like 里。


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

## db2 查看数据库表空间情况

    $ db2 list tablespaces show detail



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


## DB2 建表注意事项

1. 尽量用大写

2. 尽量不用双引号

CREATE TABLE "METADATA"."tmplst"  ( "TO_inst_id" VARCHAR(64) , "nLevel" INTEGER , "sCort" VARCHAR(8000) )   IN "IBMDB2SAMPLEREL" 
CREATE TABLE METADATA.tmplst  ( TO_inst_id VARCHAR(64) , nLevel INTEGER , sCort VARCHAR(8000) )   IN IBMDB2SAMPLEREL 
大小写只是习惯问题。但是如果加了双引号，性质就变了。

3. 大写＋双引号 建的表，小写不带双引号,大写带双引号，大写不带双引号都可以访问。

4. 小写＋双引号 建的表  就只有小写＋双引号才能访问了。

## DB2 如何对日期timestamp设置默认值

    drop table tt;

    create table tt (
        begin_dt timestamp not null default current timestamp
            , end_dt timestamp not null default '2000-01-01 00:00:00'
            );

1. default 后面跟的日期必须是真实存在的日期。不能是0000-00-00... 之类的。

2. 不支持 default 0 

3. 00.000000 也支持, 例如：

    create table tt ( begin_dt timestamp not null default current timestamp , end_dt timestamp not null default '2000-01-01 00:00:00.000000' )

    DB20000I  The SQL command completed successfully.

keyword: db2 create table default value timestamp 0000

## db2 查报错方法： `db2 ? SQL1477N`

sql messages vs  sqlcode vs sqlstate 关系：

通过 `db2 ? sql_message` 命令，可以查找到 message 对应的 sqlcode 和 sqlstate 

sqlcode 是 sql return code .

sqlstate 有特定的编码方式：

    ref : https://www-01.ibm.com/support/knowledgecenter/#!/SSEPGG_10.1.0/com.ibm.db2.luw.messages.doc/doc/rdb2stt.html

如： 

    01002

中的 ｀01｀ 是 类别编码，对应一个特定类别。

后3位 `002` 叫 subcodes ， 是状态本身的编码。


此链接有 3种代码的基本概念介绍：

    https://www-01.ibm.com/support/knowledgecenter/#!/ssw_ibm_i_71/rzala/rzalakickoff.htm

### SQLCODE

An SQLCODE is a return code. The return code is sent by the database manager after completion of each SQL statement.

Each SQLCODE that is recognized by a DB2 for i application server has a corresponding message in the message file QSQLMSG. The message identifier for any SQLCODE is constructed by appending the absolute value (5 digits) of the SQLCODE to SQ and changing the third character to L if the first character of the SQLCODE is 0. For example, if the SQLCODE is 30070, the message identifier is SQ30070. If the SQLCODE is -0204, the message identifier is SQL0204. Lastly, if the SQLCODE is a 3-digit positive number, a zero is added before the first digit. For example, if the SQLCODE is 551, the message identifier is SQL0551.

### SQLSTATE
SQLSTATE provides application programs with common return codes for success, warning, and error conditions that are found among the DB2 products. SQLSTATE values are particularly useful when handling errors in distributed SQL applications. SQLSTATE values are consistent with the SQLSTATE specifications that are contained in the SQL 1999 standard.

An SQLSTATE value is a return code that indicates the outcome of the most recently executed SQL statement. The mechanism used to access SQLSTATE values depends on where the SQL statement is executed. In Java™, SQLSTATE values are returned by using the getSQLState() method. In SQL functions, SQL procedures, SQL triggers, and embedded applications other than Java, SQLSTATE values are returned in the following ways:
The last five bytes of the SQLCA
A stand-alone SQLSTATE variable
The GET DIAGNOSTICS statement
SQLSTATE values are designed so that application programs can test for specific conditions or classes of conditions.

SQLSTATE values are comprised of a two-character class code value, followed by a three-character subclass code value. Class code values represent classes of successful and unsuccessful completion conditions. If you want to use SQLSTATE as the basis of your application's return codes, you can define your own SQLSTATE classes or subclasses using the following guidelines:

SQLSTATE classes that begin with the characters 7 through 9 or I through Z can be defined. Within these classes, any subclass can be defined.
SQLSTATE classes that begin with the characters 0 through 6 or A through H are reserved for the database manager. Within these classes, subclasses that begin with the characters 0 through H are reserved for the database manager. Subclasses that begin with the characters I through Z can be defined.
The class code of an SQLSTATE value indicates whether the SQL statement was executed successfully (class codes 00 and 01) or unsuccessfully (all other class codes).

SQLSTATE is related to SQLCODE. Every SQLSTATE has one or more SQLCODEs associated with it. An SQLSTATE can refer to more than one SQLCODE.


#### 注意

1. SQLSTATE is related to SQLCODE. Every SQLSTATE has one or more SQLCODEs associated with it. An SQLSTATE can refer to more than one SQLCODE.

    sqlstate 1个 可对应 多个 sqlcodes . 也就是说，多个sqlcodes 可能共用一个 sqlstate . 

2. 每一个sqlstate的解释：

    http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSEPGG_9.5.0/com.ibm.db2.luw.messages.doc/doc/rdb2stt.html


### SQL message concepts
SQL messages are displayed when DB2® for i returns an error or warning code to the application that uses it.

To find a specific message, SQLCODE, or SQLSTATE, try the SQL message finder.

## SQL message finder


## db2 message code 前缀的含义

The suffix of a message identifier indicates the severity of the problem:
I - "Information"
W - "Warning"
E - "Error"
N - "Non-critical error"
C - "Critical error"

There is more information in the following topic titled "Introduction to messages":
http://www-01.ibm.com/support/knowledgecenter/api/content/SSEPGG_9.7.0/com.ibm.db2.luw.messages.doc/doc/c0052007.html

所有messages 大集合：

    http://www-01.ibm.com/support/knowledgecenter/#!/SSEPGG_9.7.0/com.ibm.db2.luw.messages.sql.doc/doc/rsqlmsg.html?cp=SSEPGG_9.7.0%2F2-6-27

## db2 修改日志文件大小和数量

2015-12-18 09:26 

 针对： sqlcode -964, sqlstate 57011 

 db2 get db cfg for sample

 db2 update db cfg for sample using LOGFILSIZ 4096
 db2 update db cfg for sample using LOGPRIMARY 25

 user@localhost:~/Git/gitblog_imx3/output/content$ db2 update db cfg for sample using LOGFILSIZ 4096
 DB20000I  The UPDATE DATABASE CONFIGURATION command completed successfully.
 SQL1363W  Database must be deactivated and reactivated before the changes to 
 one or more of the configuration parameters will be effective.
 user@localhost:~/Git/gitblog_imx3/output/content$ 
 user@localhost:~/Git/gitblog_imx3/output/content$ db2 update db cfg for sample using LOGPRIMARY 25
 DB20000I  The UPDATE DATABASE CONFIGURATION command completed successfully.
 SQL1363W  Database must be deactivated and reactivated before the changes to 
 one or more of the configuration parameters will be effective.

 ref: https://www-01.ibm.com/support/knowledgecenter/#!/SSEPGG_10.1.0/com.ibm.db2.luw.messages.sql.doc/doc/msql01363w.html



 根据官方解释：

 1. 不一定要重新激活。

 2. 如果要激活，就用deactivate / ACITVATE 命令重新激活。

 3. 重新激活时，最好远程到服务器上进行。并且fore掉／kill掉所有活动会话。

 [db2inst1@localhost ~]$ db2 DEACTIVATE DATABASE sample 
 SQL1495W  Deactivate database is successful, however, there is still a 
 connection to the database.
 [db2inst1@localhost ~]$ ps -ef|grep -i db2
 root       924 32365  0 09:05 pts/0    00:00:00 su - db2inst1
 db2inst1   925   924  0 09:05 pts/0    00:00:00 -bash
 db2inst1  1103     1  0 09:08 pts/0    00:00:00 /home/db2inst1/sqllib/bin/db2bp 925A501 5 A
 db2inst1  1191   925  0 09:10 pts/0    00:00:00 ps -ef
 db2inst1  1192   925  0 09:10 pts/0    00:00:00 grep -i db2
 db2fenc1  1879 32011  0 Dec16 ?        00:00:00 db2fmp ( ,0,0,0,0,0,0,2,1,0,8a65b0,14,1e014,2,0,1,131fc0,0x210000000,0x210000000,1600000,93000c,2,31088023
 db2fenc1  2270 32011  0 Dec16 ?        00:00:00 db2fmp ( ,0,0,0,0,0,0,2,1,0,8a65b0,14,1e014,2,0,1,151fc0,0x210000000,0x210000000,1600000,93000c,2,31138047
 db2fenc1  2887 32011  0 Dec16 ?        00:00:00 db2fmp ( ,0,0,0,0,0,0,2,1,0,8a65b0,14,1e014,2,0,1,171fc0,0x210000000,0x210000000,1600000,93000c,2,31250049
 db2fenc1  3252 32011  0 Dec16 ?        00:00:01 db2fmp ( ,0,0,0,0,0,0,2,1,0,8a65b0,14,1e014,2,0,1,191fc0,0x210000000,0x210000000,1600000,93000c,2,312e8050
 db2fenc1  6375 32011  0 Dec11 ?        00:00:00 db2fmp ( ,0,0,0,0,1,0,2,1,0,8a65b0,14,1e014,2,0,1,f1fc0,0x210000000,0x210000000,1600000,93000c,2,209a0039
 db2fenc1  7479 32011  0 Dec11 ?        00:00:01 db2fmp ( ,0,0,0,0,0,0,2,1,0,8a65b0,14,1e014,2,0,1,111fc0,0x210000000,0x210000000,1600000,93000c,2,20f20048
 db2fenc1  7650 32011  0 Dec08 ?        00:00:00 db2fmp ( ,0,0,0,0,0,0,2,1,0,8a65b0,14,1e014,2,0,1,b1fc0,0x210000000,0x210000000,1600000,93000c,2,1b9a8029
 db2fenc1 27110 32011  0 Dec03 ?        00:00:00 db2fmp ( ,0,0,0,0,0,0,2,1,0,8a65b0,14,1e014,2,0,1,91fc0,0x210000000,0x210000000,1600000,93000c,2,14cc002a
 root     32011     1  0 Nov17 ?        00:00:00 db2wdog                                         
 db2inst1 32013 32011  0 Nov17 ?        00:19:06 db2sysc                                        
 root     32014 32013  0 Nov17 ?        00:00:12 db2ckpwd                                        
 root     32015 32013  0 Nov17 ?        00:00:12 db2ckpwd                                        
 root     32016 32013  0 Nov17 ?        00:00:12 db2ckpwd                                        
 db2inst1 32028 32011  0 Nov17 ?        00:11:36 db2acd   ,0,0,0,1,0,0,2,1,0,8a65b0,14,1e014,2,0,1,11fc0,0x210000000,0x210000000,1600000,93000c,2,430016
 db2fenc1 32221 32011  0 Nov17 ?        00:00:03 db2fmp ( ,1,0,0,0,0,0,2,1,0,8a65b0,14,1e014,2,0,1,31fc0,0x210000000,0x210000000,1600000,93000c,2,54802d
 [db2inst1@localhost ~]$ kill 1103
 [db2inst1@localhost ~]$ kill 1103
 -bash: kill: (1103) - No such process
 [db2inst1@localhost ~]$ db2 DEACTIVATE DATABASE sample 
 SQL1496W  Deactivate database is successful, but the database was not 
 activated.
 [db2inst1@localhost ~]$ db2 activate DATABASE sample 
 DB20000I  The ACTIVATE DATABASE command completed successfully.

 已成功重激活。

 注意，force会话的步骤，是异步的。所以最后先让用户主动关闭连接。然后在force自动连接。

 [db2inst1@localhost ~]$ DB2 FORCE APPLICATION ALL
 -bash: DB2: command not found
 [db2inst1@localhost ~]$ db2 force application all
 DB20000I  The FORCE APPLICATION command completed successfully.
 DB21024I  This command is asynchronous and may not be effective immediately.


# 不能distinct 的几种数据类型：  CLOB, DBCLOB, BLOB, LONG VARCHAR, or LONG VARGRAPHIC 

user@localhost:~$ db2 "create table testlong( lv long varchar ) "

DB20000I  The SQL command completed successfully.

user@localhost:~$ db2 "select distinct lv from testlong"

SQL0134N  Improper use of a string column, host variable, constant, or 
function "LV".  SQLSTATE=42907

user@localhost:~$ db2 ? SQL0134N


    SQL0134N  Improper use of a string column, host variable, constant, or
      function "<name>".

      Explanation: 

      The use of the string "<name>" is not permitted.

      An expression resulting in a CLOB, DBCLOB, BLOB, LONG VARCHAR, or LONG
      VARGRAPHIC data type is not permitted in: 
      *  A SELECT DISTINCT statement
      *  A GROUP BY clause
      *  An ORDER BY clause
      *  A column function with DISTINCT
      *  A SELECT or VALUES statement of a set operator other than UNION ALL.

      Federated system users: in a pass-through session, a data
      source-specific restriction can cause this error. See the SQL Reference
      documentation for the failing data sources.

      The statement cannot be processed.

      User response: 

      The requested operation on the string is not supported.

       sqlcode: -134

        sqlstate: 42907

同事问我是不是long varchar 有什么限制，比如不能distinct group by ， 我测试了一下，发现不但long varchar  , 还有  CLOB, DBCLOB, BLOB, LONG VARCHAR, or LONG
583       VARGRAPHIC 等都不能 做 DISTINCT ， GROUP BY ， ORDER BY，set operator 。 

看来还是 勤动手，才能有更多收获！

# db2 ese 安装 

## 获取linux发行版本

cat /etc/*-release

CentOS release 6.5 (Final)
LSB_VERSION=base-4.0-amd64:base-4.0-noarch:core-4.0-amd64:core-4.0-noarch
CentOS release 6.5 (Final)
CentOS release 6.5 (Final)



## database pagesize 和 tablespace pagesize 的关系：

类似继承关系：

数据库的pagesize为创建数据库时作为缺省页大小的值，可能的取值包括4k，8k，16k和32k。当创建表空间或者是缓冲池的时候，如果不显式的指定pagesize的大小，创建的表空间将为缺省页的大小，如user1,syscat表空间等。因此从这个意义来说，数据库页大小在创建数据库时指定，之后就不能更改。


## db2acd 是什么，怎么关闭它？

安装db2 ese 时，如何在 response 文件中 指定了 DB2_FMP_COMM_HEAPSZ ， 那么在数据库安装完后，将会启动 db2acd进程。这个进程负责两项功能：

health monitor

automatic maintenance 

如何关闭？

把 DB2_FMP_COMM_HEAPSZ  设置为0 。 

http://www-01.ibm.com/support/docview.wss?uid=swg21259046

## SQL3006C An I/O error occurred while opening the message file. 如何处理

启发：

Most likely this happens, when the DB2 Fenced user has no write permissions in $DIAGPATH

解决办法： 查看db2diag.log ， 修改目录权限 ， 

切换到  /path/to/db2diag.log  所在目录

创建 db2sampl_Import.msg

修改权限：

[root@dmp db2diag]# chown db2fenc2:db2fadm2 db2sampl_Import.msg 

[root@dmp db2diag]# chmod 760 db2sampl_Import.msg 

ref:

https://www.ibm.com/developerworks/community/forums/html/topic?id=77777777-0000-0000-0000-000014852672


## 据说 db2 express-c 不支持分区表特性，怎么办？

安装 db2 ese ！ 

分区表特性是要单独授权的。当然，是在法律上是这样。但是在功能上，只要装好，注册过了（db2licm -a) ， 就可以直接使用分区功能。

````

ibm is supporting the product if you have a valid license
db partitioning has always been a separate product/feature to be paid for
you need a specific license for this feature
regards, guy 

DPF的licence其实只是商务上的事。 功能是可以用的，但是没有licence作为商用的话会有法律纠纷。

````

关于分区的使用方面，参考如下：

http://bingotree.cn/?p=546

http://www.ibm.com/developerworks/cn/data/dmmag/dbt15n3/DistributedDBA/

http://www.ibm.com/developerworks/data/library/techarticle/dm-1005partitioningkeys/





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

##  perl 中调用sql 空行导致的问题

00933: sql command not properly ended 

就是说sql命令不完整，非正常结束。

我把sql输出copy到 plsql 中执行，一点问题都没有。 但是在 perl sql 中， 就报这个错。

经仔细检查，发现代码里有一空行。

所以，请杜绝在sql代码中出现空行！


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

## oracle 和 python 交互

如何在 python 中 操纵 oracle ?

http://www.oracle.com/technetwork/articles/dsl/python-091105.html

## oracle response 文件安装方式是怎么回事？

1. response 文件安装 也叫响应文件安装方式。

2. response 文件有特定格式。

3. response 文件设定好之后，就不需要再用图形界面方式，通过鼠标点击和键盘输入进行下一步了。


## oracle 在执行 dml的时候 escape & (ampersand)符号？

    set define off

    SET ESCAPE ON;

## oracle 匿名块


<!-- $ -->

# 方法论

## 数据存储：分表与分区表

以前做电信行业的数据仓库时，每个统计日期的数据都是分表存储的。也就是每月／每日一张表。（我称之为方案A）

现在做银行数据仓库，采用的是分区表。也就是同一张表，不管有几天，都存放在一张表中。然后按日期分区存储。（我称之为方案B）

这样的好处是，表量减少了。像db2，对于整个数据库中的表的数量是有限制的。如果按日期分表，就会每个主题表每天产生一张表，最后库中的表将越积累越多。

当然，方案B建起索引来，应该要耗用更多的时间和存储。而方案A就会少些。

其次，在编码时，日期参数的传递方式也略有不同。

# 架构学习

General Relational Database Structure

https://en.wikibooks.org/wiki/Oracle_and_DB2,_Comparison_and_Compatibility/Architecture/Overview



# 优秀博客

## http://db2commerce.com/

ember crooks :

In 2014, IBM named me as an IBM Gold Consultant.

# 老牌论坛

http://www.dbforums.com




#  pgsql 


## 连接 & 查询 
-bash-4.1$ psql -U postgres ambari
psql (8.4.20)
Type "help" for help.

ambari=# SET search_path = ambari;
SET
ambari=# select count(0) from hosts;
 count 
 -------
      3
      (1 row)



