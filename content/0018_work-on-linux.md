Title: Work on linux!
Category: Tech
Tags: linux,git
Slug: work-on-linux
Authors: Poon


键盘党，终端控,我们用linux 来干活!鼠标?从来都只是用来玩游戏的！

仅以此帖，记录在linux下的点点滴滴。

[TOC]

# 1. MYSQL 

## 1.1 

    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' identified by 'passwordhere' WITH GRANT OPTION;

如果不指定identified by , 那么就可以无密码登录了！！ 这时，应该指定 @'host' 。

## 1.2 本机无密码登录

    mysqld --skip-grant-tables

2015-11-11 19:47 , 就遇到一个问题：有人把mysql.user 表删掉了，无法登陆，这时，就需要使用这个方法来恢复 mysql.user.

## 1.3 /etc/rc.d/init.d/mysql 设置 

当你的mysql安装路径或者数据目录迁移了，/etc/my.cnf 设置变化了，就需要修改这个mysql shell 文件。否则，使用 service mysql start/stop 之类命令时，会有问题，比如找不到库等。

## 1.4 dig - DNS lookup utility

    dig www.imx3.com

结果：

    ;; QUESTION SECTION:
    ;www.imx3.com.          IN  A

    ;; ANSWER SECTION:
    www.imx3.com.       3600    IN  CNAME   willpoon.github.io.
    willpoon.github.io. 3600    IN  CNAME   github.map.fastly.net.
    github.map.fastly.net.  3600    IN  A   103.245.222.133


# 2. ps

## 使用 -o 选项 

    ps -o gid,time

结果：

  GID      TIME
   20   0:00.55
   20   0:00.70
   20   0:00.18
   20   0:00.04
   20   0:00.04


#3. proxychains4 

这个工具是让terminal中执行的命令也能翻墙，比如你要使用wget , curl , yum 下载软件，就可以使用 proxychains4 来翻墙下载。

搭配shadowsocks 效果不错噢。

    $ curl www.google.com

结果：

curl: (7) Failed to connect to www.google.com port 80: Operation timed out

使用proxychains4 :

    $ proxychains4 curl www.google.com

结果：

    [proxychains] config file found: /Users/poon/.proxychains/proxychains.conf
    [proxychains] preloading /usr/local/Cellar/proxychains-ng/4.10/lib/libproxychains4.dylib
    <HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
    <TITLE>302 Moved</TITLE></HEAD><BODY>
    <H1>302 Moved</H1>
    The document has moved
    <A HREF="http://www.google.com.hk/url?sa=p&amp;hl=zh-CN&amp;pref=hkredirect&amp;pval=yes&amp;q=http://www.google.com.hk/%3Fgws_rd%3Dcr&amp;ust=1447292938623279&amp;usg=AFQjCNHDVUkjopoYLPreTfeIum11Pmn0KQ">here</A>.
    </BODY></HTML>

#4. vi vim 

4.1 批量行缩进: ctrl-v + shift->

4.2 快捷键配置

