Title: 主流数据库安装、维护、开发与管理
Category: Tech
Tags: DB,database,数据库,db2,oracle,mysql
Slug: play-databases
Authors: Poon

记录数据库 安装、维护、开发与管理 的各种操作&技巧。包含但不仅限于db2,oracle , mysql , sqlite...

[TOC]

# DB2


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

## SQL3001C  An I/O error (reason = "sqlofopn -2079391743") occurred while  opening the output file.
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



# MYSQL 

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





2015-11-19 07:46 add SQL3001C 


## mysql limit 的用法：

    mysql> SELECT * FROM table LIMIT 5,10; // 检索记录行 6-15  

limit m,n:

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
   74    96     1   0 10:57AM ??         0:03.49 /usr/local/mysql/bin/mysqld --user=_mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --plugin-dir=/usr/local/mysql/lib/plugin --log-error=/usr/local/mysql/data/mysqld.local.err --pid-file=/usr/local/mysql/data/mysqld.local.pid

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
