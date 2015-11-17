Title: 主流数据库安装、维护、开发与管理
Date: 2015-11-17 10:59
Modified: 2015-11-17 10:59
Category: Tech
Tags: DB,database,数据库,db2,oracle,mysql
Slug: play-databases
Authors: Poon

<!-- ^ -->
记录数据库 安装、维护、开发与管理 的各种操作&技巧。包含但不仅限于db2,oracle , mysql , sqlite...

<!-- $ -->

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

本文最后更新于：2015-11-17 22:44