使用pelican+markdown写博客，总是要手动输入日期时间，很是麻烦，作为一个geek，怎能忍受每次都手工修改日期这种事情发生呢？所以，必须找到一种能够一键插入时间戳的方法！
对于这种雕虫小技，stackoverflow早已经说烂了，于是，随便找了[一篇](http://stackoverflow.com/questions/56052/best-way-to-insert-timestamp-in-vim)

~/.vimrc命令: 

    nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
    imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

按f3的输出效果: 

     2015-11-08 Sun 11:06 AM

.vimrc 命令：

    nmap <F4> a<C-R>=strftime("%Y-%m-%d %H:%M")<CR><Esc>
    imap <F4> <C-R>=strftime("%Y-%m-%d %I:%M")<CR>

按f4的输出效果：

      2015-11-08 11:06


注意：f3的时间戳格式是不适合放在pelican的Date: 和 Modified 里的。f4才是。


现在，展示f3的用法：

    本文最后更新于 2015-11-08 Sun 11:23 AM  


That's it !

Enjoy!



# 5. svn 

## 5.1 回滚到上一版本
svn merge -c -2683 db_load_data_comm.sh 

# 6. linux shell builtin command 

###  监控网络/网卡 流量的工具/命令

1. watch more /proc/net/dev

2. ifstat

3. 还有很多第三方的工具


添加组etl
    groupadd etl
添加用户etl
    useradd db2etl -G etl

将新建的用户添加到sudo用户组，让用户不用重新登录，在当前会话切换到sudo 模式：

修改:

    /etc/sudoers

添加一行:

    yourlinuxuser ALL=(ALL) ALL




### 使用find 查找权限为777 的文件，并改为755:

2015-11-18 22:27

    find /path/to/file -perm 777 -type f -exec chmod 755 {} \;

使用shell 求昨日：

    stat_dt=`date -d "-1 days " +%Y%m%d`

这个在bi中很常用，我们常常需要确定最近一个统计日期是什么时候。原来date函数很强大，提供了我们想要的很多功能，只是我们没有充分发掘而已。

注意：在mac上用法不一样。需要使用-v参数

<!-- $ --> 

### shell 变量与字符串操作

2015-12-02 08:52

1. 求变量长度

命令:

    echo $HOME

输出：

    /Users/poon

命令：

    echo ${#HOME}

输出:

    11


参考：Bash 101 Hacks, by Ramesh Natarajan.  

<!-- $ --> 

# Axel 

    Axel tries to accelerate HTTP/FTP downloading process by using multiple connections for one file. It can use multiple mirrors for a download. Axel has no dependencies and is lightweight, so it might be useful as a wget clone on byte-critical systems.

Axel , 多线程，轻量级，快过wget !!!


## git 

 git 是一个非常非常非常优秀的版本管理，协同开发工具，设计精妙使用，功能强大无比！值得所有coder,甚至blogger学习！

1. 将当前工作副本会滚到指定版本

    git log # 获得版本提交历史

    git reset --hard <commit_id>

2. 本地文件删除后再从版本库中检出还原：

    git checkout filename


<s> 本文最后更新于：2015-11-11 19:34 </s>

## date 命令 求 yesterday 的方法，mac和linux 不一样！

linux : -d 参数

mac   : -v 参数

## control-m

### 什么是 control-m  的 ajf ?

ajf- active job file 把它看作一个任务列表（队列）就可以了。

http://www.ctmguru.com/2012/04/ajf-active-job-file.html

### jobname ods_biee... not found in table xxx, or incorrect job sequence number.

这个问题很可能是由于没有执行upload 操作导致的。 defjob －src 之后， 是需要在em中执行upload 的。 btw ， 有没有知道如何通过命令行方式执行upload操作的方法？似乎没有相关命令？

### control-m / CTM 使用defjob的时候，报连接问题

1. 需要先用control－m /desktop 连接到对应的服务器！

2. 当有多台服务器的时候，请确认是否连接到了正确的服务器上

### 如果使用命令行方式调起一个作业。(命令行order 作业)

    ctmorder -TABLE TABLENAME -NAME jobname -ODATE YYYYMMDD -INTO_TABLE_ORDERID [newt|last] -FORCE y


### 通过定义变量，调整 数据日期( data date )  和 执行(order date)日期 

%%DIR 路径变量

.   字符串连接符号

%%$ODATE builtin variable ,  order date

变量和字符串之间，通过 '.' 来连接。

变量引用一定要正确。

如果报 ： 5749 smart table already includes an instance of the job. 可能是同一个job 重复order , 而且order 之后，没有正常执行所致。解决的办法是：

在order 界面上，选择duplicate !




## stat 命令

stat -x filename 

获取 文件的 ctime , mtime , atime  ; change , modified , access



## mount 命令

2015-12-18 09:35

centos 上使用mount 命令 挂载虚拟光盘iso文件：

[root@iZ281s312fdZ ~]# sudo mkdir /mnt/iso
[root@iZ281s312fdZ iso]# mount -t iso9660 -o loop /opt/packages/DB2_ESE_9_7_0_0_LNXX86_64.iso /mnt/iso/

## 修改用户和修改用户组

usermod 

chgrp 

## 添加用户和添加组

groupadd 

useradd

## 查看一个用户和一个组的归属关系

id user_name

## 查看ssh登陆日志

### 最近登陆

lastlog 

### 历史登陆

cat /var/log/secure 

works on centos 6.5

## 如何看待新版os和旧版os , 如何选型。

近日，需要部署一套系统，涉及到系统的选型。选择定在 centos 上。

centos流行的 有 6.x ～ 7.x 多个版本。

6.x 是我用习惯了的。

7.x 还没有用过。

按这么来说，6.x 相对我来说，比较稳定。

但是如果某些软件对版本／内核有要求，那么低版本可能不兼容。比如，docker , 只能兼容 7.x 。


## ip  a 

centos 替代 ifconfig -a 

如果Centos7系统minimal方式安装是没有ifconfig命令的，可以通过安装net-tools解决。


## 虚拟机知识

### virtualbox的那个host-only链接是什么？有什么用？


基本上，Host-only相当于虚拟机和宿主机通过交叉线相连；
NAT，宿主机相当于虚拟机的路由器；
桥接，相当于把宿主机和虚拟机同时接到交换机上，然后交换机接到外网。

连接性上说，可参考下表：
连接                宿主机和虚拟机        虚拟机对外网访问        外网对虚拟机访问
Host-only              可以互访                不能直接访问                不能直接访问
NAT             虚拟机可访问宿主机      可以(通过宿主机)            不能直接访问
桥接                      可以互访                   直接访问                       直接访问


http://zhidao.baidu.com/link?url=Q7QGXk0IKKYAjLskS29h1q09n6T6xo1ERQzrU-g6EvCSeB6ywpsl5w3ulv1Me_EMiC0439cjnmWb1EQ-wqrT3q


[git] 2015-11-24 13:05 add git
