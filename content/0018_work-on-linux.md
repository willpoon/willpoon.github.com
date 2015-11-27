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

添加组etl
    groupadd etl
添加用户etl
    useradd db2etl -G etl

将新建的用户添加到sudo用户组，让用户不用重新登录，在当前会话切换到sudo 模式：

修改:

    /etc/sudoers

添加一行:

    yourlinuxuser ALL=(ALL) ALL



### 2015-11-18 22:27
使用find 查找权限为777 的文件，并改为755:

    find /path/to/file -perm 777 -type f -exec chmod 755 {} \;

使用shell 求昨日：

    stat_dt=`date -d "-1 days " +%Y%m%d`

这个在bi中很常用，我们常常需要确定最近一个统计日期是什么时候。原来date函数很强大，提供了我们想要的很多功能，只是我们没有充分发掘而已。

# Axel 

    Axel tries to accelerate HTTP/FTP downloading process by using multiple connections for one file. It can use multiple mirrors for a download. Axel has no dependencies and is lightweight, so it might be useful as a wget clone on byte-critical systems.

Axel , 多线程，轻量级，快过wget !!!


## git 

<!-- ^ --> 
 git 是一个非常非常非常优秀的版本管理，协同开发工具，设计精妙使用，功能强大无比！值得所有coder,甚至blogger学习！
<!-- $ --> 

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



[git] 2015-11-24 13:05 add git
