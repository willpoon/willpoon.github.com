Title: Work on Mac!
Category: Tech
Tags: Mac,OSX,Unix
Slug: work-on-Mac
Authors: Poon


Mac 是darwin unix 内核，很多东西跟linux不同。所以，还是单独把Mac拿出来说说。

仅以此帖，记录在linux下的点点滴滴。

[TOC]

# ulimit -n 65000

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

# Mac 上 db2 的安装

db2 的安装还是得用root 用户进行。否则会报错的。


## db2 get dbm cfg 


## db2licm -l
Product name:                     "DB2 Express-C"
Expiry date:                      "02/23/2016 (Try & Buy)"
Product identifier:               "db2expc"
Version information:              "10.1"
Max number of CPUs:               "2"
Max amount of memory (GB):        "4"
Enforcement policy:               "Soft Stop"

## 创建实例：

/opt/IBM/db2/V10.1/instance/db2icrt


## 问题： db2start SQL1042C An unexpected system error occurred. SQLSTATE=58004

解决：
Wills-MacBook-Pro:sqllib db2inst1$ sudo chown db2inst1 /Users/db2inst1/sqllib/adm/*
Wills-MacBook-Pro:sqllib db2inst1$ db2start
SQL1063N  DB2START processing was successful.

http://stackoverflow.com/questions/33138859/cannot-db2start-using-db2-express-in-mac


## 问题 ： SQL1031N  The database directory cannot be found on the indicated file system. 
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



# mac下如何用date 做日期计算和调整 ， 例如，计算昨日。 

ref: http://lists.apple.com/archives/macos-x-server/2005/Sep/msg00067.html

date -v +1d +"%Y%m%d"
date -v -1d +"%Y%m%d"

-v      Adjust (i.e., take the current date and display the result of the adjustment; not actually set the date) the second, minute, hour, month day, week
             day, month or year according to val.  If val is preceded with a plus or minus sign, the date is adjusted forwards or backwards according to the
             remaining string, otherwise the relevant part of the date is set.  The date can be adjusted as many times as required using these flags.  Flags are
             processed in the order given.


# mac 上添加用户组

mac上不能像linux那样，用groupadd来添加用户中。网上有两种方法：

1. 通过 system preferences . 

2. 使用mac特有命令

# mac 上快捷键 与 windows / linux 对比

https://en.wikipedia.org/wiki/Table_of_keyboard_shortcuts

# mac 翻墙方法

试过了goagent , shadowsocks , 还是觉得shadowsocks 最简单，网速最给力。如果需要稳定的、持续的账号，可以到网上购买。否则就使用试用帐号就行了。


# mac上的破解软件到哪里找？

ifunmac  , 有些要钱，有些不要钱。我有帐号，有需要的可以和我联系。

# mac上挂载移动硬盘，只能读，不能写，如何解决？

我的系统是 yosemite , 试过了很多方法都不行。只能采用第三方的工具。Tuxera NTFS 2015 for Mac .

我是在官方网上下载的，试用了一下，没有什么问题。因为用得不多，所以没有购买。过期之后就没有用了。

真不明白为啥mac还给移动硬盘做写保护。

# mac上打开来自windows 得gbk 编码文件乱码如何解决？

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

# mac 自带的 preview 工具 的放大镜 功能

使用 ｀ (backtick) 符号就可以打开。 功能菜单： tools -> show magnifier 



<!-- ^ -->

# 使用markdown here 编辑微信公众号消息!

## 背景

这个公众号其实申请很久了，但是基本上没有发布过什么文章。原因是想起那需要点来点去的格式化工具栏就头疼。所以平时写的东西都只发布到博客上。今天突发奇想，有没有可以让微信公众号也支持markdown编辑的工具呢？强大的google没有让我失望：通过安装 chrome 插件：markdown here ， 可以一键渲染markdown语法！

## 如何使用

### 前提

1. 找梯子翻墙！
2. 安装chrome浏览器！
3. 去chrome 插件市场查找 markdown here 插件并安装之!

### 使用步骤

1. 像往常一样，打开素材管理界面，新建图文消息。
2. 使用markdown 语法 ： `#` , `##` , `###` 等等来排版&标记你的文章段落。
3. 最后，也是花腐朽为神奇的一步，就是，使用 `ctrl+alt+m` 来渲染你的文章。（当然也可以使用chrome 浏览器的右上角按钮，click to toggle markdown rendering ）

### Will's Hacking ways

如果你认为刚刚我说的就是最好的方法，那你就掉坑里了！😄！其实，我根本不按上面的方法走！为什么？
因为markdown here 有一个问题，就是如果你来回编辑、预览几次，你就看不到markdown的标记了！
这种情况下，如果你再次使用markdown标记编辑文章，就会有前后编辑排版不同步的问题！
所以，我强烈建议大家先使用第三方markdown编辑工具(比如mou , 但我会用vi咯)把markdown文件写好，然后再粘贴到微信自己的网页编辑其中！
那么你就会问：我之前插入的图片怎么办？对不起，你只好在点发布之前，再去插入图片等多媒体信息了！等一切都想好了，再发布，不是很好吗？

## 后记

现在你看到的这篇文章，就是用markdown来排版和渲染的，各位感觉如何？
虽然排版方便了，不过我也要小小吐槽一下，我刚习惯了用safari , 现在又不得不把chrome 常驻 `commnad + tab` 列表里头了！
大家如果在使用markdown过程中有什么问题或者心得，或者在文章中捉到了bug, 都欢迎点击左下角的`阅读原文`(如果你是微信公众号读者),或在评论区向我吐槽！



<!-- $ -->

# mac 上safari 偶尔不能打开网页问题

为何safari 会出现不能访问某些网址的情况？但是如果相同的链接用chrome打开，却可以？应该不是代理问题，因为我是用shadowsocks做的代理。两个浏览器应该是一样的代理效果。求解！

补充：

过一会刷新，又可以了，完全搞不懂 。。。。


# macbook pro 使用心得




# HoRNDIS: USB tethering driver for Mac OS X 

mac 平台下 的 usb 网络驱动 －－ 实现手机wifi通过usb分享

http://joshuawise.com/horndis
#

# l=两条命令搞定 mac yosemite ntfs分区读写挂载问题

1. 获取 uuid 

diskutil info /Volumes/MACX | grep UUID


2.  修改 fstab ( 请自行备份！）

echo "UUID=EC9AB3F7-9AF6-F2EC-C4EC-F22419F32464 none ntfs rw,auto,nobrowse" | sudo tee -a /etc/fstab


( 需要 root用户权限 )

3. 重新插拔ntfs 移动硬盘

ref: 
http://www.macx.cn/forum.php?mod=viewthread&tid=2134889&highlight=ntfs



# MAC 上 httpd 服务配置

## 配置文件路径：

/private/etc/apache2/httpd.conf


## 配置 /etc/hosts : 

127.0.0.1 poon.mac 

## 配置 httpd.conf

### 配置 documentRoot

DocumentRoot "/Library/WebServer/Documents"


### 配置 监听端口 


Listen 7777


### 配置服务名称


ServerName poon.mac:7777


### 配置服务器目录权限

# Deny access to the entirety of your server's filesystem. You must
# explicitly permit access to web content directories in other 
# <Directory> blocks below.
#
<Directory />
    AllowOverride none
    Require all denied
    Order allow,deny
    Allow from all
</Directory>

# 配置web应用存放路径 
DocumentRoot "/Library/WebServer/Documents"




# 今天你静态ip了吗？

2016-01-15 20:33

昨天，我把电脑的ip设置为静态了。

原因是我的虚拟机 在 host-guest 通讯的时候，在公司和在宿舍的网络环境不一样，ip经常变化。为了统一ip，我决定把ip写死。

ip写死后，还有一个好处：当你在公众场所的时候，不会乱连wifi，因为很多wifi很可能分配不到ip，或者不在一个网段。

有时你想连的时候，先想想，一定要连网吗？连网做什么？

如果上网只是聊天刷新闻和网页，还不如看看书，做些方案。


# 7z  
poon@Wills-MacBook-Pro:/Volumes/TOURO/biee12c$ brew install p7zip
==> Downloading https://homebrew.bintray.com/bottles/p7zip-15.09.yosemite.bottle.tar.gz
######################################################################## 100.0%
==> Pouring p7zip-15.09.yosemite.bottle.tar.gz
🍺  /usr/local/Cellar/p7zip/15.09: 100 files, 4.9M


分卷压缩的文件解压：只需要针对需要最小的：001 就可以了。
7z e  SampleAppv511p-appliance.zip.001  


# md5  命令

poon@Wills-MacBook-Pro:/Volumes/TOURO/biee12c$ md5 SampleAppv511p-appliance.zip.00* > md5.chksum.txt &


# sudo umount /Volumes/TOURO/
Password:
poon@Wills-MacBook-Pro:~/sunline$ 


# virtual box nat network 和 nat 比较

nwtwork 的好处，可以统一设置端口转发。

而 nat 则要每台机器都设置端口转发。

nat guest 和 guest 之间是不通的。



# 获得 字符串的md5值
poon@Wills-MacBook-Pro:~/Snippets/python$ echo -n 'passwordStr' | openssl md5
bffc5e18cd9cf8d7a18c341ac0d163bc


# ambari agent  的安装过程中，依赖配置文件：/etc/ambari-server/conf/ambari.properties
导致agent 安装失败。
手工安装 server 和 metrics ， 再次启动 agent ， ok！


