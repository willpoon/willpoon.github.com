Title: Work on linux!
Date: 2015-11-11 19:34
Modified: 2015-11-11 19:34
Category: Tech
Tags: linux
Slug: work-on-linux
Authors: Poon
Summary: Work on linux!   键盘党，终端控,我们用linux 来干活!鼠标?从来都只是用来玩游戏的！


键盘党，终端控,我们用linux 来干活!鼠标?从来都只是用来玩游戏的！

仅以此帖，记录在linux下的点点滴滴。

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

<s> 本文最后更新于：2015-11-11 19:34 </s>

本文最后更新于：2015-11-12 10:04


