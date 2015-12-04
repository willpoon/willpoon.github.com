Title: Work on Mac!
Category: Tech
Tags: Mac,OSX,Unix
Slug: work-on-Mac
Authors: Poon


Mac 是darwin unix 内核，很多东西跟linux不同。所以，还是单独把Mac拿出来说说。

仅以此帖，记录在linux下的点点滴滴。

[TOC]

## ulimit -n 65000

 -bash: ulimit: open files: cannot modify limit: Invalid argument

 这个异常跟mac 的版本有关。

格式:

    launchctl limit maxfiles softcnt hardcnt

修改soft：

    launchctl limit maxfiles 512 unlimited

修改hard:

    launchctl limit maxfiles unlimited unlimited


[1] 2015-11-26 09:41 init 


关于db2安装中遇到的ulimit参数问题，先改 sysctl.conf , 然后重启！很多问题都能解决！sysctl.conf ! 

## Mac 上 db2 的安装

db2 的安装还是得用root 用户进行。否则会报错的。


### db2 get dbm cfg 


### db2licm -l
Product name:                     "DB2 Express-C"
Expiry date:                      "02/23/2016 (Try & Buy)"
Product identifier:               "db2expc"
Version information:              "10.1"
Max number of CPUs:               "2"
Max amount of memory (GB):        "4"
Enforcement policy:               "Soft Stop"

### 创建实例：

/opt/IBM/db2/V10.1/instance/db2icrt


### 问题： db2start SQL1042C An unexpected system error occurred. SQLSTATE=58004

解决：
Wills-MacBook-Pro:sqllib db2inst1$ sudo chown db2inst1 /Users/db2inst1/sqllib/adm/*
Wills-MacBook-Pro:sqllib db2inst1$ db2start
SQL1063N  DB2START processing was successful.

http://stackoverflow.com/questions/33138859/cannot-db2start-using-db2-express-in-mac


### 问题 ： SQL1031N  The database directory cannot be found on the indicated file system. 
Wills-MacBook-Pro:sqllib db2inst1$ db2 connect to db2inst1
SQL1031N  The database directory cannot be found on the indicated file system. 

解决:
 Wills-MacBook-Pro:bin db2inst1$ db2sampl 

  Creating database "SAMPLE"...
  Connecting to database "SAMPLE"...
  Creating tables and data in schema "DB2INST1"...
  Creating tables with XML columns and XML data in schema "DB2INST1"...

  'db2sampl' processing complete.

Wills-MacBook-Pro:bin db2inst1$ pwd
/Users/db2inst1/sqllib/bin
Wills-MacBook-Pro:bin db2inst1$ db2 connect to sample

   Database Connection Information

 Database server        = DB2/DARWIN 10.1.0
 SQL authorization ID   = DB2INST1
 Local database alias   = SAMPLE

Wills-MacBook-Pro:bin db2inst1$ db2 "select count(0) from syscat.tables"

        467

  1 record(s) selected.



### mac下如何用date 做日期计算和调整 ， 例如，计算昨日。 

ref: http://lists.apple.com/archives/macos-x-server/2005/Sep/msg00067.html

date -v +1d +"%Y%m%d"
date -v -1d +"%Y%m%d"

-v      Adjust (i.e., take the current date and display the result of the adjustment; not actually set the date) the second, minute, hour, month day, week
             day, month or year according to val.  If val is preceded with a plus or minus sign, the date is adjusted forwards or backwards according to the
             remaining string, otherwise the relevant part of the date is set.  The date can be adjusted as many times as required using these flags.  Flags are
             processed in the order given.


### mac 上添加用户组

mac上不能像linux那样，用groupadd来添加用户中。网上有两种方法：

1. 通过 system preferences . 

2. 使用mac特有命令

### mac 上快捷键 与 windows / linux 对比

https://en.wikipedia.org/wiki/Table_of_keyboard_shortcuts

### mac 翻墙方法

试过了goagent , shadowsocks , 还是觉得shadowsocks 最简单，网速最给力。如果需要稳定的、持续的账号，可以到网上购买。否则就使用试用帐号就行了。


### mac上的破解软件到哪里找？

ifunmac  , 有些要钱，有些不要钱。我有帐号，有需要的可以和我联系。

### mac上挂载移动硬盘，只能读，不能写，如何解决？

我的系统是 yosemite , 试过了很多方法都不行。只能采用第三方的工具。Tuxera NTFS 2015 for Mac .

我是在官方网上下载的，试用了一下，没有什么问题。因为用得不多，所以没有购买。过期之后就没有用了。

真不明白为啥mac还给移动硬盘做写保护。

### mac上打开来自windows 得gbk 编码文件乱码如何解决？

需要转码。

把 iso 或 gbk 编码转成 utf8 . 转码脚本：

    toutf8 () 
    { 
        toutf8 ["filename_match"]
        if [ $# -ne 1 ]; then
            find . -type f -name "*.sh" -exec bash -c 'iconv -f gbk -t utf8 "{}" > ./"{}".i;mv "{}".i "{}"' \;; # 不加参数，默认转码shell文件
        fi;
        matchs=$1;
        find . -type f -name "${matchs}" -exec bash -c 'iconv -f gbk -t utf8 "{}" > ./"{}".i;mv "{}".i "{}"' \; # toutf8 "*.txt" 就转码 txt 文件
    }


核心命令是 ： iconv -f -t 

