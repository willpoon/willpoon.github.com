Title: 大数据 best practice
Category: Tech
Tags: 大数据,hadoop
Slug: big_data
Authors: Poon

[TOC]

<!-- ^ -->

终于开始写大数据方面的东西了！这可能是关于大数据实践方面写得最详细的，详细里面写得最易懂的！

<!-- $ -->

# 注意事项 

1. 使用 ambari choose stack 来设置repo , 而且设置之后，也可以通过界面更改！

2. 虚拟机 一定要互通 ， 如果 nat不行，可用 host-only 方案！



# 我们面临什么问题？

1. 海量数据有待整理、分析、挖掘！

2. 普通的服务器无法承受如此大量的数据！

3. 我们的工程师之前都是在做传统数据分析，不知道大数据是什么鬼，有没有比较快的方法入门，最好有FAQ方面的知识，如果有人告诉我有哪些注意事项那就最好了！

# 工程师




# 安装手记 hdp 2.3 

echo "set -o vi" >> ~/.bashrc

# root/asdfasdf

# yum -y install wget 



# vi /etc/sysconfig/network-scripts/ifcfg-eth0

#  /etc/init.d/network restart


echo "10.0.2.5 hdp00" >> /etc/hosts
echo "10.0.2.6 hdp01" >> /etc/hosts
echo "10.0.2.7 hdp02" >> /etc/hosts


echo "hostname=hdp00" >> /etc/sysconfig/network

echo "hostname=hdp01" >> /etc/sysconfig/network

echo "hostname=hdp03" >> /etc/sysconfig/network



chkconfig NetworkManager off
chkconfig abrt-ccpp off
chkconfig abrtd off
chkconfig acpid off
chkconfig atd off 
chkconfig bluetooth off
chkconfig cpuspeed off
chkconfig cpuspeed off
chkconfig ip6tables off
chkconfig iptables off
chkconfig netconsole off
chkconfig netfs off
chkconfig postfix off
chkconfig restorecond off
chkconfig httpd off



提前安装mysql 

http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.3.0.0/hdp.repo


wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.1.0/ambari.repo -O /etc/yum.repos.d/ambari.repo

wget -nv http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.3.0.0/hdp.repo -O /etc/yum.repos.d/ambari.repo

yum install ambari-server




sharename="whatever.you.want.to.call.it"; 
sudo mkdir /mnt/$sharename
sudo chmod 777 /mnt/$sharename
sudo mount -t vboxsf -o uid=1000,gid=1000 $sharename /mnt/$sharename
ln -s /mnt/$sharename $HOME/Desktop/$sharename





--mac ftp server 
sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist




system preference : sharing 打开 mac 的 sftp 22 端口。 


poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist


# 使用 yum erase 移除安装包。

# ntp 时钟同步
systemctl is-enabled ntpd

systemctl enable ntpd

yum -y install ntp

#yum -y install ntpdate

[root@hdp00 ~]# systemctl is-enabled ntpd
disabled
[root@hdp00 ~]# systemctl enable ntpd
Created symlink from /etc/systemd/system/multi-user.target.wants/ntpd.service to /usr/lib/systemd/system/ntpd.service.
[root@hdp00 ~]# 

/etc/selinux/config

vi /etc/selinux/config set disable


# 设置无密码登录

## 先设置master机器无密码登录。等装完基础工具后，复制虚拟机的时候，再设置master-slave-的无密码登录。

# ip tables 

centos 7 minimal 默认没有 iptables , 如果有，需要关闭：


systemctl disable firewalld 

service firewalld stop


os环境配置完后，使用官方文档步骤安装

http://docs.hortonworks.com/HDPDocuments/Ambari-2.1.2.0/bk_Installing_HDP_AMB/bk_Installing_HDP_AMB-20150930.pdf

1.5.2. Setting Up a Local Repository


yum -y install yum-utils createrepo


http://www.cnblogs.com/tynia/p/offline-ambari.html

http://blog.csdn.net/poisonchry/article/details/37726663

http://www.cnblogs.com/tynia/p/offline-ambari.html

http://s3.amazonaws.com/public-repo-1.hortonworks.com/index.html


httpd-2.0.48-x86_64-unknown-linux-gnu.tar.gz

http://archive.apache.org/dist/httpd/binaries/linux/httpd-2.0.48-x86_64-unknown-linux-gnu.tar.gz

# httpd 

centos 7 不需要再网上找apache httpd 的包，只需要 执行如下命令即可！

[root@hdp00 httpd-2.4.18]# yum -y install httpd


## 启动 
[root@hdp00 httpd-2.4.18]# /sbin/service httpd start
Redirecting to /bin/systemctl start  httpd.service





#  把tar包解压到 /var/www/html 下：

cd /var/www/html 

ambari : ./

hdp : ./hdp/


[root@hdp00 html]# createrepo /var/www/html/AMBARI-2.1.2/centos7/
Spawning worker 0 with 6 pkgs
Workers Finished
Saving Primary metadata
Saving file lists metadata
Saving other metadata
Generating sqlite DBs
Sqlite DBs complete

[root@hdp00 html]# createrepo /var/www/html/hdp/HDP/centos7/2.x/updates/2.3.0.0/
Spawning worker 0 with 175 pkgs
Workers Finished
Saving Primary metadata
Saving file lists metadata
Saving other metadata
Generating sqlite DBs
Sqlite DBs complete


[root@hdp00 html]# createrepo /var/www/html/hdp/HDP-UTILS-1.1.0.20/repos/centos7/
Spawning worker 0 with 44 pkgs
Workers Finished
Saving Primary metadata
Saving file lists metadata
Saving other metadata
Generating sqlite DBs
Sqlite DBs complete

[root@hdp00 yum.repos.d]# yum clean all


[root@hdp00 yum.repos.d]# yum makecache


    # centos 6.1安装
        yum --disablerepo=\* --enablerepo=c6-local --config=./repo/CentOS-Local.repo -y localinstall rpm/*.rpm
            #centos 5.6 安装
                yum --disablerepo=\* --enablerepo=c5-local -c repo/CentOS-Local.repo -y localinstall rpm/*.rpm --nogpgcheck



## yum install --downloadonly

[root@hdp00 bak]# yum install --downloadonly postgresql-server

[root@hdp00 bak]# find / -name "post*rpm"
/var/cache/yum/x86_64/7/updates/packages/postgresql-9.2.14-1.el7_1.x86_64.rpm
/var/cache/yum/x86_64/7/updates/packages/postgresql-libs-9.2.14-1.el7_1.x86_64.rpm
/var/cache/yum/x86_64/7/updates/packages/postgresql-server-9.2.14-1.el7_1.x86_64.rpm


[root@hdp00 packages]# rpm -ivh postgresql-libs-9.2.14-1.el7_1.x86_64.rpm 
Preparing...                          ################################# [100%]
Updating / installing...
   1:postgresql-libs-9.2.14-1.el7_1   ################################# [100%]
   [root@hdp00 packages]# rpm -ivh postgresql-9.2.14-1.el7_1.x86_64.rpm 
   Preparing...                          ################################# [100%]
   Updating / installing...
      1:postgresql-9.2.14-1.el7_1        ################################# [100%]
      [root@hdp00 packages]# rpm -ivh  postgresql-server-9.2.14-1.el7_1.x86_64.rpm 
      Preparing...                          ################################# [100%]
      Updating / installing...
         1:postgresql-server-9.2.14-1.el7_1 ################################# [100%]
         [root@hdp00 packages]# 

# 安装 ambari-server 

[root@hdp00 packages]# yum install ambari-server


# 安装 java 

wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.rpm"

# Install Oracle Java 8 #
$ sudo rpm -ivh jdk-8u66-linux-x64.rpm

# Install Oracle Java 8 #
$ sudo rpm -ivh jdk-7u80-linux-x64.rpm

$ java -version
java version "1.8.0_66"
Java(TM) SE Runtime Environment (build 1.8.0_66-b17)
Java HotSpot(TM) 64-Bit Server VM (build 25.66-b17, mixed mode)


$ sudo nano .bashrc
JAVA_HOME="/usr/java/jdk1.8.0_66/bin/java"
JRE_HOME="/usr/java/jdk1.8.0_66/jre/bin/java"
PATH=$PATH:$HOME/bin:JAVA_HOME:JRE_HOME


 这两天做LAMP时才发现selinux这么个东西，发个关闭的方法！
 关闭SELinux的方法：
 修改/etc/selinux/config文件中的SELINUX="" 为 disabled ，然后重启。
 如果不想重启系统，使用命令setenforce 0


http://itchenyi.blog.51cto.com/4745638/1032696




[root@hdp00 ~]#         ambari-server setup
Using python  /usr/bin/python2.7
Setup ambari-server
Checking SELinux...
SELinux status is 'disabled'
Customize user account for ambari-server daemon [y/n] (n)? y
Enter user account for ambari-server daemon (root):y
Invalid username.
Enter user account for ambari-server daemon (root):root
Adjusting ambari-server permissions and ownership...
Checking firewall status...
Redirecting to /bin/systemctl status  iptables.service

Checking JDK...
[1] Oracle JDK 1.8 + Java Cryptography Extension (JCE) Policy Files 8
[2] Oracle JDK 1.7 + Java Cryptography Extension (JCE) Policy Files 7
[3] Custom JDK
==============================================================================
Enter choice (1): 1
To download the Oracle JDK and the Java Cryptography Extension (JCE) Policy Files you must accept the license terms found at http://www.oracle.com/technetwork/java/javase/terms/license/index.html and not accepting will cancel the Ambari Server setup and you must install the JDK and JCE files manually.
Do you accept the Oracle Binary Code License Agreement [y/n] (y)? y
Downloading JDK from http://public-repo-1.hortonworks.com/ARTIFACTS/jdk-8u40-linux-x64.tar.gz to /var/lib/ambari-server/resources/jdk-8u40-linux-x64.tar.gz
jdk-8u40-linux-x64.tar.gz... 21% (35.5 MB of 165.2 MB)


 Select n at Enter advanced database configuration to use the default, embedded PostgreSQL database for Ambari. The default PostgreSQL database name is ambari. The default user name and password are ambari/bigdata. Otherwise, to use an existing PostgreSQL, MySQL or Oracle database with Ambari, select y.

为了减少工作量，选默认数据库，不折腾。

Using python  /usr/bin/python2.7
Starting ambari-server
Ambari Server running with administrator privileges.
Organizing resource files at /var/lib/ambari-server/resources...
Server PID at: /var/run/ambari-server/ambari-server.pid
Server out at: /var/log/ambari-server/ambari-server.out
Server log at: /var/log/ambari-server/ambari-server.log
Waiting for server start....................
Ambari Server 'start' completed successfully.
[root@hdp00 ~]#          ambari-server status
Using python  /usr/bin/python2.7
Ambari-server status
Ambari Server running
Found Ambari Server PID: 2441 at: /var/run/ambari-server/ambari-server.pid
[root@hdp00 ~]# 

http://192.168.1.105:8080/#/login

admin/admin



[root@hdp00 ~]#  ambari-server stop
Using python  /usr/bin/python2.7
Stopping ambari-server
Ambari Server stopped

# keygen 无密码登录tricks 

如果 多台机器都是同用户名同密码，那么只需要设置一台机器的无密码登录即可。虚拟机拷贝的无密码登录设置继续有效。不同的只是

/etc/hosts 

/etc/sysconfig/network  hostname 变了。


Warning
The following hostnames are not valid FQDNs:

hdp00, hdp01, hdp02

This may cause problems during installation. Do you want to continue?

将域名修改为：

n00.kylin.hdp
n01.kylin.hdp
n02.kylin.hdp


# 安装 hive 还是需要 mysql server


# mysql 安装  on centos7 minimal

[root@n00 yum.repos.d]#  wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
--2016-01-10 18:36:46--  http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
Resolving dev.mysql.com (dev.mysql.com)... 137.254.60.11
Connecting to dev.mysql.com (dev.mysql.com)|137.254.60.11|:80... connected.
HTTP request sent, awaiting response... 302 Found
Location: http://repo.mysql.com//mysql-community-release-el7-5.noarch.rpm [following]
--2016-01-10 18:36:47--  http://repo.mysql.com//mysql-community-release-el7-5.noarch.rpm
Resolving repo.mysql.com (repo.mysql.com)... 104.114.152.210
Connecting to repo.mysql.com (repo.mysql.com)|104.114.152.210|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 6140 (6.0K) [application/x-redhat-package-manager]
Saving to: ‘mysql-community-release-el7-5.noarch.rpm’

100%[===========================================================================================================================================>] 6,140       --.-K/s   in 0s      

2016-01-10 18:36:49 (339 MB/s) - ‘mysql-community-release-el7-5.noarch.rpm’ saved [6140/6140]

[root@n00 yum.repos.d]# rpm -ivh mysql-community-release-el7-5.noarch.rpm --downloadonly
rpm: --downloadonly: unknown option
[root@n00 yum.repos.d]# rpm -ivh --downloadonly mysql-community-release-el7-5.noarch.rpm 
rpm: --downloadonly: unknown option
[root@n00 yum.repos.d]# 
[root@n00 yum.repos.d]# 
[root@n00 yum.repos.d]# 
[root@n00 yum.repos.d]# 
[root@n00 yum.repos.d]# 
[root@n00 yum.repos.d]# 
[root@n00 yum.repos.d]# 
[root@n00 yum.repos.d]# 
[root@n00 yum.repos.d]# rpm -ivh mysql-community-release-el7-5.noarch.rpm
Preparing...                          ################################# [100%]
Updating / installing...
   1:mysql-community-release-el7-5    ################################# [100%]
[root@n00 yum.repos.d]# 
[root@n00 yum.repos.d]# yum install mysql-community-server --downloadonly
Loaded plugins: fastestmirror
mysql-connectors-community                                                                                                                                    | 2.5 kB  00:00:00     
mysql-tools-community                                                                                                                                         | 2.5 kB  00:00:00     
mysql56-community                                                                                                                                             | 2.5 kB  00:00:00     
(1/3): mysql-connectors-community/x86_64/primary_db                                                                                                           | 8.6 kB  00:00:00     
(2/3): mysql-tools-community/x86_64/primary_db                                                                                                                |  22 kB  00:00:00     
(3/3): mysql56-community/x86_64/primary_db                                                                                                                    | 108 kB  00:00:01     
Loading mirror speeds from cached hostfile
 * base: mirrors.aliyun.com
 * epel: ftp.jaist.ac.jp
 * extras: mirrors.skyshe.cn
 * remi-safe: mirrors.mediatemple.net
 * updates: mirrors.aliyun.com
Resolving Dependencies
--> Running transaction check
---> Package mysql-community-server.x86_64 0:5.6.28-2.el7 will be installed
--> Processing Dependency: mysql-community-common(x86-64) = 5.6.28-2.el7 for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: mysql-community-client(x86-64) = 5.6.28-2.el7 for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(warnings) for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(strict) for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(if) for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(Sys::Hostname) for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(POSIX) for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(Getopt::Long) for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(File::Temp) for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(File::Spec) for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(File::Path) for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(File::Copy) for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(File::Basename) for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(Fcntl) for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(Data::Dumper) for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(DBI) for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: net-tools for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Processing Dependency: /usr/bin/perl for package: mysql-community-server-5.6.28-2.el7.x86_64
--> Running transaction check
---> Package mysql-community-client.x86_64 0:5.6.28-2.el7 will be installed
--> Processing Dependency: mysql-community-libs(x86-64) = 5.6.28-2.el7 for package: mysql-community-client-5.6.28-2.el7.x86_64
--> Processing Dependency: perl(Exporter) for package: mysql-community-client-5.6.28-2.el7.x86_64
---> Package mysql-community-common.x86_64 0:5.6.28-2.el7 will be installed
---> Package net-tools.x86_64 0:2.0-0.17.20131004git.el7 will be installed
---> Package perl.x86_64 4:5.16.3-286.el7 will be installed
--> Processing Dependency: perl-libs = 4:5.16.3-286.el7 for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl(Socket) >= 1.3 for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl(Scalar::Util) >= 1.10 for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl-macros for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl-libs for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl(threads::shared) for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl(threads) for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl(constant) for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl(Time::Local) for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl(Time::HiRes) for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl(Storable) for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl(Socket) for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl(Scalar::Util) for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl(Pod::Simple::XHTML) for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl(Pod::Simple::Search) for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl(Filter::Util::Call) for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: perl(Carp) for package: 4:perl-5.16.3-286.el7.x86_64
--> Processing Dependency: libperl.so()(64bit) for package: 4:perl-5.16.3-286.el7.x86_64
---> Package perl-DBI.x86_64 0:1.627-4.el7 will be installed
--> Processing Dependency: perl(RPC::PlServer) >= 0.2001 for package: perl-DBI-1.627-4.el7.x86_64
--> Processing Dependency: perl(RPC::PlClient) >= 0.2000 for package: perl-DBI-1.627-4.el7.x86_64
---> Package perl-Data-Dumper.x86_64 0:2.145-3.el7 will be installed
---> Package perl-File-Path.noarch 0:2.09-2.el7 will be installed
---> Package perl-File-Temp.noarch 0:0.23.01-3.el7 will be installed
---> Package perl-Getopt-Long.noarch 0:2.40-2.el7 will be installed
--> Processing Dependency: perl(Pod::Usage) >= 1.14 for package: perl-Getopt-Long-2.40-2.el7.noarch
--> Processing Dependency: perl(Text::ParseWords) for package: perl-Getopt-Long-2.40-2.el7.noarch
---> Package perl-PathTools.x86_64 0:3.40-5.el7 will be installed
--> Running transaction check
---> Package mariadb-libs.x86_64 1:5.5.44-2.el7.centos will be obsoleted
---> Package mysql-community-libs.x86_64 0:5.6.28-2.el7 will be obsoleting
---> Package perl-Carp.noarch 0:1.26-244.el7 will be installed
---> Package perl-Exporter.noarch 0:5.68-3.el7 will be installed
---> Package perl-Filter.x86_64 0:1.49-3.el7 will be installed
---> Package perl-PlRPC.noarch 0:0.2020-14.el7 will be installed
--> Processing Dependency: perl(Net::Daemon) >= 0.13 for package: perl-PlRPC-0.2020-14.el7.noarch
--> Processing Dependency: perl(Net::Daemon::Test) for package: perl-PlRPC-0.2020-14.el7.noarch
--> Processing Dependency: perl(Net::Daemon::Log) for package: perl-PlRPC-0.2020-14.el7.noarch
--> Processing Dependency: perl(Compress::Zlib) for package: perl-PlRPC-0.2020-14.el7.noarch
---> Package perl-Pod-Simple.noarch 1:3.28-4.el7 will be installed
--> Processing Dependency: perl(Pod::Escapes) >= 1.04 for package: 1:perl-Pod-Simple-3.28-4.el7.noarch
--> Processing Dependency: perl(Encode) for package: 1:perl-Pod-Simple-3.28-4.el7.noarch
---> Package perl-Pod-Usage.noarch 0:1.63-3.el7 will be installed
--> Processing Dependency: perl(Pod::Text) >= 3.15 for package: perl-Pod-Usage-1.63-3.el7.noarch
--> Processing Dependency: perl-Pod-Perldoc for package: perl-Pod-Usage-1.63-3.el7.noarch
---> Package perl-Scalar-List-Utils.x86_64 0:1.27-248.el7 will be installed
---> Package perl-Socket.x86_64 0:2.010-3.el7 will be installed
---> Package perl-Storable.x86_64 0:2.45-3.el7 will be installed
---> Package perl-Text-ParseWords.noarch 0:3.29-4.el7 will be installed
---> Package perl-Time-HiRes.x86_64 4:1.9725-3.el7 will be installed
---> Package perl-Time-Local.noarch 0:1.2300-2.el7 will be installed
---> Package perl-constant.noarch 0:1.27-2.el7 will be installed
---> Package perl-libs.x86_64 4:5.16.3-286.el7 will be installed
---> Package perl-macros.x86_64 4:5.16.3-286.el7 will be installed
---> Package perl-threads.x86_64 0:1.87-4.el7 will be installed
---> Package perl-threads-shared.x86_64 0:1.43-6.el7 will be installed
--> Running transaction check
---> Package perl-Encode.x86_64 0:2.51-7.el7 will be installed
---> Package perl-IO-Compress.noarch 0:2.061-2.el7 will be installed
--> Processing Dependency: perl(Compress::Raw::Zlib) >= 2.061 for package: perl-IO-Compress-2.061-2.el7.noarch
--> Processing Dependency: perl(Compress::Raw::Bzip2) >= 2.061 for package: perl-IO-Compress-2.061-2.el7.noarch
---> Package perl-Net-Daemon.noarch 0:0.48-5.el7 will be installed
---> Package perl-Pod-Escapes.noarch 1:1.04-286.el7 will be installed
---> Package perl-Pod-Perldoc.noarch 0:3.20-4.el7 will be installed
--> Processing Dependency: perl(parent) for package: perl-Pod-Perldoc-3.20-4.el7.noarch
--> Processing Dependency: perl(HTTP::Tiny) for package: perl-Pod-Perldoc-3.20-4.el7.noarch
---> Package perl-podlators.noarch 0:2.5.1-3.el7 will be installed
--> Running transaction check
---> Package perl-Compress-Raw-Bzip2.x86_64 0:2.061-3.el7 will be installed
---> Package perl-Compress-Raw-Zlib.x86_64 1:2.061-4.el7 will be installed
---> Package perl-HTTP-Tiny.noarch 0:0.033-3.el7 will be installed
---> Package perl-parent.noarch 1:0.225-244.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

=====================================================================================================================================================================================
 Package                                          Arch                            Version                                           Repository                                  Size
=====================================================================================================================================================================================
Installing:
 mysql-community-libs                             x86_64                          5.6.28-2.el7                                      mysql56-community                          2.0 M
     replacing  mariadb-libs.x86_64 1:5.5.44-2.el7.centos
 mysql-community-server                           x86_64                          5.6.28-2.el7                                      mysql56-community                           58 M
Installing for dependencies:
 mysql-community-client                           x86_64                          5.6.28-2.el7                                      mysql56-community                           19 M
 mysql-community-common                           x86_64                          5.6.28-2.el7                                      mysql56-community                          256 k
 net-tools                                        x86_64                          2.0-0.17.20131004git.el7                          base                                       304 k
 perl                                             x86_64                          4:5.16.3-286.el7                                  base                                       8.0 M
 perl-Carp                                        noarch                          1.26-244.el7                                      base                                        19 k
 perl-Compress-Raw-Bzip2                          x86_64                          2.061-3.el7                                       base                                        32 k
 perl-Compress-Raw-Zlib                           x86_64                          1:2.061-4.el7                                     base                                        57 k
 perl-DBI                                         x86_64                          1.627-4.el7                                       base                                       802 k
 perl-Data-Dumper                                 x86_64                          2.145-3.el7                                       base                                        47 k
 perl-Encode                                      x86_64                          2.51-7.el7                                        base                                       1.5 M
 perl-Exporter                                    noarch                          5.68-3.el7                                        base                                        28 k
 perl-File-Path                                   noarch                          2.09-2.el7                                        base                                        26 k
 perl-File-Temp                                   noarch                          0.23.01-3.el7                                     base                                        56 k
 perl-Filter                                      x86_64                          1.49-3.el7                                        base                                        76 k
 perl-Getopt-Long                                 noarch                          2.40-2.el7                                        base                                        56 k
 perl-HTTP-Tiny                                   noarch                          0.033-3.el7                                       base                                        38 k
 perl-IO-Compress                                 noarch                          2.061-2.el7                                       base                                       260 k
 perl-Net-Daemon                                  noarch                          0.48-5.el7                                        base                                        51 k
 perl-PathTools                                   x86_64                          3.40-5.el7                                        base                                        82 k
 perl-PlRPC                                       noarch                          0.2020-14.el7                                     base                                        36 k
 perl-Pod-Escapes                                 noarch                          1:1.04-286.el7                                    base                                        50 k
 perl-Pod-Perldoc                                 noarch                          3.20-4.el7                                        base                                        87 k
 perl-Pod-Simple                                  noarch                          1:3.28-4.el7                                      base                                       216 k
 perl-Pod-Usage                                   noarch                          1.63-3.el7                                        base                                        27 k
 perl-Scalar-List-Utils                           x86_64                          1.27-248.el7                                      base                                        36 k
 perl-Socket                                      x86_64                          2.010-3.el7                                       base                                        49 k
 perl-Storable                                    x86_64                          2.45-3.el7                                        base                                        77 k
 perl-Text-ParseWords                             noarch                          3.29-4.el7                                        base                                        14 k
 perl-Time-HiRes                                  x86_64                          4:1.9725-3.el7                                    base                                        45 k
 perl-Time-Local                                  noarch                          1.2300-2.el7                                      base                                        24 k
 perl-constant                                    noarch                          1.27-2.el7                                        base                                        19 k
 perl-libs                                        x86_64                          4:5.16.3-286.el7                                  base                                       687 k
 perl-macros                                      x86_64                          4:5.16.3-286.el7                                  base                                        43 k
 perl-parent                                      noarch                          1:0.225-244.el7                                   base                                        12 k
 perl-podlators                                   noarch                          2.5.1-3.el7                                       base                                       112 k
 perl-threads                                     x86_64                          1.87-4.el7                                        base                                        49 k
 perl-threads-shared                              x86_64                          1.43-6.el7                                        base                                        39 k

Transaction Summary
=====================================================================================================================================================================================
Install  2 Packages (+37 Dependent packages)

Total download size: 92 M
Background downloading packages, then exiting:
warning: /var/cache/yum/x86_64/7/mysql56-community/packages/mysql-community-common-5.6.28-2.el7.x86_64.rpm.4759.tmp: Header V3 DSA/SHA1 Signature, key ID 5072e1f5: NOKEY0:09:04 ETA 
Public key for mysql-community-common-5.6.28-2.el7.x86_64.rpm.4759.tmp is not installed
(1/39): mysql-community-common-5.6.28-2.el7.x86_64.rpm                                                                                                        | 256 kB  00:00:01     
(2/39): mysql-community-libs-5.6.28-2.el7.x86_64.rpm                                                                                                          | 2.0 MB  00:00:07     
(3/39): perl-Carp-1.26-244.el7.noarch.rpm                                                                                                                     |  19 kB  00:00:02     
(4/39): perl-Compress-Raw-Bzip2-2.061-3.el7.x86_64.rpm                                                                                                        |  32 kB  00:00:01     
(5/39): perl-Compress-Raw-Zlib-2.061-4.el7.x86_64.rpm                                                                                                         |  57 kB  00:00:01     
(6/39): net-tools-2.0-0.17.20131004git.el7.x86_64.rpm                                                                                                         | 304 kB  00:00:10     
(7/39): perl-Data-Dumper-2.145-3.el7.x86_64.rpm                                                                                                               |  47 kB  00:00:02     
(8/39): perl-DBI-1.627-4.el7.x86_64.rpm                                                                                                                       | 802 kB  00:00:10     
(9/39): perl-Exporter-5.68-3.el7.noarch.rpm                                                                                                                   |  28 kB  00:00:00     
(10/39): perl-File-Path-2.09-2.el7.noarch.rpm                                                                                                                 |  26 kB  00:00:00     
(11/39): perl-File-Temp-0.23.01-3.el7.noarch.rpm                                                                                                              |  56 kB  00:00:00     
(12/39): perl-Filter-1.49-3.el7.x86_64.rpm                                                                                                                    |  76 kB  00:00:01     
(13/39): perl-Getopt-Long-2.40-2.el7.noarch.rpm                                                                                                               |  56 kB  00:00:00     
(14/39): perl-HTTP-Tiny-0.033-3.el7.noarch.rpm                                                                                                                |  38 kB  00:00:00     
(15/39): perl-Encode-2.51-7.el7.x86_64.rpm                                                                                                                    | 1.5 MB  00:00:11     
(16/39): perl-IO-Compress-2.061-2.el7.noarch.rpm                                                                                                              | 260 kB  00:00:02     
(17/39): perl-PathTools-3.40-5.el7.x86_64.rpm                                                                                                                 |  82 kB  00:00:00     
(18/39): perl-PlRPC-0.2020-14.el7.noarch.rpm                                                                                                                  |  36 kB  00:00:00     
(19/39): perl-Pod-Escapes-1.04-286.el7.noarch.rpm                                                                                                             |  50 kB  00:00:00     
(20/39): perl-Pod-Perldoc-3.20-4.el7.noarch.rpm                                                                                                               |  87 kB  00:00:00     
(21/39): perl-Net-Daemon-0.48-5.el7.noarch.rpm                                                                                                                |  51 kB  00:00:02     
(22/39): perl-Pod-Usage-1.63-3.el7.noarch.rpm                                                                                                                 |  27 kB  00:00:00     
(23/39): perl-Scalar-List-Utils-1.27-248.el7.x86_64.rpm                                                                                                       |  36 kB  00:00:00     
(24/39): perl-Pod-Simple-3.28-4.el7.noarch.rpm                                                                                                                | 216 kB  00:00:04     
(25/39): perl-Socket-2.010-3.el7.x86_64.rpm                                                                                                                   |  49 kB  00:00:02     
(26/39): perl-Storable-2.45-3.el7.x86_64.rpm                                                                                                                  |  77 kB  00:00:01     
(27/39): perl-Text-ParseWords-3.29-4.el7.noarch.rpm                                                                                                           |  14 kB  00:00:01     
(28/39): perl-Time-HiRes-1.9725-3.el7.x86_64.rpm                                                                                                              |  45 kB  00:00:00     
(29/39): perl-Time-Local-1.2300-2.el7.noarch.rpm                                                                                                              |  24 kB  00:00:00     
(30/39): perl-constant-1.27-2.el7.noarch.rpm                                                                                                                  |  19 kB  00:00:00     
(31/39): perl-macros-5.16.3-286.el7.x86_64.rpm                                                                                                                |  43 kB  00:00:00     
(32/39): perl-parent-0.225-244.el7.noarch.rpm                                                                                                                 |  12 kB  00:00:00     
(33/39): perl-podlators-2.5.1-3.el7.noarch.rpm                                                                                                                | 112 kB  00:00:02     
(34/39): perl-threads-1.87-4.el7.x86_64.rpm                                                                                                                   |  49 kB  00:00:00     
(35/39): perl-threads-shared-1.43-6.el7.x86_64.rpm                                                                                                            |  39 kB  00:00:00     
(36/39): perl-libs-5.16.3-286.el7.x86_64.rpm                                                                                                                  | 687 kB  00:00:07     
(37/39): perl-5.16.3-286.el7.x86_64.rpm                                                                                                                       | 8.0 MB  00:00:41     
(38/39): mysql-community-client-5.6.28-2.el7.x86_64.rpm                                                                                                       |  19 MB  00:01:56     
(39/39): mysql-community-server-5.6.28-2.el7.x86_64.rpm                     97% [================================================================- ] 288 kB/s |  90 MB  00:00:07 ETA 


下载完后，直接执行：

[root@n00 ~]# yum install mysql-community-server


即可安装！ 但是！ 缓存文件也将同时被删除！




Is this ok [y/d/N]: y
Downloading packages:
warning: /var/cache/yum/x86_64/7/mysql56-community/packages/mysql-community-libs-5.6.28-2.el7.x86_64.rpm: Header V3 DSA/SHA1 Signature, key ID 5072e1f5: NOKEY
Retrieving key from file:/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
Importing GPG key 0x5072E1F5:
 Userid     : "MySQL Release Engineering <mysql-build@oss.oracle.com>"
 Fingerprint: a4a9 4068 76fc bd3c 4567 70c8 8c71 8d3b 5072 e1f5
 Package    : mysql-community-release-el7-5.noarch (installed)
 From       : file:/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
Is this ok [y/N]: y
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
Warning: RPMDB altered outside of yum.
  Installing : mysql-community-common-5.6.28-2.el7.x86_64                                                                                                                       1/40 
  Installing : mysql-community-libs-5.6.28-2.el7.x86_64                                                                                                                         2/40 
  Installing : 1:perl-parent-0.225-244.el7.noarch                                                                                                                               3/40 
  Installing : perl-HTTP-Tiny-0.033-3.el7.noarch                                                                                                                                4/40 
  Installing : perl-podlators-2.5.1-3.el7.noarch                                                                                                                                5/40 
  Installing : perl-Pod-Perldoc-3.20-4.el7.noarch                                                                                                                               6/40 
  Installing : 1:perl-Pod-Escapes-1.04-286.el7.noarch                                                                                                                           7/40 
  Installing : perl-Text-ParseWords-3.29-4.el7.noarch                                                                                                                           8/40 
  Installing : perl-Encode-2.51-7.el7.x86_64                                                                                                                                    9/40 
  Installing : perl-Pod-Usage-1.63-3.el7.noarch                                                                                                                                10/40 
  Installing : 4:perl-libs-5.16.3-286.el7.x86_64                                                                                                                               11/40 
  Installing : 4:perl-macros-5.16.3-286.el7.x86_64                                                                                                                             12/40 
  Installing : 4:perl-Time-HiRes-1.9725-3.el7.x86_64                                                                                                                           13/40 
  Installing : perl-Exporter-5.68-3.el7.noarch                                                                                                                                 14/40 
  Installing : perl-constant-1.27-2.el7.noarch                                                                                                                                 15/40 
  Installing : perl-Time-Local-1.2300-2.el7.noarch                                                                                                                             16/40 
  Installing : perl-Socket-2.010-3.el7.x86_64                                                                                                                                  17/40 
  Installing : perl-Carp-1.26-244.el7.noarch                                                                                                                                   18/40 
  Installing : perl-Storable-2.45-3.el7.x86_64                                                                                                                                 19/40 
  Installing : perl-PathTools-3.40-5.el7.x86_64                                                                                                                                20/40 
  Installing : perl-Scalar-List-Utils-1.27-248.el7.x86_64                                                                                                                      21/40 
  Installing : perl-File-Temp-0.23.01-3.el7.noarch                                                                                                                             22/40 
  Installing : perl-File-Path-2.09-2.el7.noarch                                                                                                                                23/40 
  Installing : perl-threads-shared-1.43-6.el7.x86_64                                                                                                                           24/40 
  Installing : perl-threads-1.87-4.el7.x86_64                                                                                                                                  25/40 
  Installing : perl-Filter-1.49-3.el7.x86_64                                                                                                                                   26/40 
  Installing : 1:perl-Pod-Simple-3.28-4.el7.noarch                                                                                                                             27/40 
  Installing : perl-Getopt-Long-2.40-2.el7.noarch                                                                                                                              28/40 
  Installing : 4:perl-5.16.3-286.el7.x86_64                                                                                                                                    29/40 
  Installing : perl-Data-Dumper-2.145-3.el7.x86_64                                                                                                                             30/40 
  Installing : perl-Compress-Raw-Bzip2-2.061-3.el7.x86_64                                                                                                                      31/40 
  Installing : perl-Net-Daemon-0.48-5.el7.noarch                                                                                                                               32/40 
  Installing : mysql-community-client-5.6.28-2.el7.x86_64                                                                                                                      33/40 
  Installing : 1:perl-Compress-Raw-Zlib-2.061-4.el7.x86_64                                                                                                                     34/40 
  Installing : perl-IO-Compress-2.061-2.el7.noarch                                                                                                                             35/40 
  Installing : perl-PlRPC-0.2020-14.el7.noarch                                                                                                                                 36/40 
  Installing : perl-DBI-1.627-4.el7.x86_64                                                                                                                                     37/40 
  Installing : net-tools-2.0-0.17.20131004git.el7.x86_64                                                                                                                       38/40 
  Installing : mysql-community-server-5.6.28-2.el7.x86_64                                                                                                                      39/40 
  Erasing    : 1:mariadb-libs-5.5.44-2.el7.centos.x86_64                                                                                                                       40/40 
  Verifying  : perl-HTTP-Tiny-0.033-3.el7.noarch                                                                                                                                1/40 
  Verifying  : perl-IO-Compress-2.061-2.el7.noarch                                                                                                                              2/40 
  Verifying  : perl-threads-shared-1.43-6.el7.x86_64                                                                                                                            3/40 
  Verifying  : 4:perl-Time-HiRes-1.9725-3.el7.x86_64                                                                                                                            4/40 
  Verifying  : net-tools-2.0-0.17.20131004git.el7.x86_64                                                                                                                        5/40 
  Verifying  : perl-Exporter-5.68-3.el7.noarch                                                                                                                                  6/40 
  Verifying  : perl-constant-1.27-2.el7.noarch                                                                                                                                  7/40 
  Verifying  : perl-PathTools-3.40-5.el7.x86_64                                                                                                                                 8/40 
  Verifying  : mysql-community-libs-5.6.28-2.el7.x86_64                                                                                                                         9/40 
  Verifying  : 4:perl-libs-5.16.3-286.el7.x86_64                                                                                                                               10/40 
  Verifying  : 4:perl-macros-5.16.3-286.el7.x86_64                                                                                                                             11/40 
  Verifying  : perl-Compress-Raw-Bzip2-2.061-3.el7.x86_64                                                                                                                      12/40 
  Verifying  : 1:perl-parent-0.225-244.el7.noarch                                                                                                                              13/40 
  Verifying  : perl-Net-Daemon-0.48-5.el7.noarch                                                                                                                               14/40 
  Verifying  : 4:perl-5.16.3-286.el7.x86_64                                                                                                                                    15/40 
  Verifying  : perl-File-Temp-0.23.01-3.el7.noarch                                                                                                                             16/40 
  Verifying  : 1:perl-Pod-Simple-3.28-4.el7.noarch                                                                                                                             17/40 
  Verifying  : perl-Time-Local-1.2300-2.el7.noarch                                                                                                                             18/40 
  Verifying  : mysql-community-client-5.6.28-2.el7.x86_64                                                                                                                      19/40 
  Verifying  : perl-Pod-Perldoc-3.20-4.el7.noarch                                                                                                                              20/40 
  Verifying  : perl-DBI-1.627-4.el7.x86_64                                                                                                                                     21/40 
  Verifying  : perl-Socket-2.010-3.el7.x86_64                                                                                                                                  22/40 
  Verifying  : perl-Carp-1.26-244.el7.noarch                                                                                                                                   23/40 
  Verifying  : perl-Data-Dumper-2.145-3.el7.x86_64                                                                                                                             24/40 
  Verifying  : mysql-community-common-5.6.28-2.el7.x86_64                                                                                                                      25/40 
  Verifying  : perl-Storable-2.45-3.el7.x86_64                                                                                                                                 26/40 
  Verifying  : perl-Scalar-List-Utils-1.27-248.el7.x86_64                                                                                                                      27/40 
  Verifying  : 1:perl-Compress-Raw-Zlib-2.061-4.el7.x86_64                                                                                                                     28/40 
  Verifying  : 1:perl-Pod-Escapes-1.04-286.el7.noarch                                                                                                                          29/40 
  Verifying  : mysql-community-server-5.6.28-2.el7.x86_64                                                                                                                      30/40 
  Verifying  : perl-Pod-Usage-1.63-3.el7.noarch                                                                                                                                31/40 
  Verifying  : perl-PlRPC-0.2020-14.el7.noarch                                                                                                                                 32/40 
  Verifying  : perl-Encode-2.51-7.el7.x86_64                                                                                                                                   33/40 
  Verifying  : perl-podlators-2.5.1-3.el7.noarch                                                                                                                               34/40 
  Verifying  : perl-Getopt-Long-2.40-2.el7.noarch                                                                                                                              35/40 
  Verifying  : perl-File-Path-2.09-2.el7.noarch                                                                                                                                36/40 
  Verifying  : perl-threads-1.87-4.el7.x86_64                                                                                                                                  37/40 
  Verifying  : perl-Filter-1.49-3.el7.x86_64                                                                                                                                   38/40 
  Verifying  : perl-Text-ParseWords-3.29-4.el7.noarch                                                                                                                          39/40 
  Verifying  : 1:mariadb-libs-5.5.44-2.el7.centos.x86_64                                                                                                                       40/40 

Installed:
  mysql-community-libs.x86_64 0:5.6.28-2.el7                                               mysql-community-server.x86_64 0:5.6.28-2.el7                                              

Dependency Installed:
  mysql-community-client.x86_64 0:5.6.28-2.el7  mysql-community-common.x86_64 0:5.6.28-2.el7  net-tools.x86_64 0:2.0-0.17.20131004git.el7  perl.x86_64 4:5.16.3-286.el7             
  perl-Carp.noarch 0:1.26-244.el7               perl-Compress-Raw-Bzip2.x86_64 0:2.061-3.el7  perl-Compress-Raw-Zlib.x86_64 1:2.061-4.el7  perl-DBI.x86_64 0:1.627-4.el7            
  perl-Data-Dumper.x86_64 0:2.145-3.el7         perl-Encode.x86_64 0:2.51-7.el7               perl-Exporter.noarch 0:5.68-3.el7            perl-File-Path.noarch 0:2.09-2.el7       
  perl-File-Temp.noarch 0:0.23.01-3.el7         perl-Filter.x86_64 0:1.49-3.el7               perl-Getopt-Long.noarch 0:2.40-2.el7         perl-HTTP-Tiny.noarch 0:0.033-3.el7      
  perl-IO-Compress.noarch 0:2.061-2.el7         perl-Net-Daemon.noarch 0:0.48-5.el7           perl-PathTools.x86_64 0:3.40-5.el7           perl-PlRPC.noarch 0:0.2020-14.el7        
  perl-Pod-Escapes.noarch 1:1.04-286.el7        perl-Pod-Perldoc.noarch 0:3.20-4.el7          perl-Pod-Simple.noarch 1:3.28-4.el7          perl-Pod-Usage.noarch 0:1.63-3.el7       
  perl-Scalar-List-Utils.x86_64 0:1.27-248.el7  perl-Socket.x86_64 0:2.010-3.el7              perl-Storable.x86_64 0:2.45-3.el7            perl-Text-ParseWords.noarch 0:3.29-4.el7 
  perl-Time-HiRes.x86_64 4:1.9725-3.el7         perl-Time-Local.noarch 0:1.2300-2.el7         perl-constant.noarch 0:1.27-2.el7            perl-libs.x86_64 4:5.16.3-286.el7        
  perl-macros.x86_64 4:5.16.3-286.el7           perl-parent.noarch 1:0.225-244.el7            perl-podlators.noarch 0:2.5.1-3.el7          perl-threads.x86_64 0:1.87-4.el7         
  perl-threads-shared.x86_64 0:1.43-6.el7      

Replaced:
  mariadb-libs.x86_64 1:5.5.44-2.el7.centos                                                                                                                                          

Complete!

[root@n02 yum.repos.d]#  yum install mysql-community-server
如果报依赖问题，需要 /etc/yum.repos.d/ 中添加 Cent*repo 支持 

cache 文件可以减少下载量，但是执行语句还是要联网。

mysqladmin -u root password "RootIsdanger"


 set password for `root`@`localhost` = password('RootIsDanger');
 mysql> exit


create user 'hive' identified by 'hive123';

grant all privileges on hive.* to hive;

flush privileges;


update user set password=PASSWORD('RootIsDanger') where user='root';  

[root@n01 ~]#  mysqld_safe --skip-grant-tables &
[1] 5686
[root@n01 ~]# 160111 02:14:15 mysqld_safe Logging to '/var/log/mysqld.log'.
160111 02:14:15 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql

[root@n01 ~]# 
[root@n01 ~]# 
[root@n01 ~]# 
[root@n01 ~]# 
[root@n01 ~]# mysql -uroot
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 1
Server version: 5.6.28 MySQL Community Server (GPL)

Copyright (c) 2000, 2015, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> set password for `root`@`localhost` = password('RootIsDanger');
ERROR 1290 (HY000): The MySQL server is running with the --skip-grant-tables option so it cannot execute this statement
mysql>  update user set password=PASSWORD('RootIsDanger') where user='root'; 
ERROR 1046 (3D000): No database selected
mysql> use mysql
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql>  update user set password=PASSWORD('RootIsDanger') where user='root'; 
Query OK, 4 rows affected (0.00 sec)
Rows matched: 4  Changed: 4  Warnings: 0

mysql>  flush privileges;
Query OK, 0 rows affected (0.00 sec)

mysql> quit
Bye





[root@n00 ~]#  ambari-server start


connection refused 的原因竟然是因为 没有

service httpd restart 


!!!!!!


今天的时间浪费在 网络上！

因为上班的地方是按流量收费的，我为了给公司省电流量，采用 rpm cache的方式 来安装 3台机器 的mysql 服务器！

1. 先在线安装一台，再离线安装另一台！

2. 离线安装的也依赖在线的包！



poon@Wills-MacBook-Pro:~/sunline$ VBoxManage modifyhd "/Users/poon/VirtualBox VMs/hdp01/hdp01.vdi" --resize 20000
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
poon@Wills-MacBook-Pro:~/sunline$ VBoxManage modifyhd "/Users/poon/VirtualBox VMs/hdp00/hdp00.vdi" --resize 20000
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
poon@Wills-MacBook-Pro:~/sunline$ VBoxManage modifyhd "/Users/poon/VirtualBox VMs/hdp02/hdp02.vdi" --resize 20000
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%

VBoxManage modifyhd "/Users/poon/VirtualBox VMs/hdp00--/hdp00--.vdi" --resize 30000
VBoxManage modifyhd "/Users/poon/VirtualBox VMs/hdp01--/hdp01--.vdi" --resize 30000
VBoxManage modifyhd "/Users/poon/VirtualBox VMs/hdp02--/hdp02--.vdi" --resize 30000

poon@Wills-MacBook-Pro:~/sunline/img$ VBoxManage modifyhd "/Users/poon/VirtualBox VMs/hdp00--/hdp00.vdi" --resize 30000
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
poon@Wills-MacBook-Pro:~/sunline/img$ VBoxManage modifyhd "/Users/poon/VirtualBox VMs/hdp01--/hdp01.vdi" --resize 30000
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
poon@Wills-MacBook-Pro:~/sunline/img$ VBoxManage modifyhd "/Users/poon/VirtualBox VMs/hdp02--/hdp02.vdi" --resize 30000
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%



VirtualBox虚拟机上网并主宿互访.md

https://github.com/ajiexw/Ajiex.com/blob/master/VirtualBox%E8%99%9A%E6%8B%9F%E6%9C%BA%E4%B8%8A%E7%BD%91%E5%B9%B6%E4%B8%BB%E5%AE%BF%E4%BA%92%E8%AE%BF.md


http://askubuntu.com/questions/446183/how-to-set-up-nat-and-host-only-networking-with-static-ip-address-in-virtualbox



    virtualbox vdi 文件系统扩容！

[root@n00 ~]# df -h
Filesystem               Size  Used Avail Use% Mounted on
/dev/mapper/centos-root   11G  8.2G  2.1G  80% /
devtmpfs                 487M     0  487M   0% /dev
tmpfs                    497M     0  497M   0% /dev/shm
tmpfs                    497M  6.6M  490M   2% /run
tmpfs                    497M     0  497M   0% /sys/fs/cgroup
/dev/sda1                497M  122M  375M  25% /boot
tmpfs                    100M     0  100M   0% /run/user/0
[root@n00 ~]# fdisk -l

Disk /dev/sda: 21.0 GB, 20971520000 bytes, 40960000 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x000a07b1

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048     1026047      512000   83  Linux
/dev/sda2         1026048    25165823    12069888   8e  Linux LVM

Disk /dev/mapper/centos-root: 11.0 GB, 11022630912 bytes, 21528576 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/mapper/centos-swap: 1287 MB, 1287651328 bytes, 2514944 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

[root@n00 ~]# fdisk -lh
Usage:
 fdisk [options] <disk>    change partition table
 fdisk [options] -l <disk> list partition table(s)
 fdisk -s <partition>      give partition size(s) in blocks

Options:
 -b <size>             sector size (512, 1024, 2048 or 4096)
 -c[=<mode>]           compatible mode: 'dos' or 'nondos' (default)
 -h                    print this help text
 -u[=<unit>]           display units: 'cylinders' or 'sectors' (default)
 -v                    print program version
 -C <number>           specify the number of cylinders
 -H <number>           specify the number of heads
 -S <number>           specify the number of sectors per track

[root@n00 ~]# fdisk -l

Disk /dev/sda: 21.0 GB, 20971520000 bytes, 40960000 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x000a07b1

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048     1026047      512000   83  Linux
/dev/sda2         1026048    25165823    12069888   8e  Linux LVM

Disk /dev/mapper/centos-root: 11.0 GB, 11022630912 bytes, 21528576 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/mapper/centos-swap: 1287 MB, 1287651328 bytes, 2514944 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

[root@n00 ~]# fdisk /dev/sda
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): n
Partition type:
   p   primary (2 primary, 0 extended, 2 free)
   e   extended
Select (default p): p
Partition number (3,4, default 3): 3
First sector (25165824-40959999, default 25165824): 
Using default value 25165824
Last sector, +sectors or +size{K,M,G} (25165824-40959999, default 40959999): 
Using default value 40959999
Partition 3 of type Linux and of size 7.5 GiB is set

Command (m for help): p

Disk /dev/sda: 21.0 GB, 20971520000 bytes, 40960000 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x000a07b1

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048     1026047      512000   83  Linux
/dev/sda2         1026048    25165823    12069888   8e  Linux LVM
/dev/sda3        25165824    40959999     7897088   83  Linux

Command (m for help): t
Partition number (1-3, default 3): 3
Hex code (type L to list all codes): 8e
Changed type of partition 'Linux' to 'Linux LVM'

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 16: Device or resource busy.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
Syncing disks.
[root@n00 ~]# reboot
Connection to 192.168.1.105 closed by remote host.
Connection to 192.168.1.105 closed.
poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ 
poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ 
poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ 
poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ 
poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ 
poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ 
poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ ssh root@192.168.1.105
root@192.168.1.105's password: 
Last login: Mon Jan 11 03:34:37 2016
[root@n00 ~]# fdisk -l

Disk /dev/sda: 21.0 GB, 20971520000 bytes, 40960000 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x000a07b1

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048     1026047      512000   83  Linux
/dev/sda2         1026048    25165823    12069888   8e  Linux LVM
/dev/sda3        25165824    40959999     7897088   8e  Linux LVM

Disk /dev/mapper/centos-root: 11.0 GB, 11022630912 bytes, 21528576 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/mapper/centos-swap: 1287 MB, 1287651328 bytes, 2514944 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

[root@n00 ~]# pvcreate  /dev/sda3
  Physical volume "/dev/sda3" successfully created
[root@n00 ~]# vgcreate centosvg /dev/sda3
  Volume group "centosvg" successfully created
[root@n00 ~]# vgscan
  Reading all physical volumes.  This may take a while...
  Found volume group "centos" using metadata type lvm2
  Found volume group "centosvg" using metadata type lvm2
[root@n00 ~]# vgmerge centos centosvg 
  Volume group "centosvg" successfully merged into "centos"
[root@n00 ~]# df -h
Filesystem               Size  Used Avail Use% Mounted on
/dev/mapper/centos-root   11G  8.2G  2.2G  80% /
devtmpfs                 487M     0  487M   0% /dev
tmpfs                    497M     0  497M   0% /dev/shm
tmpfs                    497M  6.6M  490M   2% /run
tmpfs                    497M     0  497M   0% /sys/fs/cgroup
/dev/sda1                497M  122M  375M  25% /boot
tmpfs                    100M     0  100M   0% /run/user/0
[root@n00 ~]#  lvextend -l+100%FREE /dev/mapper/centos-root
  Size of logical volume centos/root changed from 10.27 GiB (2628 extents) to 17.84 GiB (4566 extents).
  Logical volume root successfully resized.
[root@n00 ~]# df -h
Filesystem               Size  Used Avail Use% Mounted on
/dev/mapper/centos-root   11G  8.2G  2.2G  80% /
devtmpfs                 487M     0  487M   0% /dev
tmpfs                    497M     0  497M   0% /dev/shm
tmpfs                    497M  6.6M  490M   2% /run
tmpfs                    497M     0  497M   0% /sys/fs/cgroup
/dev/sda1                497M  122M  375M  25% /boot
tmpfs                    100M     0  100M   0% /run/user/0
[root@n00 ~]# resize2fs -p /dev/mapper/centos-root
resize2fs 1.42.9 (28-Dec-2013)
resize2fs: Bad magic number in super-block while trying to open /dev/mapper/centos-root
Couldn't find valid filesystem superblock.
[root@n00 ~]# resize2fs -p /dev/mapper/centos-root
resize2fs 1.42.9 (28-Dec-2013)
resize2fs: Bad magic number in super-block while trying to open /dev/mapper/centos-root
Couldn't find valid filesystem superblock.
[root@n00 ~]# mount |grep -i centos
/dev/mapper/centos-root on / type xfs (rw,relatime,attr2,inode64,noquota)
[root@n00 ~]# xfs_growfs
Usage: xfs_growfs [options] mountpoint

Options:
    -d          grow data/metadata section
    -l          grow log section
    -r          grow realtime section
    -n          don't change anything, just show geometry
    -i          convert log from external to internal format
    -t          alternate location for mount table (/etc/mtab)
    -x          convert log from internal to external format
    -D size     grow data/metadata section to size blks
    -L size     grow/shrink log section to size blks
    -R size     grow realtime section to size blks
    -e size     set realtime extent size to size blks
    -m imaxpct  set inode max percent to imaxpct
    -V          print version information
[root@n00 ~]# xfs_growfs /dev/mapper/centos-root
meta-data=/dev/mapper/centos-root isize=256    agcount=4, agsize=672768 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=0        finobt=0
data     =                       bsize=4096   blocks=2691072, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=0
log      =internal               bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
data blocks changed from 2691072 to 4675584
[root@n00 ~]# df -h
Filesystem               Size  Used Avail Use% Mounted on
/dev/mapper/centos-root   18G  8.2G  9.7G  46% /
devtmpfs                 487M     0  487M   0% /dev
tmpfs                    497M     0  497M   0% /dev/shm
tmpfs                    497M  6.6M  490M   2% /run
tmpfs                    497M     0  497M   0% /sys/fs/cgroup
/dev/sda1                497M  122M  375M  25% /boot
tmpfs                    100M     0  100M   0% /run/user/0
[root@n00 ~]# 





安装清单


Review
Please review the configuration before installation
Admin Name : admin

Cluster Name : kylinEnv

Total Hosts : 3 (3 new)

Repositories:

debian7 (HDP-2.3): 
http://public-repo-1.hortonworks.com/HDP/debian7/2.x/updates/2.3.4.0
debian7 (HDP-UTILS-1.1.0.20): 
http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/debian6
redhat6 (HDP-2.3): 
http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.3.4.0
redhat6 (HDP-UTILS-1.1.0.20): 
http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/centos6
redhat7 (HDP-2.3): 
http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.3.4.0
redhat7 (HDP-UTILS-1.1.0.20): 
http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/centos7
suse11 (HDP-2.3): 
http://public-repo-1.hortonworks.com/HDP/suse11sp3/2.x/updates/2.3.4.0
suse11 (HDP-UTILS-1.1.0.20): 
http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/suse11sp3
ubuntu12 (HDP-2.3): 
http://public-repo-1.hortonworks.com/HDP/ubuntu12/2.x/updates/2.3.4.0
ubuntu12 (HDP-UTILS-1.1.0.20): 
http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/ubuntu12
ubuntu14 (HDP-2.3): 
http://public-repo-1.hortonworks.com/HDP/ubuntu14/2.x/updates/2.3.4.0
ubuntu14 (HDP-UTILS-1.1.0.20): 
http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/ubuntu12
Services:

HDFS
DataNode : 3 hosts
NameNode : n00.kylin.hdp
NFSGateway : 0 host
SNameNode : n01.kylin.hdp
YARN + MapReduce2
App Timeline Server : n01.kylin.hdp
NodeManager : 3 hosts
ResourceManager : n01.kylin.hdp
Tez
Clients : 2 hosts
Hive
Metastore : n01.kylin.hdp
HiveServer2 : n01.kylin.hdp
WebHCat Server : n01.kylin.hdp
Database : MySQL (New MySQL Database)
HBase
Master : n00.kylin.hdp
RegionServer : 3 hosts
Phoenix Query Server : 0 host
Pig
Clients : 2 hosts
Sqoop
Clients : 2 hosts
ZooKeeper
Server : 3 hosts
Ambari Metrics
Metrics Collector : n02.kylin.hdp
Spark
History Server : n00.kylin.hdp


# 谈谈 hortonworks 和 cdh 

这两个产品是目前开源大数据平台的两大阵营

hdp 


HDP-2.3.4.0 

错误的地址：
http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/HDP-2.3.4.0-centos7-rpm.tar.gz


正确的地址：

http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.3.4.0/HDP-2.3.4.0-centos7-rpm.tar.gz

http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/centos7/HDP-UTILS-1.1.0.20-centos7.tar.gz




[root@sandbox network-scripts]# cat ifc*0
DEVICE="eth0"
BOOTPROTO="dhcp"
DHCP_HOSTNAME="sandbox.hortonworks.com"
DNS1="8.8.8.8"

IPV6INIT="no"
ONBOOT="yes"
TYPE="Ethernet"

NM_CONTROLLED=no
PEERDNS=no
[root@sandbox network-scripts]# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN qlen 1000
    link/ether 08:00:27:64:bc:5b brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global eth0
[root@sandbox network-scripts]# cat /etc/hosts
# File is generated from /usr/lib/hue/tools/start_scripts/gen_hosts.sh
# Do not remove the following line, or various programs
# that require network functionality will fail.
127.0.0.1       localhost.localdomain localhost
10.0.2.15   sandbox.hortonworks.com sandbox ambari.hortonworks.com
[root@sandbox network-scripts]# cat /etc/sysconfig/network
NETWORKING=yes
HOSTNAME=sandbox.hortonworks.com
RES_OPTIONS="single-request-reopen"


# 创建 repos

[root@n00 html]# createrepo HDP/centos6/2.x/updates/2.3.4.0
Spawning worker 0 with 175 pkgs
Workers Finished
Saving Primary metadata
Saving file lists metadata
Saving other metadata
Generating sqlite DBs
Sqlite DBs complete


# reposync  根据.repo 文件 中定义的安装包地址，把安装包同步到 本地。

# yum repolist

# select stack !!!!!

谨防被折叠！！

http://192.168.1.105:8080/#/installer/step2

# write: Connection reset by peer

因为有一台同样的ip的虚拟机在开着！！！

#  ambari-agent 日志  

[root@n00 yum.repos.d]# tail -f /var/log/ambari-agent/ambari-agent.log



# ambari-agent 和 ambari-server 

[root@hdp00 ~]# ambari-agent status
Found ambari-agent PID: 1521
ambari-agent running.
Agent PID at: /var/run/ambari-agent/ambari-agent.pid
Agent out at: /var/log/ambari-agent/ambari-agent.out
Agent log at: /var/log/ambari-agent/ambari-agent.log
[root@hdp00 ~]# ambari-agent restart
Restarting ambari-agent
Verifying Python version compatibility...
Using python  /usr/bin/python2.7
Found ambari-agent PID: 1521
Stopping ambari-agent
Removing PID file at /var/run/ambari-agent/ambari-agent.pid
ambari-agent successfully stopped
Verifying Python version compatibility...
Using python  /usr/bin/python2.7
Checking for previously running Ambari Agent...
Starting ambari-agent
Verifying ambari-agent process status...
Ambari Agent successfully started
Agent PID at: /var/run/ambari-agent/ambari-agent.pid
Agent out at: /var/log/ambari-agent/ambari-agent.out
Agent log at: /var/log/ambari-agent/ambari-agent.log
[root@hdp00 ~]# ambari-server restart
Using python  /usr/bin/python2.7
Restarting ambari-server
Using python  /usr/bin/python2.7
Stopping ambari-server
Ambari Server is not running
Using python  /usr/bin/python2.7
Starting ambari-server
Ambari Server running with administrator privileges.
Running initdb: This may take upto a minute.
About to start PostgreSQL
Organizing resource files at /var/lib/ambari-server/resources...
Server PID at: /var/run/ambari-server/ambari-server.pid
Server out at: /var/log/ambari-server/ambari-server.out
Server log at: /var/log/ambari-server/ambari-server.log
Waiting for server start....................
Ambari Server 'start' completed successfully.
[root@hdp00 ~]# 


# 首次默认使用 在线安装 的repo 路径：

http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.3.4.0

http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/centos7



# baseurl


[root@localhost ~]# cat /etc/yum.repos.d/ambari.repo 
#VERSION_NUMBER=2.1.2-377
[Updates-ambari-2.1.2]
name=ambari-2.1.2 - Updates
baseurl=http://192.168.1.110/ambari-2.2.0.0/centos7/2.2.0.0-1310
gpgcheck=1
enabled=1
priority=1

[HDP-2.3.4.0]
name=HDP Version - HDP-2.3.4.0
baseurl=http://192.168.1.110/HDP/centos6/2.x/updates/2.3.4.0
gpgcheck=1
enabled=1
priority=1
 

 [HDP-UTILS-1.1.0.20]
 name=HDP Utils Version - HDP-UTILS-1.1.0.20
 baseurl=http://192.168.1.110/HDP-UTILS-1.1.0.20/repos/centos7
 gpgcheck=1
 enabled=1
 priority=1


# 问题： 

http://192.168.1.105:8080/#/installer/step3

不能连接！

可能是：

ambari-server  没有启动，需要重启！

httpd 没有启动！

# 问题 ：

节点不能注册

Confirm Hosts
Registering your hosts.
Please confirm the host list and remove any hosts that you do not want to include in the cluster.

暂时不清楚：可能跟服务器环境配置有关系！


# 问题： 磁盘空间不够


The following registered hosts have issues related to disk space
Issues
Not enough disk space   Exists on 3 hosts

解决：对vdi文件扩容！




# 问题： The following packages should be uninstalled
Package
ranger_2_3_4_0_3485-hdfs-plugin.x86_64  0.5.0.2.3.4.0-3485.el6  Installed on 3 hosts
hive_2_3_4_0_3485-webhcat-server.noarch 1.2.1.2.3.4.0-3485.el6  Installed on 3 hosts
hive_2_3_4_0_3485.noarch    1.2.1.2.3.4.0-3485.el6  Installed on 3 hosts
ranger_2_3_4_0_3485-hive-plugin.x86_64  0.5.0.2.3.4.0-3485.el6  Installed on 3 hosts
hive_2_3_4_0_3485-jdbc.noarch   1.2.1.2.3.4.0-3485.el6  Installed on 3 hosts
hbase_2_3_4_0_3485-thrift2.noarch   1.1.2.2.3.4.0-3485.el6  Installed on 3 hosts
hadoop_2_3_4_0_3485-client.x86_64   2.7.1.2.3.4.0-3485.el6  Installed on 3 hosts
datafu_2_3_4_0_3485.noarch  1.3.0.2.3.4.0-3485.el6  Installed on 3 hosts
hive_2_3_4_0_3485-server2.noarch    1.2.1.2.3.4.0-3485.el6  Installed on 3 hosts
ranger_2_3_4_0_3485-hbase-plugin.x86_64 0.5.0.2.3.4.0-3485.el6  Installed on 3 hosts
flume_2_3_4_0_3485-agent.noarch 1.5.2.2.3.4.0-3485.el6  Installed on 3 hosts
hbase_2_3_4_0_3485-master.noarch    1.1.2.2.3.4.0-3485.el6  Installed on 3 hosts
accumulo_2_3_4_0_3485.x86_64    1.7.0.2.3.4.0-3485.el6  Installed on 3 hosts
falcon_2_3_4_0_3485-doc.noarch  0.6.1.2.3.4.0-3485.el6  Installed on 3 hosts
bigtop-tomcat.noarch    6.0.44-1.el6    Installed on 3 hosts
tez_2_3_4_0_3485.noarch 0.7.0.2.3.4.0-3485.el6  Installed on 3 hosts
hive_2_3_4_0_3485-hcatalog-server.noarch    1.2.1.2.3.4.0-3485.el6  Installed on 3 hosts
hbase_2_3_4_0_3485.noarch   1.1.2.2.3.4.0-3485.el6  Installed on 3 hosts
flume_2_3_4_0_3485.noarch   1.5.2.2.3.4.0-3485.el6  Installed on 3 hosts
hbase_2_3_4_0_3485-regionserver.noarch  1.1.2.2.3.4.0-3485.el6  Installed on 3 hosts
knox_2_3_4_0_3485.noarch    0.6.0.2.3.4.0-3485.el6  Installed on 1 host
accumulo_2_3_4_0_3485-conf-standalone.x86_64    1.7.0.2.3.4.0-3485.el6  Installed on 3 hosts
ranger_2_3_4_0_3485-kafka-plugin.x86_64 0.5.0.2.3.4.0-3485.el6  Installed on 1 host
phoenix_2_3_4_0_3485.noarch 4.4.0.2.3.4.0-3485.el6  Installed on 3 hosts
hadoop_2_3_4_0_3485.x86_64  2.7.1.2.3.4.0-3485.el6  Installed on 3 hosts
hive_2_3_4_0_3485-metastore.noarch  1.2.1.2.3.4.0-3485.el6  Installed on 3 hosts
hadoop_2_3_4_0_3485-mapreduce.x86_64    2.7.1.2.3.4.0-3485.el6  Installed on 3 hosts
mahout.noarch   0.9.0.2.3.4.0-3485.el6  Installed on 2 hosts
extjs.noarch    2.2-1   Installed on 3 hosts
ranger_2_3_4_0_3485-yarn-plugin.x86_64  0.5.0.2.3.4.0-3485.el6  Installed on 3 hosts
hadoop_2_3_4_0_3485-libhdfs.x86_64  2.7.1.2.3.4.0-3485.el6  Installed on 3 hosts
hive_2_3_4_0_3485-webhcat.noarch    1.2.1.2.3.4.0-3485.el6  Installed on 3 hosts
accumulo_2_3_4_0_3485-source.x86_64 1.7.0.2.3.4.0-3485.el6  Installed on 3 hosts
ranger_2_3_4_0_3485-knox-plugin.x86_64  0.5.0.2.3.4.0-3485.el6  Installed on 1 host
hbase_2_3_4_0_3485-doc.noarch   1.1.2.2.3.4.0-3485.el6  Installed on 3 hosts
hbase_2_3_4_0_3485-thrift.noarch    1.1.2.2.3.4.0-3485.el6  Installed on 3 hosts
kafka_2_3_4_0_3485.noarch   0.9.0.2.3.4.0-3485.el6  Installed on 1 host
accumulo_2_3_4_0_3485-test.x86_64   1.7.0.2.3.4.0-3485.el6  Installed on 3 hosts
hdp-select.noarch   2.3.4.0-3485.el6    Installed on 3 hosts
hadoop_2_3_4_0_3485-hdfs.x86_64 2.7.1.2.3.4.0-3485.el6  Installed on 3 hosts
hive_2_3_4_0_3485-hcatalog.noarch   1.2.1.2.3.4.0-3485.el6  Installed on 3 hosts
pig_2_3_4_0_3485.noarch 0.15.0.2.3.4.0-3485.el6 Installed on 3 hosts
falcon_2_3_4_0_3485.noarch  0.6.1.2.3.4.0-3485.el6  Installed on 3 hosts
atlas-metadata_2_3_4_0_3485-hive-plugin.noarch  0.5.0.2.3.4.0-3485.el6  Installed on 3 hosts
atlas-metadata_2_3_4_0_3485.noarch  0.5.0.2.3.4.0-3485.el6  Installed on 1 host
hive_2_3_4_0_3485-server.noarch 1.2.1.2.3.4.0-3485.el6  Installed on 3 hosts
zookeeper_2_3_4_0_3485.noarch   3.4.6.2.3.4.0-3485.el6  Installed on 3 hosts
mahout_2_3_4_0_3485.noarch  0.9.0.2.3.4.0-3485.el6  Installed on 2 hosts
hbase_2_3_4_0_3485-rest.noarch  1.1.2.2.3.4.0-3485.el6  Installed on 3 hosts
hadoop_2_3_4_0_3485-yarn.x86_64 2.7.1.2.3.4.0-3485.el6  Installed on 3 hosts
bigtop-jsvc.x86_64  1.0.10.2.3.4.0-3485.el6 Installed on 3 hosts
oozie_2_3_4_0_3485.noarch   4.2.0.2.3.4.0-3485.el6  Installed on 1 host
oozie_2_3_4_0_3485-client.noarch    4.2.0.2.3.4.0-3485.el6  Installed on 1 host
storm_2_3_4_0_3485.x86_64   0.10.0.2.3.4.0-3485.el6 Installed on 2 hosts
slider_2_3_4_0_3485.noarch  0.80.0.2.3.4.0-3485.el6 Installed on 2 hosts
ranger_2_3_4_0_3485-storm-plugin.x86_64 0.5.0.2.3.4.0-3485.el6  Installed on 2 hosts
storm_2_3_4_0_3485-slider-client.x86_64 0.10.0.2.3.4.0-3485.el6 Installed on 2 hosts

使用 yum erase  pkgname 移除！


# The following services should be up
Service
ntpd    Not running on 2 hosts

[root@hdp02 ~]# chkconfig ntpd on
Note: Forwarding request to 'systemctl enable ntpd.service'.
Created symlink from /etc/systemd/system/multi-user.target.wants/ntpd.service to /usr/lib/systemd/system/ntpd.service.
[root@hdp02 ~]# service ntpd restart
Redirecting to /bin/systemctl restart  ntpd.service
[root@hdp02 ~]# 


poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ VBoxManage list vms
"<inaccessible>" {1dddfeac-e5d5-40e4-a7a2-ac02189098b8}
"hdp00--" {3ae00f69-ee83-4f8a-af0c-5fc7f184d5ee}
"hdp01-bak" {549effe9-922d-49f8-8e61-4d41d3dabf7b}
"hdp02--" {f048e59a-2a75-4de0-b3bc-d0659ec7c173}
"hdp01--" {1b7e0868-d99e-48f1-a109-47581b662271}
"hdp00" {ca8782bb-adbf-4093-9ada-9bef9c9aa8b4}
"hdp01" {65294a54-f2b9-48dd-80a4-8d1dc5099744}
"hdp02" {e9e3c7fc-86de-4dd0-af83-c3962dd4d16b}
"Hortonworks Sandbox with HDP 2.3.2" {265999b1-b52e-4e99-b39c-014a64a70682}

# 生成移除清单

poon@Wills-MacBook-Pro:~/sunline$ for pkg in `cat /tmp/list ` ; do echo "ssh hdp01 yum -y erase $pkg "; done 
ssh hdp01 yum -y erase falcon_2_3_4_0_3485-doc.noarch 
ssh hdp01 yum -y erase hbase_2_3_4_0_3485-doc.noarch 
ssh hdp01 yum -y erase ranger_2_3_4_0_3485-hive-plugin.x86_64 
ssh hdp01 yum -y erase bigtop-tomcat.noarch 
ssh hdp01 yum -y erase kafka_2_3_4_0_3485.noarch 
ssh hdp01 yum -y erase extjs.noarch 
ssh hdp01 yum -y erase accumulo_2_3_4_0_3485-test.x86_64 
ssh hdp01 yum -y erase hdp-select.noarch 
ssh hdp01 yum -y erase atlas-metadata_2_3_4_0_3485-hive-plugin.noarch 
ssh hdp01 yum -y erase ranger_2_3_4_0_3485-yarn-plugin.x86_64 
ssh hdp01 yum -y erase knox_2_3_4_0_3485.noarch 
ssh hdp01 yum -y erase accumulo_2_3_4_0_3485-source.x86_64 
ssh hdp01 yum -y erase ranger_2_3_4_0_3485-hbase-plugin.x86_64 
ssh hdp01 yum -y erase zookeeper_2_3_4_0_3485.noarch 
ssh hdp01 yum -y erase ranger_2_3_4_0_3485-knox-plugin.x86_64 
ssh hdp01 yum -y erase ranger_2_3_4_0_3485-kafka-plugin.x86_64 
ssh hdp01 yum -y erase bigtop-jsvc.x86_64 
ssh hdp01 yum -y erase storm_2_3_4_0_3485-slider-client.x86_64 
ssh hdp01 yum -y erase oozie_2_3_4_0_3485-client.noarch 
ssh hdp01 yum -y erase ranger_2_3_4_0_3485-storm-plugin.x86_64 
ssh hdp01 yum -y erase slider_2_3_4_0_3485.noarch 
ssh hdp01 yum -y erase storm_2_3_4_0_3485.x86_64 


密码:
password : 
Oozie/Oozie



yum info installed

#   文档地址 ， 免提交 信息 
http://docs.hortonworks.com/HDPDocuments/Ambari-2.2.0.0/bk_Installing_HDP_AMB/content/index.html


# centos 6.5 hdp 安装 

## 

sandbox password:
wtfWTFwtf 





## DHCP 配置 


[root@n01 network-scripts]# cat ifcfg-eth0 
DEVICE="eth0"
BOOTPROTO="dhcp"
DHCP_HOSTNAME="n01.kylin.hdp"
DNS1="8.8.8.8"

IPV6INIT="no"
ONBOOT="yes"
TYPE="Ethernet"

NM_CONTROLLED=no
PEERDNS=no

## 固定ip 不支持端口转发？？dhcp 才支持！？



## 使用 scp 拷贝文件 

poon@Wills-MacBook-Pro:~$ scp -P 2223 /Users/poon/t.py  root@127.0.0.1:/root/tt.py
root@127.0.0.1's password: 
t.py                                                                                                                                               100%  157     0.2KB/s   00:00    
poon@Wills-MacBook-Pro:~$ 


以期达到如下目标：

1. 从host拷贝文件到远程机器

2. 如果是虚拟机，走端口转发的方式； 如果是远程机器，走公网ip地址。

3. 文件，目录都可以拷贝。



poon@Wills-MacBook-Pro:~$ scp -r -P 2223 /Users/poon/lab/  root@127.0.0.1:/root/lab/
root@127.0.0.1's password: 
1.html                                                                                                                                             100%   32KB  31.6KB/s   00:00    
goo.html                                                                                                                                           100%   19KB  18.9KB/s   00:00    
hi                                                                                                                                                 100%    5     0.0KB/s   00:00    
hitxt                                                                                                                                              100%    5     0.0KB/s   00:00    
host.no                                                                                                                                            100% 1260KB   1.2MB/s   00:00    
host.test                                                                                                                                          100% 1052KB   1.0MB/s   00:00    
host.yes                                                                                                                                           100% 1260KB   1.2MB/s   00:00    
ishadowsocks.com                                                                                                                                   100%   26KB  25.9KB/s   00:00    
torrent.html                                                                                                                                       100%   51KB  51.2KB/s   00:00    
poon@Wills-MacBook-Pro:~$ 


# 通过端口转发，所有的虚拟机端口资源都映射到宿主机的某个端口上。实现资源同一个ip访问。

127.0.0.1:2222 of host -> 127.0.0.1:22 of vm 




# MAC 上的 httpd.conf 配置文件

poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ find / -name httpd.conf 2>/dev/null
/Applications/MAMP/conf/apache/httpd.conf
/Applications/MAMP/conf/apache/original/httpd.conf
/Applications/MAMP PRO/MAMP PRO.app/Contents/Resources/httpd.conf
/private/etc/apache2/httpd.conf
/private/etc/apache2/original/httpd.conf
/Users/poon/Library/Application Support/appsolute/MAMP PRO/httpd.conf



这两个目录权限不同，在服务器上的现实效果不同。 需要 x 权限！
drwxr--r--  3 root  wheel    102 Jan 14 09:33 test
drwxr-xr-x  2 root  wheel     68 Jan 14 10:17 test2

# NAT固定ip 不能 在host通过端口转发访问guest？





# virtualbox 的端口转发 ， 要求guest 主机必须 设置为 dhcp 吗？

/etc/sysconfig/network-scripts/ 下 ifcfg* 设置为 静态ip时，在host使用 ：

sh root@127.0.0.1 -p 2223

连接：

报：

ssh_exchange_identification: Connection closed by remote host


# ifcfg-ethx 设置静态和动态的区别

1. 静态，dhcp 都能访问外网，但是 static 不能用 端口转发来访问 guest.


重启前：

poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ ssh root@127.0.0.1 -p 2223

ssh_exchange_identification: Connection closed by remote host
poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ 
添加 端口转发:
poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ VBoxManage modifyvm "n01.kylin.hdp" --natpf1 "guestssh,tcp,,2223,10.0.2.11,22"

重启后：

poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ ssh root@127.0.0.1 -p 2223
root@127.0.0.1's password: 
Last login: Thu Jan 14 13:13:55 2016
[root@n01 ~]# cat /etc/sysconfig/network-scripts/if
ifcfg-eth0     ifdown-bnep    ifdown-ipv6    ifdown-ppp     ifdown-tunnel  ifup-bnep      ifup-ipv6      ifup-plusb     ifup-routes    ifup-wireless  
ifcfg-lo       ifdown-eth     ifdown-isdn    ifdown-routes  ifup           ifup-eth       ifup-isdn      ifup-post      ifup-sit       
ifdown         ifdown-ippp    ifdown-post    ifdown-sit     ifup-aliases   ifup-ippp      ifup-plip      ifup-ppp       ifup-tunnel    
[root@n01 ~]# cat /etc/sysconfig/network-scripts/ifcfg-eth0 
DEVICE="eth0"
BOOTPROTO="none"
#DHCP_HOSTNAME="n01.kylin.hdp"

IPV6INIT="no"
ONBOOT="yes"
TYPE="Ethernet"

NM_CONTROLLED=no
PEERDNS=no

NETMASK=255.255.255.0
GATEWAY=10.0.2.2
IPADDR=10.0.2.11
DNS1="8.8.8.8"
[root@n01 ~]# 


 结果：

 可以转发！但是不能上外网！

[root@n01 ~]# exit
logout
Connection to 127.0.0.1 closed.
poon@Wills-MacBook-Pro:~/Git/gitblog_imx3/output/content$ ssh root@127.0.0.1 -p 2223
root@127.0.0.1's password: 
Last login: Thu Jan 14 13:18:21 2016 from 10.0.2.2
[root@n01 ~]# ping www.baidu.com
PING www.a.shifen.com (112.80.248.73) 56(84) bytes of data.
64 bytes from 112.80.248.73: icmp_seq=1 ttl=63 time=105 ms
64 bytes from 112.80.248.73: icmp_seq=2 ttl=63 time=86.4 ms
64 bytes from 112.80.248.73: icmp_seq=3 ttl=63 time=104 ms
64 bytes from 112.80.248.73: icmp_seq=4 ttl=63 time=89.1 ms
^C
--- www.a.shifen.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3202ms
rtt min/avg/max/mdev = 86.458/96.384/105.924/8.683 ms
[root@n01 ~]# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 08:00:27:15:6b:b4 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.11/24 brd 10.0.2.255 scope global eth0
    inet6 fe80::a00:27ff:fe15:6bb4/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
    link/ether 08:00:27:ba:74:79 brd ff:ff:ff:ff:ff:ff
[root@n01 ~]# cat /etc/sysconfig/network-scripts/ifcfg-eth0 
DEVICE="eth0"
BOOTPROTO="none"
#DHCP_HOSTNAME="n01.kylin.hdp"

IPV6INIT="no"
ONBOOT="yes"
TYPE="Ethernet"

NM_CONTROLLED=no
PEERDNS=no

NETMASK=255.255.255.0
GATEWAY=10.0.2.2
IPADDR=10.0.2.11
DNS1="8.8.8.8"
[root@n01 ~]# ping 10.0.2.11
PING 10.0.2.11 (10.0.2.11) 56(84) bytes of data.
64 bytes from 10.0.2.11: icmp_seq=1 ttl=64 time=0.026 ms
64 bytes from 10.0.2.11: icmp_seq=2 ttl=64 time=0.031 ms
^C
--- 10.0.2.11 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1566ms
rtt min/avg/max/mdev = 0.026/0.028/0.031/0.005 ms
[root@n01 ~]# 

----- 上述日志说明，静态＋ip ＋ vboxmange port forward 能实现 host 到 guest 的访问！


# 备份！！

[root@n01 .ssh]# ssh poon@host 'mkdir ~/vm_n01'
The authenticity of host 'host (192.168.1.222)' can't be established.
RSA key fingerprint is a7:50:db:4c:3e:96:47:af:07:c8:dc:ef:be:34:ef:b7.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'host' (RSA) to the list of known hosts.
[root@n01 .ssh]# ssh poon@host 'mkdir -p  ~/vm_n01/etc'
[root@n01 .ssh]# ssh poon@host 'mkdir -p  ~/vm_n01/etc/a/b'
[root@n01 .ssh]# ssh poon@host 'mkdir -p  ~/centos.hdp.kylin.n01/etc/'
[root@n01 .ssh]# scp /etc/hosts poon@host:/Users/poon/centos.hdp.kylin.n01/etc/hosts
hosts                                                                                                                                              100%  300     0.3KB/s   00:00    
[root@n01 .ssh]# scp /etc/sysconfig/network poon@host:/Users/poon/centos.hdp.kylin.n01/etc/host^C
[root@n01 .ssh]# ssh poon@host 'mkdir -p  ~/centos.hdp.kylin.n01/etc/sysconfig/'
[root@n01 .ssh]# scp /etc/sysconfig/network poon@host:/Users/poon/centos.hdp.kylin.n01/etc/sysconfig/network
network                                                                                                                                            100%   38     0.0KB/s   00:00    
[root@n01 .ssh]# scp -r /etc/sysconfig/network-scripts/*ifcfg* poon@host:/Users/poon/centos.hdp.kylin.n01/etc/sysconfig/
ifcfg-eth0                                                                                                                                         100%  207     0.2KB/s   00:00    
_ifcfg-eth0.dhcp                                                                                                                                   100%  212     0.2KB/s   00:00    
__ifcfg-eth0.static                                                                                                                                100%  206     0.2KB/s   00:00    
_ifcfg-eth0.static                                                                                                                                 100%  208     0.2KB/s   00:00    
_ifcfg-eth1.192.168                                                                                                                                100%  277     0.3KB/s   00:00    
ifcfg-lo                                                                                                                                           100%  254     0.3KB/s   00:00    
[root@n01 .ssh]# 



# 无密码登录原理！

请求登录的机器生产一条公钥。

上传到要登录的服务器

把公钥内容append到服务器的authorized_keys 字典文件中。

设置 authorized_keys 字典文件的权限。这个相当于一个保险箱。所以权限要尽量小。

退出服务器。

重新请求登录。

ref:

http://be-evil.org/linux-ssh-login-without-using-password.html

# host - guest 完美方案！

host 直接通过 127.0.0.1 -p xxxx ssh 到 guest !

guest 直接通过 192.168.1.x ssh 到 host !

guest 可以访问外网！

guest 拥有静态ip！

guest 可以自定义域名！

只要 host 能上网，所有虚拟机都能上网！

# 安装 ntpd 

yum -y install ntp  ( no D ) 


# Name Service Caching Daemon (NSCD) 

This daemon will cache host, user, and group lookups and provide better resolution performance, and reduced load on DNS infrastructure.


# no internet access 和 temporary internet access 的区别

• Setting Up a Local Repository with No Internet Access
• Setting Up a Local Repository with Temporary Internet Access


一个是要整个tar打包下载安装，一个是通过yum repo 下载安装 ！  第一个通过外部机器获取安装包。第二个通过本机临时上网拉取。



#  If you are using a symlink, enable the followsymlinks on your web server.

这个是一个很强大的功能！可以节约很多存储！


# 什么是 mirror server  镜像服务器！

这是一个相对概念。首先有一个实体的、主要的（原始的）服务器。

镜像服务器就是对原始服务器的备份？

为何要做镜像？是为了让不同网络环境的机器都能获取和原始服务器上一样的内容！


# repo 

http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.2.0.0/ambari.repo

# ambari 安装 centos 

[root@n01 yum.repos.d]# yum repolist
Loaded plugins: fastestmirror, priorities
Loading mirror speeds from cached hostfile
 * base: mirrors.yun-idc.com
 * extras: mirrors.yun-idc.com
 * updates: mirrors.yun-idc.com
http://192.168.1.222:7777/ambari-2.2.0.0/centos6/repodata/repomd.xml: [Errno 14] PYCURL ERROR 22 - "The requested URL returned error: 404 Not Found"
Trying other mirror.
repo id                                                                                  repo name                                                                             status
base                                                                                     CentOS-6 - Base                                                                       6,575
extras                                                                                   CentOS-6 - Extras                                                                        50
local-Updates-ambari-2.2.0.0                                                             ambari-2.2.0.0 - Updates                                                                  0
updates                                                                                  CentOS-6 - Updates                                                                        0
repolist: 6,625
[root@n01 yum.repos.d]# 
[root@n01 yum.repos.d]# 
[root@n01 yum.repos.d]# yum repolist^C
[root@n01 yum.repos.d]# yum install ambari-server
Loaded plugins: fastestmirror, priorities
Loading mirror speeds from cached hostfile
 * base: mirrors.yun-idc.com
 * extras: mirrors.yun-idc.com
 * updates: mirrors.yun-idc.com
http://192.168.1.222:7777/ambari-2.2.0.0/centos6/repodata/repomd.xml: [Errno 14] PYCURL ERROR 22 - "The requested URL returned error: 404 Not Found"
Trying other mirror.
Error: Cannot retrieve repository metadata (repomd.xml) for repository: local-Updates-ambari-2.2.0.0. Please verify its path and try again
[root@n01 yum.repos.d]# ll^C
[root@n01 yum.repos.d]# ll
total 20
-rw-r--r--. 1 root root  557 Jan 14 15:53 ambari.repo
-rw-r--r--. 1 root root 1926 Nov 27  2013 CentOS-Base.repo
-rw-r--r--. 1 root root  638 Nov 27  2013 CentOS-Debuginfo.repo
-rw-r--r--. 1 root root  630 Nov 27  2013 CentOS-Media.repo
-rw-r--r--. 1 root root 3664 Nov 27  2013 CentOS-Vault.repo
[root@n01 yum.repos.d]# vi ambari.repo 
[root@n01 yum.repos.d]# yum install ambari-server
Loaded plugins: fastestmirror, priorities
Loading mirror speeds from cached hostfile
 * base: mirrors.yun-idc.com
 * extras: mirrors.yun-idc.com
 * updates: mirrors.yun-idc.com
local-Updates-ambari-2.2.0.0                                                                                                                                  | 2.9 kB     00:00     
local-Updates-ambari-2.2.0.0/primary_db                                                                                                                       | 5.8 kB     00:00     
Setting up Install Process
Resolving Dependencies
--> Running transaction check
---> Package ambari-server.x86_64 0:2.2.0.0-1310 will be installed
--> Processing Dependency: postgresql-server >= 8.1 for package: ambari-server-2.2.0.0-1310.x86_64
--> Running transaction check
---> Package postgresql-server.x86_64 0:8.4.20-4.el6_7 will be installed
--> Processing Dependency: postgresql-libs(x86-64) = 8.4.20-4.el6_7 for package: postgresql-server-8.4.20-4.el6_7.x86_64
--> Processing Dependency: postgresql(x86-64) = 8.4.20-4.el6_7 for package: postgresql-server-8.4.20-4.el6_7.x86_64
--> Processing Dependency: libpq.so.5()(64bit) for package: postgresql-server-8.4.20-4.el6_7.x86_64
--> Running transaction check
---> Package postgresql.x86_64 0:8.4.20-4.el6_7 will be installed
---> Package postgresql-libs.x86_64 0:8.4.20-4.el6_7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

=====================================================================================================================================================================================
 Package                                     Arch                             Version                                   Repository                                              Size
=====================================================================================================================================================================================
Installing:
 ambari-server                               x86_64                           2.2.0.0-1310                              local-Updates-ambari-2.2.0.0                           406 M
Installing for dependencies:
 postgresql                                  x86_64                           8.4.20-4.el6_7                            updates                                                2.6 M
 postgresql-libs                             x86_64                           8.4.20-4.el6_7                            updates                                                202 k
 postgresql-server                           x86_64                           8.4.20-4.el6_7                            updates                                                3.4 M

Transaction Summary
=====================================================================================================================================================================================
Install       4 Package(s)

Total download size: 412 M
Installed size: 461 M
Is this ok [y/N]: y
Downloading Packages:
(1/4): ambari-server-2.2.0.0-1310.x86_64.rpm                                                                                                                  | 406 MB     00:10     
(2/4): postgresql-8.4.20-4.el6_7.x86_64.rpm                                                                                                                   | 2.6 MB     00:04     
(3/4): postgresql-libs-8.4.20-4.el6_7.x86_64.rpm                                                                                                              | 202 kB     00:00     
(4/4): postgresql-server-8.4.20-4.el6_7.x86_64.rpm                                                                                                            | 3.4 MB     00:06     
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                 17 MB/s | 412 MB     00:24     
warning: rpmts_HdrFromFdno: Header V4 RSA/SHA1 Signature, key ID 07513cad: NOKEY
Retrieving key from http://192.168.1.222:7777/ambari-2.2.0.0/centos6/2.2.0.0-1310/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins
Importing GPG key 0x07513CAD:
 Userid: "Jenkins (HDP Builds) <jenkin@hortonworks.com>"
 From  : http://192.168.1.222:7777/ambari-2.2.0.0/centos6/2.2.0.0-1310/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins
Is this ok [y/N]: y
Running rpm_check_debug
Running Transaction Test
Transaction Test Succeeded
Running Transaction
  Installing : postgresql-libs-8.4.20-4.el6_7.x86_64                                                                                                                             1/4 
  Installing : postgresql-8.4.20-4.el6_7.x86_64                                                                                                                                  2/4 
  Installing : postgresql-server-8.4.20-4.el6_7.x86_64                                                                                                                           3/4 
  Installing : ambari-server-2.2.0.0-1310.x86_64                                                                                                                                 4/4 
  Verifying  : postgresql-libs-8.4.20-4.el6_7.x86_64                                                                                                                             1/4 
  Verifying  : postgresql-server-8.4.20-4.el6_7.x86_64                                                                                                                           2/4 
  Verifying  : ambari-server-2.2.0.0-1310.x86_64                                                                                                                                 3/4 
  Verifying  : postgresql-8.4.20-4.el6_7.x86_64                                                                                                                                  4/4 

Installed:
  ambari-server.x86_64 0:2.2.0.0-1310                                                                                                                                                

Dependency Installed:
  postgresql.x86_64 0:8.4.20-4.el6_7                      postgresql-libs.x86_64 0:8.4.20-4.el6_7                      postgresql-server.x86_64 0:8.4.20-4.el6_7                     

Complete!
[root@n01 yum.repos.d]# scp  -r /etc/yum.repos.d/  poon@host:/Users/poon/centos.hdp.kylin.n01/etc/
CentOS-Debuginfo.repo                                                                                                                              100%  638     0.6KB/s   00:00    
CentOS-Media.repo                                                                                                                                  100%  630     0.6KB/s   00:00    
ambari.repo                                                                                                                                        100%  558     0.5KB/s   00:00    
CentOS-Base.repo                                                                                                                                   100% 1926     1.9KB/s   00:00    
CentOS-Vault.repo                                                                                                                                  100% 3664     3.6KB/s   00:00    
[root@n01 yum.repos.d]# 


# ambari-server 服务器配置！

[root@n01 yum.repos.d]#         ambari-server setup
Using python  /usr/bin/python2
Setup ambari-server
Checking SELinux...
SELinux status is 'enabled'
SELinux mode is 'permissive'
WARNING: SELinux is set to 'permissive' mode and temporarily disabled.
OK to continue [y/n] (y)? y
Customize user account for ambari-server daemon [y/n] (n)? 
Adjusting ambari-server permissions and ownership...
Checking firewall status...
Checking JDK...
[1] Oracle JDK 1.8 + Java Cryptography Extension (JCE) Policy Files 8
[2] Oracle JDK 1.7 + Java Cryptography Extension (JCE) Policy Files 7
[3] Custom JDK
==============================================================================
Enter choice (1): 
To download the Oracle JDK and the Java Cryptography Extension (JCE) Policy Files you must accept the license terms found at http://www.oracle.com/technetwork/java/javase/terms/license/index.html and not accepting will cancel the Ambari Server setup and you must install the JDK and JCE files manually.
Do you accept the Oracle Binary Code License Agreement [y/n] (y)? 
Downloading JDK from http://public-repo-1.hortonworks.com/ARTIFACTS/jdk-8u60-linux-x64.tar.gz to /var/lib/ambari-server/resources/jdk-8u60-linux-x64.tar.gz
jdk-8u60-linux-x64.tar.gz... 100% (172.8 MB of 172.8 MB)
Successfully downloaded JDK distribution to /var/lib/ambari-server/resources/jdk-8u60-linux-x64.tar.gz
Installing JDK to /usr/jdk64/
Successfully installed JDK to /usr/jdk64/
Downloading JCE Policy archive from http://public-repo-1.hortonworks.com/ARTIFACTS/jce_policy-8.zip to /var/lib/ambari-server/resources/jce_policy-8.zip

Successfully downloaded JCE Policy archive to /var/lib/ambari-server/resources/jce_policy-8.zip
Installing JCE policy...
Completing setup...
Configuring database...
Enter advanced database configuration [y/n] (n)? 
input not recognized, please try again: 
Enter advanced database configuration [y/n] (n)? n
Configuring database...
Default properties detected. Using built-in database.
Configuring ambari database...
Checking PostgreSQL...
Running initdb: This may take upto a minute.
Initializing database: [  OK  ]

About to start PostgreSQL
Configuring local database...
Connecting to local database...done.
Configuring PostgreSQL...
Restarting PostgreSQL
Extracting system views...
ambari-admin-2.2.0.0.1310.jar
......
Adjusting ambari-server permissions and ownership...
Ambari Server 'setup' completed successfully.
[root@n01 yum.repos.d]# 


# 先安装 perl 

# 再安装mysql

[root@n01 ~]# yum erase  MySQL-server-5.6.25-1.el6.x86_64


[root@n01 ~]# rpm -ivh --force MySQL-server-5.6.25-1.el6.x86_64


service mysql restart

[root@n01 ~]# mysql_install_db --user=mysql
Installing MySQL system tables...2016-01-14 18:54:02 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
2016-01-14 18:54:02 0 [Note] /usr/sbin/mysqld (mysqld 5.6.25) starting as process 7905 ...
2016-01-14 18:54:02 7905 [Note] InnoDB: Using atomics to ref count buffer pool pages
2016-01-14 18:54:02 7905 [Note] InnoDB: The InnoDB memory heap is disabled
2016-01-14 18:54:02 7905 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2016-01-14 18:54:02 7905 [Note] InnoDB: Memory barrier is not used
2016-01-14 18:54:02 7905 [Note] InnoDB: Compressed tables use zlib 1.2.3
2016-01-14 18:54:02 7905 [Note] InnoDB: Using Linux native AIO
2016-01-14 18:54:02 7905 [Note] InnoDB: Using CPU crc32 instructions
2016-01-14 18:54:02 7905 [Note] InnoDB: Initializing buffer pool, size = 128.0M
2016-01-14 18:54:02 7905 [Note] InnoDB: Completed initialization of buffer pool
2016-01-14 18:54:02 7905 [Note] InnoDB: Highest supported file format is Barracuda.
2016-01-14 18:54:02 7905 [Note] InnoDB: 128 rollback segment(s) are active.
2016-01-14 18:54:02 7905 [Note] InnoDB: Waiting for purge to start
2016-01-14 18:54:02 7905 [Note] InnoDB: 5.6.25 started; log sequence number 1626163
2016-01-14 18:54:02 7905 [Note] Binlog end
2016-01-14 18:54:02 7905 [Note] InnoDB: FTS optimize thread exiting.
2016-01-14 18:54:02 7905 [Note] InnoDB: Starting shutdown...
2016-01-14 18:54:04 7905 [Note] InnoDB: Shutdown completed; log sequence number 1626173
OK

Filling help tables...2016-01-14 18:54:04 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
2016-01-14 18:54:04 0 [Note] /usr/sbin/mysqld (mysqld 5.6.25) starting as process 7928 ...
2016-01-14 18:54:04 7928 [Note] InnoDB: Using atomics to ref count buffer pool pages
2016-01-14 18:54:04 7928 [Note] InnoDB: The InnoDB memory heap is disabled
2016-01-14 18:54:04 7928 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2016-01-14 18:54:04 7928 [Note] InnoDB: Memory barrier is not used
2016-01-14 18:54:04 7928 [Note] InnoDB: Compressed tables use zlib 1.2.3
2016-01-14 18:54:04 7928 [Note] InnoDB: Using Linux native AIO
2016-01-14 18:54:04 7928 [Note] InnoDB: Using CPU crc32 instructions
2016-01-14 18:54:04 7928 [Note] InnoDB: Initializing buffer pool, size = 128.0M
2016-01-14 18:54:04 7928 [Note] InnoDB: Completed initialization of buffer pool
2016-01-14 18:54:04 7928 [Note] InnoDB: Highest supported file format is Barracuda.
2016-01-14 18:54:04 7928 [Note] InnoDB: 128 rollback segment(s) are active.
2016-01-14 18:54:04 7928 [Note] InnoDB: Waiting for purge to start
2016-01-14 18:54:04 7928 [Note] InnoDB: 5.6.25 started; log sequence number 1626173
2016-01-14 18:54:04 7928 [Note] Binlog end
2016-01-14 18:54:04 7928 [Note] InnoDB: FTS optimize thread exiting.
2016-01-14 18:54:04 7928 [Note] InnoDB: Starting shutdown...
2016-01-14 18:54:06 7928 [Note] InnoDB: Shutdown completed; log sequence number 1626183
OK

To start mysqld at boot time you have to copy
support-files/mysql.server to the right place for your system

PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !
To do so, start the server, then issue the following commands:

  /usr/bin/mysqladmin -u root password 'new-password'
  /usr/bin/mysqladmin -u root -h n01.kylin.hdp password 'new-password'

Alternatively you can run:

  /usr/bin/mysql_secure_installation

which will also give you the option of removing the test
databases and anonymous user created by default.  This is
strongly recommended for production servers.

See the manual for more instructions.

You can start the MySQL daemon with:

  cd /usr ; /usr/bin/mysqld_safe &

You can test the MySQL daemon with mysql-test-run.pl

  cd mysql-test ; perl mysql-test-run.pl

Please report any problems at http://bugs.mysql.com/

The latest information about MySQL is available on the web at

  http://www.mysql.com

Support MySQL by buying support/licenses at http://shop.mysql.com

WARNING: Found existing config file /usr/my.cnf on the system.
Because this file might be in use, it was not replaced,
but was used in bootstrap (unless you used --defaults-file)
and when you later start the server.
The new default config file was created as /usr/my-new.cnf,
please compare it with your file and take the changes you need.





 760  set password for `root`@`localhost` = password('RootIsDanger');
  set password for `root`@`localhost` = password('root');
不能执行，改用：


 update user set password=PASSWORD('RootIsDanger') where user='root';

mysql> update user set password=PASSWORD('mysql') where user='mysql';



# 使用端口转发

host ssh 访问 guest ： host的ip不用 指明。
host http 访问 guest ： guest 的ip 要指明！


# 复制虚拟机 节点 

1. 该hosts

2. 该 /etc/sysconfig/network 

3. 改 ifcfg-eth0

3. 该 mac !!


# 为何 guest 用一张网卡 ， nat ， guest之间不能互访？ 


解决办法： 加多一张网卡：host－only 


# ambari agent 无法注册 问题 


INFO 2016-01-15 08:41:52,171 PingPortListener.py:50 - Ping port listener started on port: 8670
INFO 2016-01-15 08:41:52,172 main.py:289 - Connecting to Ambari server at https://n01.kylin.hdp:8440 (10.0.2.11)
INFO 2016-01-15 08:41:52,173 NetUtil.py:60 - Connecting to https://n01.kylin.hdp:8440/ca
ERROR 2016-01-15 08:41:52,556 NetUtil.py:84 - [Errno 1] _ssl.c:492: error:100AE081:elliptic curve routines:EC_GROUP_new_by_curve_name:unknown group
ERROR 2016-01-15 08:41:52,556 NetUtil.py:85 - SSLError: Failed to connect. Please check openssl library versions. 
Refer to: https://bugzilla.redhat.com/show_bug.cgi?id=1022468 for more details.
WARNING 2016-01-15 08:41:52,557 NetUtil.py:112 - Server at https://n01.kylin.hdp:8440 is not reachable, sleeping for 10 seconds...
', None)



yum -y upgrade openssl

ambari-agent restart


# THP 
The following hosts have Transparent Huge Pages (THP) enabled. THP should be disabled to avoid potential Hadoop performance issues.



[root@n01 ~]# ll  /sys/kernel/mm/transparent_hugepage/defrag
-rw-r--r-- 1 root root 4096 Jan 15 09:26 /sys/kernel/mm/transparent_hugepage/defrag
[root@n01 ~]# cat  /sys/kernel/mm/transparent_hugepage/defrag
[always] madvise never
[root@n01 ~]# cat /sys/kernel/mm/transparent_hugepage/enabled
[always] madvise never
[root@n01 ~]# cat /sys/kernel/mm/redhat_transparent_hugepage/enabled
[always] madvise never
[root@n01 ~]# cat /sys/kernel/mm/redhat_transparent_hugepage/defrag
[always] madvise never
[root@n01 ~]# echo never > /sys/kernel/mm/redhat_transparent_hugepage/defrag
[root@n01 ~]# echo never > /sys/kernel/mm/redhat_transparent_hugepage/enabled
[root@n01 ~]# echo never > /sys/kernel/mm/transparent_hugepage/enabled
[root@n01 ~]# echo never > /sys/kernel/mm/transparent_hugepage/defrag
[root@n01 ~]# 

echo never > /sys/kernel/mm/redhat_transparent_hugepage/defrag
echo never > /sys/kernel/mm/redhat_transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag



# 在这个目录下，可以查看到从repo下载的安装包和 repo同步的信息。 无论是在线还是离线的repo . 
/var/cache/yum/x86_64/6
 


  /var/lib/ambari-agent/data/output-66.txt




resource_management.core.exceptions.Fail: Execution of '/usr/bin/yum -d 0 -e 0 -y install mysql-server' returned 1. Error: mysql-server conflicts with MySQL-server-5.6.25-1.el6.x86_64
 You could try using --skip-broken to work around the problem
  You could try running: rpm -Va --nofiles --nodigest



本来打算 先把mysql 装好， 结果 报冲突了！！

ambari 用的是这个版本！！


[root@n02 cache]# find /var/cache -iname "*mysql*"|xargs ls -l
-rw-r--r-- 1 root root  915640 Jun 22  2015 /var/cache/yum/x86_64/6/base/packages/mysql-5.1.73-5.el6_6.x86_64.rpm
-rw-r--r-- 1 root root 1283296 Jun 22  2015 /var/cache/yum/x86_64/6/base/packages/mysql-libs-5.1.73-5.el6_6.x86_64.rpm
-rw-r--r-- 1 root root 9033908 Jun 22  2015 /var/cache/yum/x86_64/6/base/packages/mysql-server-5.1.73-5.el6_6.x86_64.rpm
-rw-r--r-- 1 root root  137008 Jul  3  2011 /var/cache/yum/x86_64/6/base/packages/perl-DBD-MySQL-4.013-3.el6.x86_64.rpm
-rw-r--r-- 1 root root  937748 Dec  5 05:42 /var/cache/yum/x86_64/6/local-HDP-UTILS-1.1.0.20/packages/mysql-connector-java-5.1.37-1.noarch.rpm
[root@n02 cache]# 

# InnoDB: Error: log file ./ib_logfile0 is of different size 5242880 bytes

https://www.percona.com/forums/questions-discussions/percona-xtrabackup/17446-got-ib_logfile0-is-of-different-size-when-doing-stream-backup


# 

Fatal error: Can't open and lock privilege tables: Table 'mysql.host' doesn't exist

http://stackoverflow.com/questions/9083408/fatal-error-cant-open-and-lock-privilege-tables-table-mysql-host-doesnt-ex

第一个答案！

# mysql hive 用户登录：

mysql hive@% 并不能 在服务器上登录， 需要 增加一条 hive@localhost 才能登录：
CREATE USER 'hive'@'localhost' IDENTIFIED BY 'hive123';


起停方式：
service mysqld stop 
service mysqld start

而非：

service mysql stop/start





Traceback (most recent call last):
  File "/var/lib/ambari-agent/cache/custom_actions/scripts/check_host.py", line 477, in <module>
      CheckHost().execute()
        File "/usr/lib/python2.6/site-packages/resource_management/libraries/script/script.py", line 219, in execute
            method(env)
              File "/var/lib/ambari-agent/cache/custom_actions/scripts/check_host.py", line 212, in actionexecute
                  raise Fail(error_message)
                  resource_management.core.exceptions.Fail: Check db_connection_check was unsuccessful. Exit code: 1. Message: Error: Ambari Server cannot download the database JDBC driver and is unable to test the database connection. You must run ambari-server setup --jdbc-db=mysql --jdbc-driver=/path/to/your/mysql/driver.jar on the Ambari Server host to make the JDBC driver available for download and to enable testing the database connection.
                  HTTP Error 404: Not Found

通过再创建如下 用户权限条目： 解决 access denied 的问题：

CREATE USER 'hive'@'n02.kylin.hdp' IDENTIFIED BY 'hive123';


wget -b "http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.2.0.0/ambari-2.2.0.0-centos6.tar.gz" -o ambari2200centos6.log -O Dambari-2.2.0.0-centos6.tar.gz

wget -b "http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.3.4.0/HDP-2.3.4.0-centos6-rpm.tar.gz" -o hdp2340centos6.log -O HDP-2.3.4.0-centos6-rpm.tar.gz

wget -b "http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/centos6/HDP-UTILS-1.1.0.20-centos6.tar.gz" -o hdp2340centos6.log -O HDP-UTILS-1.1.0.20-centos6.tar.gz



# hive 不能用 root 执行！
用 hive !


# REPO 问题！

2016-01-15 15:48:17,051 - Repository['HDP-UTILS-1.1.0.20'] {'base_url': 'http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/centos6', 'action': ['create'], 'components': ['HDP-UTILS', 'main'], 'repo_template': '[{{repo_id}}]\nname={{repo_id}}\n{% if mirror_list %}mirrorlist={{mirror_list}}{% else %}baseurl={{base_url}}{% endif %}\n\npath=/\nenabled=1\ngpgcheck=0', 'repo_file_name': 'HDP-UTILS', 'mirror_list': None}
2016-01-15 15:48:17,095 - File['/etc/yum.repos.d/HDP-UTILS.repo'] {'content': '[HDP-UTILS-1.1.0.20]\nname=HDP-UTILS-1.1.0.20\nbaseurl=http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/centos6\n\npath=/\nenabled=1\ngpgcheck=0'}
2016-01-15 15:48:17,102 - Package['unzip'] {}
2016-01-15 15:48:19,386 - Skipping installation of existing package unzip
2016-01-15 15:48:19,414 - Package['curl'] {}
2016-01-15 15:48:19,619 - Skipping installation of existing package curl
2016-01-15 15:48:19,632 - Package['hdp-select'] {}
2016-01-15 15:48:19,834 - Skipping installation of existing package hdp-select
2016-01-15 15:48:22,515 - Package['ambari-metrics-monitor'] {}
2016-01-15 15:48:25,354 - Installing package ambari-metrics-monitor ('/usr/bin/yum -d 0 -e 0 -y install ambari-metrics-monitor')



# HDP-UTILS 

2016-01-15 16:17:01,577 - File['/etc/yum.repos.d/HDP-UTILS.repo'] {'content': '[HDP-UTILS-1.1.0.20]\nname=HDP-UTILS-1.1.0.20\nbaseurl=http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/centos6\n\npath=/\nenabled=1\ngpgcheck=0'}
2016-01-15 16:17:01,577 - Writing File['/etc/yum.repos.d/HDP-UTILS.repo'] because contents don't match
2016-01-15 16:17:01,577 - Package['unzip'] {}
2016-01-15 16:17:01,916 - Skipping installation of existing package unzip
2016-01-15 16:17:01,918 - Package['curl'] {}
2016-01-15 16:17:01,961 - Skipping installation of existing package curl
2016-01-15 16:17:01,965 - Package['hdp-select'] {}
2016-01-15 16:17:02,169 - Skipping installation of existing package hdp-select
2016-01-15 16:17:02,756 - Package['ambari-metrics-collector'] {}
2016-01-15 16:17:02,916 - Installing package ambari-metrics-collector ('/usr/bin/yum -d 0 -e 0 -y install ambari-metrics-collector')


# 通过杀python 进程 来中断 安装

Python script has been killed due to timeout after waiting 1800 secs


root      1195  1191  0 16:17 ?        00:00:00 /bin/bash /var/lib/ambari-agent/ambari-sudo.sh PATH=/usr/sbin:/sbin:/usr/lib/ambari-server/*:/usr/sbin:/sbin:/usr/lib/ambari-server/*:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/var/lib/ambari-agent:/var/lib/ambari-agent -H -E /usr/bin/yum -d 0 -e 0 -y install ambari-metrics-collector
root      1196  1195  0 16:17 ?        00:00:01 /usr/bin/python /usr/bin/yum -d 0 -e 0 -y install ambari-metrics-collector




#  POC 

POC测试，即Proof of Concept，是业界流行的针对客户具体应用的验证性测试，根据用户对采用系统提出的性能要求和扩展需求的指标，在选用服务器上进行真实数据的运行，对承载用户数据量和运行时间进行实际测算，并根据用户未来业务扩展的需求加大数据量以验证系统和平台的承载能力和性能变化。
特别是在应用系统选型阶段，一些大型企业的业务流程比较复杂，并非单一的功能性演示就能覆盖现实的业务需求，这时候需要事先划定一个小范围的实验对象（但是业务逻辑的复杂性要有典型性，有代表性），通过小范围的项目导入与实施，从真实业务的实践到战略意图的实现，来验证系统方案是否能满足用户的需求，从而作出更客观更准确的判断。


# 修改 ambari stack 之后，选用了本地repo ! 


菜单： admin - stack and versions - edit button 

stdout:   /var/lib/ambari-agent/data/output-152.txt

2016-01-15 23:19:45,054 - Repository['HDP-UTILS-1.1.0.20'] {'base_url': 'http://192.168.1.222:7777/HDP-UTILS-1.1.0.20/repos/centos6', 'action': ['create'], 'components': ['HDP-UTILS', 'main'], 'repo_template': '[{{repo_id}}]\nname={{repo_id}}\n{% if mirror_list %}mirrorlist={{mirror_list}}{% else %}baseurl={{base_url}}{% endif %}\n\npath=/\nenabled=1\ngpgcheck=0', 'repo_file_name': 'HDP-UTILS', 'mirror_list': None}
2016-01-15 23:19:45,061 - File['/etc/yum.repos.d/HDP-UTILS.repo'] {'content': '[HDP-UTILS-1.1.0.20]\nname=HDP-UTILS-1.1.0.20\nbaseurl=http://192.168.1.222:7777/HDP-UTILS-1.1.0.20/repos/centos6\n\npath=/\nenabled=1\ngpgcheck=0'}
2016-01-15 23:19:45,061 - Package['unzip'] {}
2016-01-15 23:19:45,180 - Skipping installation of existing package unzip
2016-01-15 23:19:45,181 - Package['curl'] {}
2016-01-15 23:19:45,193 - Skipping installation of existing package curl
2016-01-15 23:19:45,193 - Package['hdp-select'] {}
2016-01-15 23:19:45,206 - Skipping installation of existing package hdp-select
2016-01-15 23:19:45,388 - Package['ambari-metrics-collector'] {}
2016-01-15 23:19:45,458 - Installing package ambari-metrics-collector ('/usr/bin/yum -d 0 -e 0 -y install ambari-metrics-collector')

# ambari metrics 一直没法更新 , 解决办法

1. 先重新 choose stack

2. 重启ambari sever/agent 

3. 将安装失败的 ambari collector 切换到维护模式

4. 把 ambari collector move到其他节点


#  stderr 

stderr:   /var/lib/ambari-agent/data/errors-257.txt

On host n01.kylin.hdp role METRICS_MONITOR in invalid state.
Invalid transition. Invalid event: HOST_SVCCOMP_OP_IN_PROGRESS at INSTALL_FAILED

On host n01.kylin.hdp role METRICS_COLLECTOR in invalid state.
Invalid transition. Invalid event: HOST_SVCCOMP_OP_IN_PROGRESS at INIT



I got this issue with ambari 2.1.0 where HCAT was stuck in INSTALL_FAILED despite being installed and a restart of ambari-agent didn't work for me.
I did the following fix via the database so if anyone else needs a workaround until the code can handle it, this is what I did (mysql):
use ambari;
select host_id from hosts where host_name='HOSTNAME';
this gives me the host_id I need e.g. HOSTID
update hostcomponentstate set current_state='INSTALLED' where current_state='INSTALL_FAILED' and host_id=HOSTID;
Afterwards I did an 'install clients' from the UI and 'refresh configs' to try to make sure the install state was reflected.




# kylin 环境安装

## HCAT_HOME not found, try to find hcatalog path from hadoop home


## WARNING: Use "yarn jar" to launch YARN applications.



## /usr/share/java/ojdbc6.jar 是啥 

java.io.FileNotFoundException: /usr/hdp/2.3.4.0-3485/hbase/lib/ojdbc6.jar (No such file or directory)

jdbc for oracle 


解决：到官方网站下载，拷贝到相应目录，让  soft link  可以引用到。

-rw-r--r-- 1 root root 3692096 Jan 16 10:20 /usr/share/java/ojdbc6.jar



## SEVERE: contextConfig.jarFile
java.io.FileNotFoundException: /opt/apache-kylin-1.2-bin/bin/mysql-connector-java.jar (No such file or directory)
        at java.util.zip.ZipFile.open(Native Method)
        at java.util.zip.ZipFile.<init>(ZipFile.java:219)
        at java.util.zip.ZipFile.<init>(ZipFile.java:149)
        at java.util.jar.JarFile.<init>(JarFile.java:166)
        at java.util.jar.JarFile.<init>(JarFile.java:103)
 

解决：

https://ambari.apache.org/1.2.5/installing-hadoop-using-ambari/content/ambari-chaplast-2.html

# kylin 

对环境设置的描述不够详细。

##  Constructor threw exception; nested exception is java.lang.NoSuchMethodError: org.apache.hadoop.hbase.client.HBaseAdmin.<init>(Lorg/apa
che/hadoop/hbase/client/HConnection;)V

原因 ： hbase 版本问题！ 

解决： 使用 snapshot 版本 ！ 
drwxr-xr-x 8 hive hadoop     4096 Jan 16 12:10 apache-kylin-1.2-bin
drwxr-xr-x 8 hive hadoop     4096 Jan 16 12:16 apache-kylin-1.3-HBase-1.1-SNAPSHOT-bin


https://issues.apache.org/jira/browse/KYLIN-892


http://stackoverflow.com/questions/24670017/hbase-not-running-in-pseudo-distributed-mode


# sample.sh


[hive@n01 bin]$ ./sample.sh 
KYLIN_HOME is set to /opt/apache-kylin-1.3-HBase-1.1-SNAPSHOT-bin
Going to create sample tables in hive...
WARNING: Use "yarn jar" to launch YARN applications.

Logging initialized using configuration in file:/etc/hive/2.3.4.0-3485/0/hive-log4j.properties
OK
Time taken: 2.474 seconds
OK
Time taken: 1.941 seconds
OK
Time taken: 0.055 seconds
OK
Time taken: 0.381 seconds
OK
Time taken: 0.046 seconds
OK
Time taken: 0.505 seconds
Loading data to table default.kylin_sales
Table default.kylin_sales stats: [numFiles=1, totalSize=504788]
OK
Time taken: 1.935 seconds
Loading data to table default.kylin_cal_dt
Table default.kylin_cal_dt stats: [numFiles=1, totalSize=512997]
OK
Time taken: 1.491 seconds
Loading data to table default.kylin_category_groupings
Table default.kylin_category_groupings stats: [numFiles=1, totalSize=49634]
OK
Time taken: 1.573 seconds
Sample hive tables are created successfully; Going to create sample cube...
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/hdp/2.3.4.0-3485/hadoop/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/hdp/2.3.4.0-3485/zookeeper/lib/slf4j-log4j12-1.6.1.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
2016-01-16 12:27:49,540 INFO  [main] common.KylinConfig: The URI /opt/apache-kylin-1.3-HBase-1.1-SNAPSHOT-bin/sample_cube/metadata is recognized as LOCAL_FOLDER
2016-01-16 12:27:49,627 WARN  [main] common.KylinConfig: KYLIN_CONF property was not set, will seek KYLIN_HOME env variable
2016-01-16 12:27:49,696 INFO  [main] persistence.ResourceStore: Using metadata url /opt/apache-kylin-1.3-HBase-1.1-SNAPSHOT-bin/sample_cube/metadata for resource store
2016-01-16 12:27:49,697 INFO  [main] persistence.ResourceStore: Using metadata url kylin_metadata@hbase for resource store
2016-01-16 12:27:51,797 INFO  [main] zookeeper.RecoverableZooKeeper: Process identifier=hconnection-0x59096b66 connecting to ZooKeeper ensemble=n02.kylin.hdp:2181,n03.kylin.hdp:2181,n01.kylin.hdp:2181
2016-01-16 12:27:51,814 INFO  [main] zookeeper.ZooKeeper: Client environment:zookeeper.version=3.4.6-3485--1, built on 12/16/2015 02:35 GMT
2016-01-16 12:27:51,814 INFO  [main] zookeeper.ZooKeeper: Client environment:host.name=n01.kylin.hdp
2016-01-16 12:27:51,814 INFO  [main] zookeeper.ZooKeeper: Client environment:java.version=1.8.0_60
2016-01-16 12:27:51,814 INFO  [main] zookeeper.ZooKeeper: Client environment:java.vendor=Oracle Corporation
2016-01-16 12:27:51,814 INFO  [main] zookeeper.ZooKeeper: Client environment:java.home=/usr/jdk64/jdk1.8.0_60/jre
2016-01-16 12:27:51,814 INFO  [main] zookeeper.ZooKeeper: Client environment:java.class.path=/usr/hdp/2.3.4.0-3485/hbase/conf:/usr/jdk64/jdk1.8.0_60/lib/tools.jar:/usr/hdp/2.3.4.0-3485/hbase:/usr/hdp/2.3.4.0-3485/hbase/lib/activation-1.1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/aopalliance-1.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/apacheds-i18n-2.0.0-M15.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/apacheds-kerberos-codec-2.0.0-M15.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/api-asn1-api-1.0.0-M20.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/api-util-1.0.0-M20.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/asm-3.1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/avro-1.7.4.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-beanutils-1.7.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-beanutils-core-1.8.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-cli-1.2.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-codec-1.9.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-collections-3.2.2.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-compress-1.4.1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-configuration-1.6.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-daemon-1.0.13.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-digester-1.8.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-el-1.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-httpclient-3.1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-io-2.4.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-lang-2.6.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-logging-1.2.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-math-2.2.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-math3-3.1.1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/commons-net-3.1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/curator-client-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/curator-framework-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/curator-recipes-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/disruptor-3.3.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/findbugs-annotations-1.3.9-1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/gson-2.2.4.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/guava-12.0.1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/guice-3.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/guice-servlet-3.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-annotations-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-annotations-1.1.2.2.3.4.0-3485-tests.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-annotations.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-client-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-client.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-common-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-common-1.1.2.2.3.4.0-3485-tests.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-common.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-examples-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-examples.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-hadoop2-compat-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-hadoop2-compat.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-hadoop-compat-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-hadoop-compat.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-it-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-it-1.1.2.2.3.4.0-3485-tests.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-it.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-prefix-tree-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-prefix-tree.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-procedure-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-procedure.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-protocol-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-protocol.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-resource-bundle-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-resource-bundle.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-rest-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-rest.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-server-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-server-1.1.2.2.3.4.0-3485-tests.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-server.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-shell-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-shell.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-thrift-1.1.2.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/hbase-thrift.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/htrace-core-3.1.0-incubating.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/httpclient-4.2.5.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/httpcore-4.2.5.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jackson-core-2.2.3.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jackson-core-asl-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jackson-jaxrs-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jackson-mapper-asl-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jackson-xc-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jamon-runtime-2.3.1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jasper-compiler-5.5.23.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jasper-runtime-5.5.23.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/javax.inject-1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/java-xmlbuilder-0.4.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jaxb-api-2.2.2.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jaxb-impl-2.2.3-1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jcodings-1.0.8.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jersey-client-1.9.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jersey-core-1.9.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jersey-guice-1.9.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jersey-json-1.9.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jersey-server-1.9.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jets3t-0.9.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jettison-1.3.3.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jetty-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jetty-sslengine-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jetty-util-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/joni-2.1.2.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jruby-complete-1.6.8.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jsch-0.1.42.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jsp-2.1-6.1.14.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jsp-api-2.1-6.1.14.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/jsr305-1.3.9.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/junit-4.11.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/leveldbjni-all-1.8.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/libthrift-0.9.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/log4j-1.2.17.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/metrics-core-2.2.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/microsoft-windowsazure-storage-sdk-0.6.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/netty-3.2.4.Final.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/netty-all-4.0.23.Final.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/ojdbc6.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/okhttp-2.4.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/okio-1.4.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/paranamer-2.3.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/protobuf-java-2.5.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/ranger-hbase-plugin-shim-0.5.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/ranger-plugin-classloader-0.5.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/servlet-api-2.5-6.1.14.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/servlet-api-2.5.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/slf4j-api-1.7.7.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/snappy-java-1.0.4.1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/spymemcached-2.11.6.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/xercesImpl-2.9.1.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/xml-apis-1.3.04.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/xmlenc-0.52.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/xz-1.0.jar:/usr/hdp/2.3.4.0-3485/hbase/lib/zookeeper.jar:/usr/hdp/2.3.4.0-3485/hadoop/conf:/usr/hdp/2.3.4.0-3485/hadoop/lib/httpclient-4.2.5.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/ranger-plugin-classloader-0.5.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/mockito-all-1.8.5.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-compress-1.4.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/gson-2.2.4.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/snappy-java-1.0.4.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jsr305-3.0.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/api-util-1.0.0-M20.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jackson-jaxrs-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jsp-api-2.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/microsoft-windowsazure-storage-sdk-0.6.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/guava-11.0.2.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/xmlenc-0.52.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-io-2.4.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/paranamer-2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/htrace-core-3.1.0-incubating.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-configuration-1.6.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jackson-annotations-2.2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/aws-java-sdk-1.7.4.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jsch-0.1.42.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jersey-json-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/curator-framework-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/xz-1.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/junit-4.11.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/servlet-api-2.5.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jackson-core-asl-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/ojdbc6.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-digester-1.8.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/apacheds-kerberos-codec-2.0.0-M15.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-beanutils-1.7.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jetty-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/api-asn1-api-1.0.0-M20.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/activation-1.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jersey-core-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/stax-api-1.0-2.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-beanutils-core-1.8.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-math3-3.1.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jackson-core-2.2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jets3t-0.9.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jersey-server-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/protobuf-java-2.5.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/azure-storage-2.2.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-net-3.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/asm-3.2.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/curator-client-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/avro-1.7.4.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-codec-1.4.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/java-xmlbuilder-0.4.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/ranger-hdfs-plugin-shim-0.5.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jetty-util-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/netty-3.6.2.Final.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/curator-recipes-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-cli-1.2.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jackson-mapper-asl-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/httpcore-4.2.5.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jaxb-impl-2.2.3-1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jaxb-api-2.2.2.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/zookeeper-3.4.6.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/log4j-1.2.17.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/apacheds-i18n-2.0.0-M15.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jackson-xc-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/ranger-yarn-plugin-shim-0.5.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-lang-2.6.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jackson-databind-2.2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jettison-1.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/slf4j-log4j12-1.7.10.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-httpclient-3.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-collections-3.2.2.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/slf4j-api-1.7.10.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-logging-1.1.3.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/hamcrest-core-1.3.jar:/usr/hdp/2.3.4.0-3485/hadoop/.//hadoop-annotations.jar:/usr/hdp/2.3.4.0-3485/hadoop/.//hadoop-common-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/.//hadoop-auth.jar:/usr/hdp/2.3.4.0-3485/hadoop/.//hadoop-nfs-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/.//hadoop-nfs.jar:/usr/hdp/2.3.4.0-3485/hadoop/.//hadoop-azure-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/.//hadoop-azure.jar:/usr/hdp/2.3.4.0-3485/hadoop/.//hadoop-auth-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/.//hadoop-aws.jar:/usr/hdp/2.3.4.0-3485/hadoop/.//hadoop-common-2.7.1.2.3.4.0-3485-tests.jar:/usr/hdp/2.3.4.0-3485/hadoop/.//hadoop-annotations-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/.//hadoop-aws-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/.//hadoop-common.jar:/usr/hdp/2.3.4.0-3485/hadoop/.//hadoop-common-tests.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/./:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/okhttp-2.4.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/jsr305-3.0.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/guava-11.0.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/xmlenc-0.52.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/xercesImpl-2.9.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/commons-io-2.4.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/htrace-core-3.1.0-incubating.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/servlet-api-2.5.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/jackson-core-asl-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/netty-all-4.0.23.Final.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/jetty-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/okio-1.4.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/jersey-core-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/jersey-server-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/protobuf-java-2.5.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/asm-3.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/commons-codec-1.4.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/xml-apis-1.3.04.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/leveldbjni-all-1.8.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/jetty-util-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/netty-3.6.2.Final.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/commons-cli-1.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/jackson-mapper-asl-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/log4j-1.2.17.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/commons-lang-2.6.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/commons-daemon-1.0.13.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/lib/commons-logging-1.1.3.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/.//hadoop-hdfs-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/.//hadoop-hdfs-nfs-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/.//hadoop-hdfs-2.7.1.2.3.4.0-3485-tests.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/.//hadoop-hdfs-nfs.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/.//hadoop-hdfs.jar:/usr/hdp/2.3.4.0-3485/hadoop-hdfs/.//hadoop-hdfs-tests.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/httpclient-4.2.5.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/zookeeper-3.4.6.2.3.4.0-3485-tests.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/aopalliance-1.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/commons-compress-1.4.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/gson-2.2.4.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/snappy-java-1.0.4.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/javassist-3.18.1-GA.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jsr305-3.0.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/api-util-1.0.0-M20.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jackson-jaxrs-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jsp-api-2.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/microsoft-windowsazure-storage-sdk-0.6.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/guava-11.0.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/xmlenc-0.52.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/commons-io-2.4.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/paranamer-2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/htrace-core-3.1.0-incubating.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/commons-configuration-1.6.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/guice-3.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jackson-annotations-2.2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jsch-0.1.42.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jersey-json-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/curator-framework-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/xz-1.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/guice-servlet-3.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/servlet-api-2.5.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jackson-core-asl-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/commons-digester-1.8.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/apacheds-kerberos-codec-2.0.0-M15.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/commons-beanutils-1.7.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jetty-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/api-asn1-api-1.0.0-M20.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/activation-1.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jersey-core-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/stax-api-1.0-2.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/commons-beanutils-core-1.8.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/commons-math3-3.1.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jackson-core-2.2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jets3t-0.9.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jersey-server-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/protobuf-java-2.5.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jersey-client-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/commons-net-3.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/asm-3.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/curator-client-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/avro-1.7.4.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/commons-codec-1.4.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/leveldbjni-all-1.8.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/javax.inject-1.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/java-xmlbuilder-0.4.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jetty-util-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/netty-3.6.2.Final.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/curator-recipes-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/commons-cli-1.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jackson-mapper-asl-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/httpcore-4.2.5.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/fst-2.24.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jaxb-impl-2.2.3-1.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jaxb-api-2.2.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/zookeeper-3.4.6.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jersey-guice-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/log4j-1.2.17.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/apacheds-i18n-2.0.0-M15.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jackson-xc-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/objenesis-2.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/commons-lang-2.6.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jackson-databind-2.2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/jettison-1.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/commons-httpclient-3.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/commons-collections-3.2.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/lib/commons-logging-1.1.3.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-web-proxy-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-applications-unmanaged-am-launcher-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-timeline-plugins.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-resourcemanager-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-web-proxy.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-applications-unmanaged-am-launcher.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-timeline-plugins-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-common-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-applications-distributedshell.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-client-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-common-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-api-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-nodemanager-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-sharedcachemanager-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-applicationhistoryservice-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-tests-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-nodemanager.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-registry.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-common.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-applicationhistoryservice.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-sharedcachemanager.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-registry-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-api.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-tests.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-client.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-common.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-applications-distributedshell-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-yarn/.//hadoop-yarn-server-resourcemanager.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/aopalliance-1.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/commons-compress-1.4.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/snappy-java-1.0.4.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/commons-io-2.4.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/paranamer-2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/guice-3.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/xz-1.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/junit-4.11.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/guice-servlet-3.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/jackson-core-asl-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/jersey-core-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/jersey-server-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/protobuf-java-2.5.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/asm-3.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/avro-1.7.4.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/leveldbjni-all-1.8.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/javax.inject-1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/netty-3.6.2.Final.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/jackson-mapper-asl-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/jersey-guice-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/log4j-1.2.17.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/lib/hamcrest-core-1.3.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//httpclient-4.2.5.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//mockito-all-1.8.5.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-auth.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-rumen-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-compress-1.4.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//gson-2.2.4.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-lang3-3.3.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//snappy-java-1.0.4.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jsr305-3.0.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-sls-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-extras-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//api-util-1.0.0-M20.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jackson-jaxrs-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jsp-api-2.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-openstack-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-jobclient-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//microsoft-windowsazure-storage-sdk-0.6.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//guava-11.0.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//xmlenc-0.52.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//joda-time-2.9.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-hs-plugins-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-hs-plugins.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-io-2.4.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//metrics-core-3.0.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//paranamer-2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-examples.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//htrace-core-3.1.0-incubating.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-configuration-1.6.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-extras.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jsch-0.1.42.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jersey-json-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//curator-framework-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//xz-1.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//junit-4.11.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-auth-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-jobclient.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-datajoin-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-ant.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//servlet-api-2.5.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-archives.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jackson-core-asl-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-distcp.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-digester-1.8.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//apacheds-kerberos-codec-2.0.0-M15.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-beanutils-1.7.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jetty-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//api-asn1-api-1.0.0-M20.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//activation-1.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jersey-core-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-distcp-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//stax-api-1.0-2.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-beanutils-core-1.8.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-math3-3.1.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-gridmix.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-examples-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-common.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jackson-core-2.2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-datajoin.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jets3t-0.9.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jersey-server-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//protobuf-java-2.5.0.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-core.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-hs-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-ant-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-streaming-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-net-3.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//asm-3.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//curator-client-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//avro-1.7.4.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-codec-1.4.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-shuffle-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-openstack.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//java-xmlbuilder-0.4.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-jobclient-2.7.1.2.3.4.0-3485-tests.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-core-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-sls.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jetty-util-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//netty-3.6.2.Final.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-gridmix-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-jobclient-tests.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//curator-recipes-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-cli-1.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-archives-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-hs.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-common-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jackson-mapper-asl-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-streaming.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//httpcore-4.2.5.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-shuffle.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jaxb-impl-2.2.3-1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jaxb-api-2.2.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//zookeeper-3.4.6.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//log4j-1.2.17.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//apacheds-i18n-2.0.0-M15.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-app.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jackson-xc-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-mapreduce-client-app-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-lang-2.6.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//jettison-1.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-httpclient-3.1.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-collections-3.2.2.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hadoop-rumen.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//commons-logging-1.1.3.jar:/usr/hdp/2.3.4.0-3485/hadoop-mapreduce/.//hamcrest-core-1.3.jar::jdbc-mysql.jar:mysql-connector-java-5.1.37.jar:mysql-connector-java.jar:ojdbc6.jar:/usr/hdp/2.3.4.0-3485/tez/tez-yarn-timeline-cache-plugin-0.7.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/tez-runtime-internals-0.7.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/tez-yarn-timeline-history-with-acls-0.7.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/tez-yarn-timeline-history-0.7.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/tez-examples-0.7.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/tez-runtime-library-0.7.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/tez-yarn-timeline-history-with-fs-0.7.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/tez-dag-0.7.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/tez-common-0.7.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/tez-tests-0.7.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/tez-api-0.7.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/tez-history-parser-0.7.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/tez-mapreduce-0.7.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/lib/hadoop-yarn-server-web-proxy-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/lib/hadoop-azure-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/lib/guava-11.0.2.jar:/usr/hdp/2.3.4.0-3485/tez/lib/commons-io-2.4.jar:/usr/hdp/2.3.4.0-3485/tez/lib/jersey-json-1.9.jar:/usr/hdp/2.3.4.0-3485/tez/lib/hadoop-yarn-server-timeline-plugins-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/lib/servlet-api-2.5.jar:/usr/hdp/2.3.4.0-3485/tez/lib/jetty-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/tez/lib/jettison-1.3.4.jar:/usr/hdp/2.3.4.0-3485/tez/lib/commons-math3-3.1.1.jar:/usr/hdp/2.3.4.0-3485/tez/lib/protobuf-java-2.5.0.jar:/usr/hdp/2.3.4.0-3485/tez/lib/jersey-client-1.9.jar:/usr/hdp/2.3.4.0-3485/tez/lib/hadoop-annotations-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/lib/commons-codec-1.4.jar:/usr/hdp/2.3.4.0-3485/tez/lib/commons-collections4-4.1.jar:/usr/hdp/2.3.4.0-3485/tez/lib/hadoop-aws-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/lib/hadoop-mapreduce-client-core-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/lib/jetty-util-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/tez/lib/commons-cli-1.2.jar:/usr/hdp/2.3.4.0-3485/tez/lib/hadoop-mapreduce-client-common-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/tez/lib/jsr305-2.0.3.jar:/usr/hdp/2.3.4.0-3485/tez/lib/commons-lang-2.6.jar:/usr/hdp/2.3.4.0-3485/tez/lib/commons-collections-3.2.2.jar:/usr/hdp/2.3.4.0-3485/tez/lib/slf4j-api-1.7.5.jar:/usr/hdp/2.3.4.0-3485/tez/conf:/usr/hdp/2.3.4.0-3485/hadoop/conf:/usr/hdp/2.3.4.0-3485/hadoop/hadoop-annotations.jar:/usr/hdp/2.3.4.0-3485/hadoop/hadoop-common-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/hadoop-auth.jar:/usr/hdp/2.3.4.0-3485/hadoop/hadoop-nfs-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/hadoop-nfs.jar:/usr/hdp/2.3.4.0-3485/hadoop/hadoop-azure-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/hadoop-azure.jar:/usr/hdp/2.3.4.0-3485/hadoop/hadoop-auth-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/hadoop-aws.jar:/usr/hdp/2.3.4.0-3485/hadoop/hadoop-common-2.7.1.2.3.4.0-3485-tests.jar:/usr/hdp/2.3.4.0-3485/hadoop/hadoop-annotations-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/hadoop-aws-2.7.1.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/hadoop-common.jar:/usr/hdp/2.3.4.0-3485/hadoop/hadoop-common-tests.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/httpclient-4.2.5.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/ranger-plugin-classloader-0.5.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/mockito-all-1.8.5.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-compress-1.4.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/gson-2.2.4.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/snappy-java-1.0.4.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jsr305-3.0.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/api-util-1.0.0-M20.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jackson-jaxrs-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jsp-api-2.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/microsoft-windowsazure-storage-sdk-0.6.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/guava-11.0.2.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/xmlenc-0.52.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-io-2.4.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/paranamer-2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/htrace-core-3.1.0-incubating.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-configuration-1.6.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jackson-annotations-2.2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/aws-java-sdk-1.7.4.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jsch-0.1.42.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jersey-json-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/curator-framework-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/xz-1.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/junit-4.11.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/servlet-api-2.5.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jackson-core-asl-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/ojdbc6.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-digester-1.8.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/apacheds-kerberos-codec-2.0.0-M15.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-beanutils-1.7.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jetty-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/api-asn1-api-1.0.0-M20.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/activation-1.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jersey-core-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/stax-api-1.0-2.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-beanutils-core-1.8.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-math3-3.1.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jackson-core-2.2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jets3t-0.9.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jersey-server-1.9.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/protobuf-java-2.5.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/azure-storage-2.2.0.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-net-3.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/asm-3.2.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/curator-client-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/avro-1.7.4.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-codec-1.4.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/java-xmlbuilder-0.4.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/ranger-hdfs-plugin-shim-0.5.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jetty-util-6.1.26.hwx.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/netty-3.6.2.Final.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/curator-recipes-2.7.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-cli-1.2.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jackson-mapper-asl-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/httpcore-4.2.5.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jaxb-impl-2.2.3-1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jaxb-api-2.2.2.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/zookeeper-3.4.6.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/log4j-1.2.17.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/apacheds-i18n-2.0.0-M15.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jackson-xc-1.9.13.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/ranger-yarn-plugin-shim-0.5.0.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-lang-2.6.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jackson-databind-2.2.3.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/jettison-1.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/slf4j-log4j12-1.7.10.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-httpclient-3.1.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-collections-3.2.2.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/slf4j-api-1.7.10.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/commons-logging-1.1.3.jar:/usr/hdp/2.3.4.0-3485/hadoop/lib/hamcrest-core-1.3.jar:/usr/hdp/2.3.4.0-3485/zookeeper/zookeeper.jar:/usr/hdp/2.3.4.0-3485/zookeeper/zookeeper-3.4.6.2.3.4.0-3485.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/xercesMinimal-1.9.6.2.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/wagon-provider-api-2.4.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/classworlds-1.1-alpha-2.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/ant-1.8.0.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/maven-profile-2.2.1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/maven-error-diagnostics-2.2.1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/ant-launcher-1.8.0.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/jline-0.9.94.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/commons-logging-1.1.1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/plexus-utils-3.0.8.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/maven-artifact-2.2.1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/plexus-container-default-1.0-alpha-9-stable-1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/maven-ant-tasks-2.1.3.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/maven-artifact-manager-2.2.1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/maven-repository-metadata-2.2.1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/backport-util-concurrent-3.1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/netty-3.7.0.Final.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/slf4j-log4j12-1.6.1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/commons-io-2.2.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/plexus-interpolation-1.11.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/wagon-http-shared-1.0-beta-6.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/slf4j-api-1.6.1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/maven-plugin-registry-2.2.1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/jsoup-1.7.1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/wagon-file-1.0-beta-6.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/httpcore-4.2.3.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/commons-codec-1.6.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/maven-project-2.2.1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/nekohtml-1.9.6.2.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/wagon-http-2.4.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/wagon-http-lightweight-1.0-beta-6.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/maven-model-2.2.1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/wagon-http-shared4-2.4.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/log4j-1.2.16.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/maven-settings-2.2.1.jar:/usr/hdp/2.3.4.0-3485/zookeeper/lib/httpclient-4.2.3.jar:
2016-01-16 12:27:51,827 INFO  [main] zookeeper.ZooKeeper: Client environment:java.library.path=:/usr/hdp/2.3.4.0-3485/hadoop/lib/native/Linux-amd64-64:/usr/hdp/2.3.4.0-3485/hadoop/lib/native
2016-01-16 12:27:51,827 INFO  [main] zookeeper.ZooKeeper: Client environment:java.io.tmpdir=/tmp
2016-01-16 12:27:51,827 INFO  [main] zookeeper.ZooKeeper: Client environment:java.compiler=<NA>
2016-01-16 12:27:51,827 INFO  [main] zookeeper.ZooKeeper: Client environment:os.name=Linux
2016-01-16 12:27:51,827 INFO  [main] zookeeper.ZooKeeper: Client environment:os.arch=amd64
2016-01-16 12:27:51,827 INFO  [main] zookeeper.ZooKeeper: Client environment:os.version=2.6.32-431.el6.x86_64
2016-01-16 12:27:51,827 INFO  [main] zookeeper.ZooKeeper: Client environment:user.name=hive
2016-01-16 12:27:51,827 INFO  [main] zookeeper.ZooKeeper: Client environment:user.home=/home/hive
2016-01-16 12:27:51,827 INFO  [main] zookeeper.ZooKeeper: Client environment:user.dir=/opt/apache-kylin-1.3-HBase-1.1-SNAPSHOT-bin
2016-01-16 12:27:51,828 INFO  [main] zookeeper.ZooKeeper: Initiating client connection, connectString=n02.kylin.hdp:2181,n03.kylin.hdp:2181,n01.kylin.hdp:2181 sessionTimeout=90000 watcher=hconnection-0x59096b660x0, quorum=n02.kylin.hdp:2181,n03.kylin.hdp:2181,n01.kylin.hdp:2181, baseZNode=/hbase-unsecure
2016-01-16 12:27:51,914 INFO  [main-SendThread(n02.kylin.hdp:2181)] zookeeper.ClientCnxn: Opening socket connection to server n02.kylin.hdp/192.168.56.102:2181. Will not attempt to authenticate using SASL (unknown error)
2016-01-16 12:27:52,012 INFO  [main-SendThread(n02.kylin.hdp:2181)] zookeeper.ClientCnxn: Socket connection established to n02.kylin.hdp/192.168.56.102:2181, initiating session
2016-01-16 12:27:52,036 INFO  [main-SendThread(n02.kylin.hdp:2181)] zookeeper.ClientCnxn: Session establishment complete on server n02.kylin.hdp/192.168.56.102:2181, sessionid = 0x2524645d5cb0009, negotiated timeout = 40000
2016-01-16 12:27:55,807 INFO  [Thread-1] client.ConnectionManager$HConnectionImplementation: Closing master protocol: MasterService
2016-01-16 12:27:55,811 INFO  [Thread-1] client.ConnectionManager$HConnectionImplementation: Closing zookeeper sessionid=0x2524645d5cb0009
2016-01-16 12:27:55,817 INFO  [Thread-1] zookeeper.ZooKeeper: Session: 0x2524645d5cb0009 closed
2016-01-16 12:27:55,818 INFO  [main-EventThread] zookeeper.ClientCnxn: EventThread shut down
Sample cube is created successfully in project 'learn_kylin'; Restart Kylin server or reload the metadata from web UI to see the change.

# KYLIN_DEBUG_SETTINGS

[hive@n01 bin]$ cat setenv.sh  |grep -i export
export KYLIN_JVM_SETTINGS="-Xms1024M -Xmx4096M -XX:MaxPermSize=128M"
# export KYLIN_JVM_SETTINGS="-Xms16g -Xmx16g -XX:MaxPermSize=512m -XX:NewSize=3g -XX:MaxNewSize=3g -XX:SurvivorRatio=4 -XX:+CMSClassUnloadingEnabled -XX:+CMSParallelRemarkEnabled -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -XX:CMSInitiatingOccupancyFraction=70 -XX:+DisableExplicitGC"
# export KYLIN_DEBUG_SETTINGS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -javaagent:${KYLIN_HOME}/lib/CustomAgent.jar -Dcom.ebay.lnp.rmiagent.port=8080"
# export KYLIN_LD_LIBRARY_SETTINGS="-Djava.library.path=/apache/hadoop/lib/native/Linux-amd64-64"
export KYLIN_EXTRA_START_OPTS=""



# 



[pool-6-thread-1]:[2016-01-16 14:16:13,014][INFO][org.apache.kylin.job.impl.threadpool.DefaultScheduler$FetcherRunner.run(DefaultScheduler.java:112)] - Job Fetcher: 1 running, 1 actual running, 0 ready, 1 others
[pool-6-thread-1]:[2016-01-16 14:17:13,017][INFO][org.apache.kylin.job.impl.threadpool.DefaultScheduler$FetcherRunner.run(DefaultScheduler.java:112)] - Job Fetcher: 1 running, 1 actual running, 0 ready, 1 others
[pool-6-thread-1]:[2016-01-16 14:18:13,026][INFO][org.apache.kylin.job.impl.threadpool.DefaultScheduler$FetcherRunner.run(DefaultScheduler.java:112)] - Job Fetcher: 1 running, 1 actual running, 0 ready, 1 others
[pool-6-thread-1]:[2016-01-16 14:19:13,013][INFO][org.apache.kylin.job.impl.threadpool.DefaultScheduler$FetcherRunner.run(DefaultScheduler.java:112)] - Job Fetcher: 1 running, 1 actual running, 0 ready, 1 others
[http-bio-7070-exec-1]:[2016-01-16 14:19:54,035][DEBUG][org.apache.kylin.rest.filter.KylinApiFilter.logRequest(KylinApiFilter.java:120)] - REQUEST: REQUESTER=ADMIN;REQ_TIME=GMT-08:00 2016-01-15 22:19:54;URI=/kylin/api/projects;METHOD=GET;QUERY_STRING=null;PAYLOAD=;RESP_STATUS=200;
[http-bio-7070-exec-10]:[2016-01-16 14:19:54,040][DEBUG][org.apache.kylin.rest.filter.KylinApiFilter.logRequest(KylinApiFilter.java:120)] - REQUEST: REQUESTER=ADMIN;REQ_TIME=GMT-08:00 2016-01-15 22:19:54;URI=/kylin/api/user/authentication;METHOD=GET;QUERY_STRING=null;PAYLOAD=;RESP_STATUS=200;
[http-bio-7070-exec-6]:[2016-01-16 14:19:54,047][DEBUG][org.apache.kylin.rest.service.AdminService.getConfigAsString(AdminService.java:90)] - Get Kylin Runtime Config
[http-bio-7070-exec-6]:[2016-01-16 14:19:54,107][DEBUG][org.apache.kylin.rest.filter.KylinApiFilter.logRequest(KylinApiFilter.java:120)] - REQUEST: REQUESTER=ADMIN;REQ_TIME=GMT-08:00 2016-01-15 22:19:54;URI=/kylin/api/admin/config;METHOD=GET;QUERY_STRING=null;PAYLOAD=;RESP_STATUS=200;
[http-bio-7070-exec-2]:[2016-01-16 14:19:54,205][DEBUG][org.apache.kylin.rest.filter.KylinApiFilter.logRequest(KylinApiFilter.java:120)] - REQUEST: REQUESTER=ADMIN;REQ_TIME=GMT-08:00 2016-01-15 22:19:54;URI=/kylin/api/jobs;METHOD=GET;QUERY_STRING=limit=15&offset=0&projectName=learn_kylin;PAYLOAD=;RESP_STATUS=200;
[pool-6-thread-1]:[2016-01-16 14:20:13,042][INFO][org.apache.kylin.job.impl.threadpool.DefaultScheduler$FetcherRunner.run(DefaultScheduler.java:112)] - Job Fetcher: 1 running, 1 actual running, 0 ready, 1 others
[pool-7-thread-1]:[2016-01-16 14:20:14,450][ERROR][org.apache.kylin.job.common.ShellExecutable.doWork(ShellExecutable.java:56)] - job:88b47594-51ad-4247-b609-d29ca9e8d255-00 execute finished with exception
java.io.IOException: OS command error exit with 1 -- hive  -e "USE default;
DROP TABLE IF EXISTS kylin_intermediate_kylin_sales_cube_desc_20120101000000_20140101000000_88b47594_51ad_4247_b609_d29ca9e8d255;

CREATE EXTERNAL TABLE IF NOT EXISTS kylin_intermediate_kylin_sales_cube_desc_20120101000000_20140101000000_88b47594_51ad_4247_b609_d29ca9e8d255
(
DEFAULT_KYLIN_SALES_PART_DT date
,DEFAULT_KYLIN_SALES_LEAF_CATEG_ID bigint
,DEFAULT_KYLIN_SALES_LSTG_SITE_ID int
,DEFAULT_KYLIN_CATEGORY_GROUPINGS_META_CATEG_NAME string
,DEFAULT_KYLIN_CATEGORY_GROUPINGS_CATEG_LVL2_NAME string
,DEFAULT_KYLIN_CATEGORY_GROUPINGS_CATEG_LVL3_NAME string
,DEFAULT_KYLIN_SALES_LSTG_FORMAT_NAME string
,DEFAULT_KYLIN_SALES_PRICE decimal(19,4)
,DEFAULT_KYLIN_SALES_SELLER_ID bigint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\177'
STORED AS SEQUENCEFILE
LOCATION '/kylin/kylin_metadata/kylin-88b47594-51ad-4247-b609-d29ca9e8d255/kylin_intermediate_kylin_sales_cube_desc_20120101000000_20140101000000_88b47594_51ad_4247_b609_d29ca9e8d255';

SET mapreduce.job.split.metainfo.maxsize=-1;
SET mapred.compress.map.output=true;
SET mapred.map.output.compression.codec=org.apache.hadoop.io.compress.SnappyCodec;
SET mapred.output.compress=true;
SET mapred.output.compression.codec=org.apache.hadoop.io.compress.SnappyCodec;
SET mapred.output.compression.type=BLOCK;
SET mapreduce.job.max.split.locations=2000;
SET dfs.replication=2;
SET hive.merge.mapfiles=true;
SET hive.merge.mapredfiles=true;
SET hive.merge.size.per.task=268435456;
SET hive.support.concurrency=false;
SET hive.exec.compress.output=true;
SET hive.auto.convert.join.noconditionaltask = true;
SET hive.auto.convert.join.noconditionaltask.size = 300000000;
INSERT OVERWRITE TABLE kylin_intermediate_kylin_sales_cube_desc_20120101000000_20140101000000_88b47594_51ad_4247_b609_d29ca9e8d255 SELECT
KYLIN_SALES.PART_DT
,KYLIN_SALES.LEAF_CATEG_ID
,KYLIN_SALES.LSTG_SITE_ID
,KYLIN_CATEGORY_GROUPINGS.META_CATEG_NAME
,KYLIN_CATEGORY_GROUPINGS.CATEG_LVL2_NAME
,KYLIN_CATEGORY_GROUPINGS.CATEG_LVL3_NAME
,KYLIN_SALES.LSTG_FORMAT_NAME
,KYLIN_SALES.PRICE
,KYLIN_SALES.SELLER_ID
FROM DEFAULT.KYLIN_SALES as KYLIN_SALES 
INNER JOIN DEFAULT.KYLIN_CAL_DT as KYLIN_CAL_DT
ON KYLIN_SALES.PART_DT = KYLIN_CAL_DT.CAL_DT
INNER JOIN DEFAULT.KYLIN_CATEGORY_GROUPINGS as KYLIN_CATEGORY_GROUPINGS
ON KYLIN_SALES.LEAF_CATEG_ID = KYLIN_CATEGORY_GROUPINGS.LEAF_CATEG_ID AND KYLIN_SALES.LSTG_SITE_ID = KYLIN_CATEGORY_GROUPINGS.SITE_ID
WHERE (KYLIN_SALES.PART_DT >= '2012-01-01' AND KYLIN_SALES.PART_DT < '2014-01-01')
;

"
WARNING: Use "yarn jar" to launch YARN applications.

Logging initialized using configuration in file:/etc/hive/2.3.4.0-3485/0/hive-log4j.properties
OK
Time taken: 2.818 seconds
OK
Time taken: 0.226 seconds
FAILED: Execution Error, return code 1 from org.apache.hadoop.hive.ql.exec.DDLTask. MetaException(message:java.security.AccessControlException: Permission denied: user=hive, access=WRITE, inode="/kylin":hdfs:hdfs:drwxr-xr-x
    at org.apache.hadoop.hdfs.server.namenode.FSPermissionChecker.check(FSPermissionChecker.java:319)
    at org.apache.hadoop.hdfs.server.namenode.FSPermissionChecker.checkPermission(FSPermissionChecker.java:219)
    at org.apache.hadoop.hdfs.server.namenode.FSPermissionChecker.checkPermission(FSPermissionChecker.java:190)
    at org.apache.hadoop.hdfs.server.namenode.FSDirectory.checkPermission(FSDirectory.java:1771)
    at org.apache.hadoop.hdfs.server.namenode.FSDirectory.checkPermission(FSDirectory.java:1755)
    at org.apache.hadoop.hdfs.server.namenode.FSDirectory.checkPathAccess(FSDirectory.java:1729)
    at org.apache.hadoop.hdfs.server.namenode.FSNamesystem.checkAccess(FSNamesystem.java:8348)
    at org.apache.hadoop.hdfs.server.namenode.NameNodeRpcServer.checkAccess(NameNodeRpcServer.java:1978)
    at org.apache.hadoop.hdfs.protocolPB.ClientNamenodeProtocolServerSideTranslatorPB.checkAccess(ClientNamenodeProtocolServerSideTranslatorPB.java:1443)
    at org.apache.hadoop.hdfs.protocol.proto.ClientNamenodeProtocolProtos$ClientNamenodeProtocol$2.callBlockingMethod(ClientNamenodeProtocolProtos.java)
    at org.apache.hadoop.ipc.ProtobufRpcEngine$Server$ProtoBufRpcInvoker.call(ProtobufRpcEngine.java:616)
    at org.apache.hadoop.ipc.RPC$Server.call(RPC.java:969)
    at org.apache.hadoop.ipc.Server$Handler$1.run(Server.java:2151)
    at org.apache.hadoop.ipc.Server$Handler$1.run(Server.java:2147)
    at java.security.AccessController.doPrivileged(Native Method)
    at javax.security.auth.Subject.doAs(Subject.java:422)
    at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1657)
    at org.apache.hadoop.ipc.Server$Handler.run(Server.java:2145)




FAILED: Execution Error, return code 1 from org.apache.hadoop.hive.ql.exec.DDLTask. MetaException(message:java.security.AccessControlException: Permission denied: user=hive, access=WRITE, inode="/kylin":hdfs:hdfs:drwxr-xr-x



解决：

使用 hdfs 用户，而非 hive 用户！！



# cube 跑到 #4 Step Name: Build Base Cuboid Data
Duration: 1.79 mins

 2016-01-16 16:15:39,353 INFO  [pool-7-thread-5] mapred.ClientServiceDelegate: Application state is completed. FinalApplicationStatus=FAILED. Redirecting to job history server
 [pool-7-thread-5]:[2016-01-16 16:15:39,495][WARN][org.apache.kylin.job.common.HadoopCmdOutput.updateJobCounter(HadoopCmdOutput.java:89)] - no counters for job job_1452878162418_0046
 [pool-7-thread-5]:[2016-01-16 16:15:39,515][DEBUG][org.apache.kylin.common.persistence.ResourceStore.putResource(ResourceStore.java:200)] - Saving resource /execute_output/35a73a4b-bd25-4ee0-beca-e5363f54656f-03 (Store kylin_metadata@hbase)



 Container [pid=12433,containerID=container_e02_1452878162418_0045_01_000005] is running beyond physical memory limits. Current usage: 206.8 MB of 170 MB physical memory used; 1.9 GB of 357.0 MB virtual memory used. Killing container. Dump of the process-tree for container_e02_1452878162418_0045_01_000005 : |- PID PPID PGRPID SESSID CMD_NAME USER_MODE_TIME(MILLIS) SYSTEM_TIME(MILLIS) VMEM_USAGE(BYTES) RSSMEM_USAGE(PAGES) FULL_CMD_LINE |- 12439 12433 12433 12433 (java) 575 59 1902309376 52581 /usr/jdk64/jdk1.8.0_60/bin/java -server -XX:NewRatio=8 -Djava.net.preferIPv4Stack=true -Dhdp.version=2.3.4.0-3485 -Xmx136m -Djava.io.tmpdir=/hadoop/yarn/local/usercache/hdfs/appcache/application_1452878162418_0045/container_e02_1452878162418_0045_01_000005/tmp -Dlog4j.configuration=container-log4j.properties -Dyarn.app.container.log.dir=/hadoop/yarn/log/application_1452878162418_0045/container_e02_1452878162418_0045_01_000005 -Dyarn.app.container.log.filesize=0 -Dhadoop.root.logger=INFO,CLA -Dhadoop.root.logfile=syslog org.apache.hadoop.mapred.YarnChild 192.168.56.101 59591 attempt_1452878162418_0045_m_000000_3 2199023255557 |- 12433 12431 12433 12433 (bash) 0 0 108621824 349 /bin/bash -c /usr/jdk64/jdk1.8.0_60/bin/java -server -XX:NewRatio=8 -Djava.net.preferIPv4Stack=true -Dhdp.version=2.3.4.0-3485 -Xmx136m -Djava.io.tmpdir=/hadoop/yarn/local/usercache/hdfs/appcache/application_1452878162418_0045/container_e02_1452878162418_0045_01_000005/tmp -Dlog4j.configuration=container-log4j.properties -Dyarn.app.container.log.dir=/hadoop/yarn/log/application_1452878162418_0045/container_e02_1452878162418_0045_01_000005 -Dyarn.app.container.log.filesize=0 -Dhadoop.root.logger=INFO,CLA -Dhadoop.root.logfile=syslog org.apache.hadoop.mapred.YarnChild 192.168.56.101 59591 attempt_1452878162418_0045_m_000000_3 2199023255557 1>/hadoop/yarn/log/application_1452878162418_0045/container_e02_1452878162418_0045_01_000005/stdout 2>/hadoop/yarn/log/application_1452878162418_0045/container_e02_1452878162418_0045_01_000005/stderr Container killed on request. Exit code is 143 Container exited with a non-zero exit code 143



#2 Step Name: Extract Fact Table Distinct Columns



no counters for job job_1454250386966_0023

我怀疑是内存不够！
解决办法：重启各节点 ！

所以各节点的内存要尽量均衡、充足！
2016-02-01 20:48


可能是内存不足！！


n02 / n03 的 mysql 版本不同！

[root@n03 ~]# service mysql stop
Shutting down MySQL..                                      [  OK  ]
[root@n03 ~]# ps -ef|grep -i mysql
root     22507 22465  0 03:21 pts/0    00:00:00 grep -i mysql
[root@n03 ~]# type mysql
mysql is /usr/bin/mysql
[root@n03 ~]# service mysqld stop
mysqld: unrecognized service
[root@n03 ~]# 
[root@n03 ~]# exit
logout
Connection to n03.kylin.hdp closed.
[root@n02 ~]# service mysql stop
mysql: unrecognized service
[root@n02 ~]# service mysqld stop
Stopping mysqld:                                           [  OK  ]
[root@n02 ~]# ps -ef|grep -i mysql
root     23246 22667  0 03:22 pts/1    00:00:00 grep -i mysql


ambari 增加节点：

http://hortonworks.com/hadoop-tutorial/using-apache-ambari-add-new-nodes-existing-cluster/



# CDH 安装 

### CDH 有几种安装方式？


# CDH 安装 

### CDH 有几种安装方式？

1. cloudera manager 方式安装，类似 windows update  , 需要稳定的外网访问。

#### Impala

是Cloudera公司主导开发的新型查询系统，它提供SQL语义，能查询存储在Hadoop的HDFS和HBase中的PB级大数据。已有的Hive系统虽然也提供了SQL语义，但由于Hive底层执行使用的是MapReduce引擎，仍然是一个批处理过程，难以满足查询的交互性。相比之下，Impala的最大特点也是最大卖点就是它的快速。

#### Hue

是一个开源的Apache Hadoop UI系统，由Cloudera Desktop演化而来，最后Cloudera公司将其贡献给Apache基金会的Hadoop社区，它是基于Python Web框架Django实现的。通过使用Hue我们可以在浏览器端的Web控制台上与Hadoop集群进行交互来分析处理数据，例如操作HDFS上的数据，运行MapReduce Job，执行Hive的SQL语句，浏览HBase数据库等等


2. parcel 安装 

下载 parcel ，通过 cm 界面 安装。

http://www.superwu.cn/2015/05/15/2235


3. yum 本地安装 

通过 下载 yum 源 (tarball) ， 配置repo的 baseurl 方式来安装。组件可以通过yum 命令方式 逐个安装配置。应该是最灵活的安装方式。
http://blog.chinaunix.net/uid-33797-id-4912855.html


http://www.cloudera.com/documentation/enterprise/latest/topics/cdh_ig_cdh5_install.html

1，2 两种方式，都需要用到cm , 还是用cm管理最方便。

cm 下载安装地址：

http://www.cloudera.com/content/www/en-us/documentation/enterprise/latest/topics/cm_vd.html#cmvd_topic_1


#### . cloudera 离线包下载
https://archive.cloudera.com/cm5/redhat/6/x86_64/cm/5/

本页详细介绍了 cdh 的 三种 安装方式：path a,b,c : 

http://www.cloudera.com/content/www/en-us/downloads/cdh/5-5-1.html

http://www.cloudera.com/content/www/en-us/documentation/enterprise/latest/topics/cm_ig_install_path_c.html#cmig_topic_6_7


# ambari + hdp + kylin 断电重启测试 

服务重启后，各个组件都能正常工作。

断电重启的主要问题是：

1. 事务中断。

2. 记录了失败状态。

3. 数据未获得保存。

直接断电关机是不推荐的。

但如果数据不重要，任务状态也不重要，只需要快速开关机，就可以直接断电。

关于ambari 上的services的启动顺序，最好编排好顺序。

比如 zookeeper 应该 先于 hive 等组件启动。

否则有些服务需要重启多次才能完全启动。


# ambari metric collector install pending ... 状态处理：

1. 切换到维护模式

2. 选择reinstall 选项

3. 重新安装后，服务是默认停止的，需要手工start 。


select * from information_schema.tables where table_name like '%olap%';






从今天开始，写点关于kylin的事情。kylin是什么？没错，麒麟，是极具中国特色的虚构动物，但它在这里不是代表某个操作系统，而是一个OLAP计算引擎!一个具有PB级数据处理能力的计算引擎。所以

# 大纲

1. 打通网络环境
2. 安装操作系统和节点环境初始化
3. 准备repo和安装包
4. 安装ambari
5. 安装HDP
6. apache kylin 部署
7. cube运行测试




    mysql -h127.0.0.1 -uroot -p000000 -e"select * from a into outfile '1.txt' fields terminated by ',' lines terminated by '\r\n'" test
    如果不想输出列名信息：

mysql -uroot -p  -D datafactory -N -e "select distinct * from pmt_kpi_mer_cust_mid_olap into outfile 'pmt_kpi_mer_cust_mid_olap.txt' fields terminated by ',' "

lines terminated by '\r\n'"



select count(0) from (select distinct * from  pmt_kpi_mer_cust_mid_olap_bak ) as a;


# mysql 样本数据去重导出

rm /tmp/pmt_kpi_mer_cust_mid_olap.txt

nohup time mysql -uroot -pxxx  -D datafactory -N -e "select distinct * from pmt_kpi_mer_cust_mid_olap into outfile '/tmp/pmt_kpi_mer_cust_mid_olap.txt' fields terminated by ',' " > /tmp/mysql.pmt.out 2>&1 &


# 基于kylin 和 hive的查询测试语句 
select part_dt, sum(price) as total_selled, count(distinct seller_id) as sellers from kylin_sales group by part_dt order by part_dt



rm /tmp/yes_no.txt
nohup time mysql -uroot -pSL2015bi07@  -D datafactory  -e "select distinct * from yes_no into outfile '/tmp/yes_no.txt' fields terminated by ',' " > /tmp/mysql.yesno.out 2>&1 &



＃ ambari 启动顺序：

hdfs zookeeper hbase mapreduce2 hive yarn




./ambari-agent.log.1:ERROR 2016-01-20 08:39:26,885 script_alert.py:112 - [Alert][hive_server_process] Failed with result CRITICAL: ['Connection failed on host n02.kylin.hdp:10000 (Traceback (most recent call last):\n  File "/var/lib/ambari-agent/cache/common-services/HIVE/0.12.0.2.0/package/alerts/alert_hive_thrift_port.py", line 192, in execute\n    ssl_keystore=hive_ssl_keystore_path, ssl_password=hive_ssl_keystore_password)\n  File "/usr/lib/python2.6/site-packages/resource_management/libraries/functions/hive_check.py", line 69, in check_thrift_port_sasl\n    timeout=beeline_check_timeout\n  File "/usr/lib/python2.6/site-packages/resource_management/core/base.py", line 154, in __init__\n    self.env.run()\n  File "/usr/lib/python2.6/site-packages/resource_management/core/environment.py", line 158, in run\n    self.run_action(resource, action)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/environment.py", line 121, in run_action\n    provider_action()\n  File "/usr/lib/python2.6/site-packages/resource_management/core/providers/system.py", line 238, in action_run\n    tries=self.resource.tries, try_sleep=self.resource.try_sleep)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 70, in inner\n    result = function(command, **kwargs)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 92, in checked_call\n    tries=tries, try_sleep=try_sleep)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 140, in _call_wrapper\n    result = _call(command, **kwargs_copy)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 285, in _call\n    raise ExecuteTimeoutException(err_msg)\nExecuteTimeoutException: Execution of \'ambari-sudo.sh su ambari-qa -l -s /bin/bash -c \'export  PATH=\'"\'"\'/usr/sbin:/sbin:/usr/lib/ambari-server/*:/sbin:/usr/sbin:/bin:/usr/bin:/var/lib/ambari-agent:/bin/:/usr/bin/:/usr/lib/hive/bin/:/usr/sbin/\'"\'"\' ; ! beeline -u \'"\'"\'jdbc:hive2://n02.kylin.hdp:10000/;transportMode=binary\'"\'"\' -e \'"\'"\'\'"\'"\' 2>&1| awk \'"\'"\'{print}\'"\'"\'|grep -i -e \'"\'"\'Connection refused\'"\'"\' -e \'"\'"\'Invalid URL\'"\'"\'\'\' was killed due timeout after 30 seconds\n)']





./ambari-agent.log.1:ERROR 2016-01-21 12:34:40,942 script_alert.py:112 - [Alert][hive_server_process] Failed with result CRITICAL: ['Connection failed on host n02.kylin.hdp:10000 (Traceback (most recent call last):\n  File "/var/lib/ambari-agent/cache/common-services/HIVE/0.12.0.2.0/package/alerts/alert_hive_thrift_port.py", line 192, in execute\n    ssl_keystore=hive_ssl_keystore_path, ssl_password=hive_ssl_keystore_password)\n  File "/usr/lib/python2.6/site-packages/resource_management/libraries/functions/hive_check.py", line 69, in check_thrift_port_sasl\n    timeout=beeline_check_timeout\n  File "/usr/lib/python2.6/site-packages/resource_management/core/base.py", line 154, in __init__\n    self.env.run()\n  File "/usr/lib/python2.6/site-packages/resource_management/core/environment.py", line 158, in run\n    self.run_action(resource, action)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/environment.py", line 121, in run_action\n    provider_action()\n  File "/usr/lib/python2.6/site-packages/resource_management/core/providers/system.py", line 238, in action_run\n    tries=self.resource.tries, try_sleep=self.resource.try_sleep)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 70, in inner\n    result = function(command, **kwargs)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 92, in checked_call\n    tries=tries, try_sleep=try_sleep)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 140, in _call_wrapper\n    result = _call(command, **kwargs_copy)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 291, in _call\n    raise Fail(err_msg)\nFail: Execution of \'! beeline -u \'jdbc:hive2://n02.kylin.hdp:10000/;transportMode=binary\' -e \'\' 2>&1| awk \'{print}\'|grep -i -e \'Connection refused\' -e \'Invalid URL\'\' returned 1. Error: Could not open client transport with JDBC Uri: jdbc:hive2://n02.kylin.hdp:10000/;transportMode=binary: java.net.ConnectException: Connection refused (state=08S01,code=0)\nError: Could not open client transport with JDBC Uri: jdbc:hive2://n02.kylin.hdp:10000/;transportMode=binary: java.net.ConnectException: Connection refused (state=08S01,code=0)\n)']



该异常可能的原因：

1. 组件启动顺序不对
2. /etc/hosts 域名-IP映射关系


老的设置：

10.0.2.11 n01.kylin.hdp
10.0.2.12 n02.kylin.hdp
10.0.2.13 n03.kylin.hdp

192.168.1.222 mac
192.168.1.222 poon
192.168.1.222 host


192.168.56.101 n01.kylin.hdp
192.168.56.102 n02.kylin.hdp
192.168.56.103 n03.kylin.hdp


新的设置：

10.0.2.11 n01.kylin.hdp
10.0.2.12 n02.kylin.hdp
10.0.2.13 n03.kylin.hdp

192.168.1.222 mac
192.168.1.222 poon
192.168.1.222 host


#192.168.56.101 n01.kylin.hdp
#192.168.56.102 n02.kylin.hdp
#192.168.56.103 n03.kylin.hdp



## 问题：如果在ambari界面重新安装 ambari metric monitor ？ 发现 metrics 启动的时候，有些依赖的文件找不到。






./ambari-agent.log.1:INFO 2016-01-21 12:34:25,702 logger.py:67 - Execute['! beeline -u 'jdbc:hive2://n02.kylin.hdp:10000/;transportMode=binary' -e '' 2>&1| awk '{print}'|grep -i -e 'Connection refused' -e 'Invalid URL''] {'path': ['/bin/', '/usr/bin/', '/usr/lib/hive/bin/', '/usr/sbin/'], 'user': 'ambari-qa', 'timeout': 30}



/usr/hdp/2.3.4.0-3485/hadoop/conf/yarn-site.xml



[root@n02 2.3.4.0-3485]# ll /usr/hdp/2.3.4.0-3485/hadoop/conf/yarn-site.xml
-rw-r--r-- 1 yarn hadoop 15445 Jan 19 12:02 /usr/hdp/2.3.4.0-3485/hadoop/conf/yarn-site.xml



# 补充安装 ambari-metrics-monitor 


[1]+  Killed                  yum install ambari-metrics-monitor-2.2.0.0-1310
[root@n02 ~]# pwd
/root
[root@n02 ~]# yum install ambari-metrics-monitor-2.2.0.0-1310
Loaded plugins: fastestmirror, priorities
Loading mirror speeds from cached hostfile
 * base: centos.ustc.edu.cn
 * extras: centos.ustc.edu.cn
 * updates: centos.ustc.edu.cn
HDP-2.3                                                                                                                                                       | 2.9 kB     00:00     
HDP-UTILS-1.1.0.20                                                                                                                                            | 2.9 kB     00:00     
local-HDP-2.3.4.0                                                                                                                                             | 2.9 kB     00:00     
local-HDP-UTILS-1.1.0.20                                                                                                                                      | 2.9 kB     00:00     
local-Updates-ambari-2.2.0.0                                                                                                                                  | 2.9 kB     00:00     
236 packages excluded due to repository priority protections
Setting up Install Process
Resolving Dependencies
--> Running transaction check
---> Package ambari-metrics-monitor.x86_64 0:2.2.0.0-1310 will be installed
--> Processing Dependency: python-devel for package: ambari-metrics-monitor-2.2.0.0-1310.x86_64
--> Processing Dependency: gcc for package: ambari-metrics-monitor-2.2.0.0-1310.x86_64
--> Running transaction check
---> Package gcc.x86_64 0:4.4.7-16.el6 will be installed
--> Processing Dependency: cpp = 4.4.7-16.el6 for package: gcc-4.4.7-16.el6.x86_64
--> Processing Dependency: libgcc >= 4.4.7-16.el6 for package: gcc-4.4.7-16.el6.x86_64
--> Processing Dependency: cloog-ppl >= 0.15 for package: gcc-4.4.7-16.el6.x86_64
---> Package python-devel.x86_64 0:2.6.6-64.el6 will be installed
--> Processing Dependency: python-libs(x86-64) = 2.6.6-64.el6 for package: python-devel-2.6.6-64.el6.x86_64
--> Processing Dependency: python = 2.6.6-64.el6 for package: python-devel-2.6.6-64.el6.x86_64
--> Running transaction check
---> Package cloog-ppl.x86_64 0:0.15.7-1.2.el6 will be installed
--> Processing Dependency: libppl_c.so.2()(64bit) for package: cloog-ppl-0.15.7-1.2.el6.x86_64
--> Processing Dependency: libppl.so.7()(64bit) for package: cloog-ppl-0.15.7-1.2.el6.x86_64
---> Package cpp.x86_64 0:4.4.7-16.el6 will be installed
--> Processing Dependency: libmpfr.so.1()(64bit) for package: cpp-4.4.7-16.el6.x86_64
---> Package libgcc.x86_64 0:4.4.7-4.el6 will be updated
---> Package libgcc.x86_64 0:4.4.7-16.el6 will be an update
---> Package python.x86_64 0:2.6.6-51.el6 will be updated
---> Package python.x86_64 0:2.6.6-64.el6 will be an update
---> Package python-libs.x86_64 0:2.6.6-51.el6 will be updated
---> Package python-libs.x86_64 0:2.6.6-64.el6 will be an update
--> Running transaction check
---> Package mpfr.x86_64 0:2.4.1-6.el6 will be installed
---> Package ppl.x86_64 0:0.10.2-11.el6 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

=====================================================================================================================================================================================
 Package                                         Arch                            Version                                 Repository                                             Size
=====================================================================================================================================================================================
Installing:
 ambari-metrics-monitor                          x86_64                          2.2.0.0-1310                            local-Updates-ambari-2.2.0.0                          172 k
Installing for dependencies:
 cloog-ppl                                       x86_64                          0.15.7-1.2.el6                          base                                                   93 k
 cpp                                             x86_64                          4.4.7-16.el6                            base                                                  3.7 M
 gcc                                             x86_64                          4.4.7-16.el6                            base                                                   10 M
 mpfr                                            x86_64                          2.4.1-6.el6                             base                                                  157 k
 ppl                                             x86_64                          0.10.2-11.el6                           base                                                  1.3 M
 python-devel                                    x86_64                          2.6.6-64.el6                            base                                                  172 k
Updating for dependencies:
 libgcc                                          x86_64                          4.4.7-16.el6                            base                                                  103 k
 python                                          x86_64                          2.6.6-64.el6                            base                                                   76 k
 python-libs                                     x86_64                          2.6.6-64.el6                            base                                                  5.3 M

Transaction Summary
=====================================================================================================================================================================================
Install       7 Package(s)
Upgrade       3 Package(s)

Total download size: 21 M
Is this ok [y/N]: y
Downloading Packages:
(1/10): ambari-metrics-monitor-2.2.0.0-1310.x86_64.rpm                                                                                                        | 172 kB     00:00     
(2/10): cloog-ppl-0.15.7-1.2.el6.x86_64.rpm                                                                                                                   |  93 kB     00:00     
(3/10): cpp-4.4.7-16.el6.x86_64.rpm                                                                                                                           | 3.7 MB     00:03     
(4/10): gcc-4.4.7-16.el6.x86_64.rpm                                                                                                                           |  10 MB     00:08     
(5/10): libgcc-4.4.7-16.el6.x86_64.rpm                                                                                                                        | 103 kB     00:00     
(6/10): mpfr-2.4.1-6.el6.x86_64.rpm                                                                                                                           | 157 kB     00:00     
(7/10): ppl-0.10.2-11.el6.x86_64.rpm                                                                                                                          | 1.3 MB     00:01     
(8/10): python-2.6.6-64.el6.x86_64.rpm                                                                                                                        |  76 kB     00:00     
(9/10): python-devel-2.6.6-64.el6.x86_64.rpm                                                                                                                  | 172 kB     00:00     
(10/10): python-libs-2.6.6-64.el6.x86_64.rpm                                                                                                                  | 5.3 MB     00:04     
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                1.0 MB/s |  21 MB     00:20     
Running rpm_check_debug
Running Transaction Test
Transaction Test Succeeded
Running Transaction
  Updating   : python-2.6.6-64.el6.x86_64                                                                                                                                       1/13 
  Updating   : python-libs-2.6.6-64.el6.x86_64                                                                                                                                  2/13 
  Updating   : libgcc-4.4.7-16.el6.x86_64                                                                                                                                       3/13 
  Installing : ppl-0.10.2-11.el6.x86_64                                                                                                                                         4/13 
  Installing : cloog-ppl-0.15.7-1.2.el6.x86_64                                                                                                                                  5/13 
  Installing : python-devel-2.6.6-64.el6.x86_64                                                                                                                                 6/13 
  Installing : mpfr-2.4.1-6.el6.x86_64                                                                                                                                          7/13 
  Installing : cpp-4.4.7-16.el6.x86_64                                                                                                                                          8/13 
  Installing : gcc-4.4.7-16.el6.x86_64                                                                                                                                          9/13 
  Installing : ambari-metrics-monitor-2.2.0.0-1310.x86_64                                                                                                                      10/13 
  Cleanup    : python-2.6.6-51.el6.x86_64                                                                                                                                      11/13 
  Cleanup    : python-libs-2.6.6-51.el6.x86_64                                                                                                                                 12/13 
  Cleanup    : libgcc-4.4.7-4.el6.x86_64                                                                                                                                       13/13 
  Verifying  : python-devel-2.6.6-64.el6.x86_64                                                                                                                                 1/13 
  Verifying  : gcc-4.4.7-16.el6.x86_64                                                                                                                                          2/13 
  Verifying  : ambari-metrics-monitor-2.2.0.0-1310.x86_64                                                                                                                       3/13 
  Verifying  : python-libs-2.6.6-64.el6.x86_64                                                                                                                                  4/13 
  Verifying  : mpfr-2.4.1-6.el6.x86_64                                                                                                                                          5/13 
  Verifying  : cloog-ppl-0.15.7-1.2.el6.x86_64                                                                                                                                  6/13 
  Verifying  : python-2.6.6-64.el6.x86_64                                                                                                                                       7/13 
  Verifying  : cpp-4.4.7-16.el6.x86_64                                                                                                                                          8/13 
  Verifying  : ppl-0.10.2-11.el6.x86_64                                                                                                                                         9/13 
  Verifying  : libgcc-4.4.7-16.el6.x86_64                                                                                                                                      10/13 
  Verifying  : python-libs-2.6.6-51.el6.x86_64                                                                                                                                 11/13 
  Verifying  : libgcc-4.4.7-4.el6.x86_64                                                                                                                                       12/13 
  Verifying  : python-2.6.6-51.el6.x86_64                                                                                                                                      13/13 

Installed:
  ambari-metrics-monitor.x86_64 0:2.2.0.0-1310                                                                                                                                       

Dependency Installed:
  cloog-ppl.x86_64 0:0.15.7-1.2.el6  cpp.x86_64 0:4.4.7-16.el6  gcc.x86_64 0:4.4.7-16.el6  mpfr.x86_64 0:2.4.1-6.el6  ppl.x86_64 0:0.10.2-11.el6  python-devel.x86_64 0:2.6.6-64.el6 

Dependency Updated:
  libgcc.x86_64 0:4.4.7-16.el6                              python.x86_64 0:2.6.6-64.el6                              python-libs.x86_64 0:2.6.6-64.el6                             

Complete!
[root@n02 ~]# ssh n03.kylin.hdp 
Last login: Mon Jan 25 11:22:29 2016 from n01.kylin.hdp
[root@n03 ~]#  yum install ambari-metrics-monitor-2.2.0.0-1310
Loaded plugins: fastestmirror, priorities
Determining fastest mirrors
 * base: centos.ustc.edu.cn
 * extras: mirrors.cqu.edu.cn
 * updates: centos.ustc.edu.cn
HDP-2.3                                                                                                                                                       | 2.9 kB     00:00     
HDP-UTILS-1.1.0.20                                                                                                                                            | 2.9 kB     00:00     
base                                                                                                                                                          | 3.7 kB     00:00     
extras                                                                                                                                                        | 3.4 kB     00:00     
local-HDP-2.3.4.0                                                                                                                                             | 2.9 kB     00:00     
local-HDP-UTILS-1.1.0.20                                                                                                                                      | 2.9 kB     00:00     
local-Updates-ambari-2.2.0.0                                                                                                                                  | 2.9 kB     00:00     
updates                                                                                                                                                       | 3.4 kB     00:00     
updates/primary_db                                                                                                                                            | 3.3 MB     00:04     
236 packages excluded due to repository priority protections
Setting up Install Process
Resolving Dependencies
--> Running transaction check
---> Package ambari-metrics-monitor.x86_64 0:2.2.0.0-1310 will be installed
--> Processing Dependency: python-devel for package: ambari-metrics-monitor-2.2.0.0-1310.x86_64
--> Processing Dependency: gcc for package: ambari-metrics-monitor-2.2.0.0-1310.x86_64
--> Running transaction check
---> Package gcc.x86_64 0:4.4.7-16.el6 will be installed
--> Processing Dependency: cpp = 4.4.7-16.el6 for package: gcc-4.4.7-16.el6.x86_64
--> Processing Dependency: libgcc >= 4.4.7-16.el6 for package: gcc-4.4.7-16.el6.x86_64
--> Processing Dependency: cloog-ppl >= 0.15 for package: gcc-4.4.7-16.el6.x86_64
---> Package python-devel.x86_64 0:2.6.6-64.el6 will be installed
--> Processing Dependency: python-libs(x86-64) = 2.6.6-64.el6 for package: python-devel-2.6.6-64.el6.x86_64
--> Processing Dependency: python = 2.6.6-64.el6 for package: python-devel-2.6.6-64.el6.x86_64
--> Running transaction check
---> Package cloog-ppl.x86_64 0:0.15.7-1.2.el6 will be installed
--> Processing Dependency: libppl_c.so.2()(64bit) for package: cloog-ppl-0.15.7-1.2.el6.x86_64
--> Processing Dependency: libppl.so.7()(64bit) for package: cloog-ppl-0.15.7-1.2.el6.x86_64
---> Package cpp.x86_64 0:4.4.7-16.el6 will be installed
--> Processing Dependency: libmpfr.so.1()(64bit) for package: cpp-4.4.7-16.el6.x86_64
---> Package libgcc.x86_64 0:4.4.7-4.el6 will be updated
---> Package libgcc.x86_64 0:4.4.7-16.el6 will be an update
---> Package python.x86_64 0:2.6.6-51.el6 will be updated
---> Package python.x86_64 0:2.6.6-64.el6 will be an update
---> Package python-libs.x86_64 0:2.6.6-51.el6 will be updated
---> Package python-libs.x86_64 0:2.6.6-64.el6 will be an update
--> Running transaction check
---> Package mpfr.x86_64 0:2.4.1-6.el6 will be installed
---> Package ppl.x86_64 0:0.10.2-11.el6 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

=====================================================================================================================================================================================
 Package                                         Arch                            Version                                 Repository                                             Size
=====================================================================================================================================================================================
Installing:
 ambari-metrics-monitor                          x86_64                          2.2.0.0-1310                            local-Updates-ambari-2.2.0.0                          172 k
Installing for dependencies:
 cloog-ppl                                       x86_64                          0.15.7-1.2.el6                          base                                                   93 k
 cpp                                             x86_64                          4.4.7-16.el6                            base                                                  3.7 M
 gcc                                             x86_64                          4.4.7-16.el6                            base                                                   10 M
 mpfr                                            x86_64                          2.4.1-6.el6                             base                                                  157 k
 ppl                                             x86_64                          0.10.2-11.el6                           base                                                  1.3 M
 python-devel                                    x86_64                          2.6.6-64.el6                            base                                                  172 k
Updating for dependencies:
 libgcc                                          x86_64                          4.4.7-16.el6                            base                                                  103 k
 python                                          x86_64                          2.6.6-64.el6                            base                                                   76 k
 python-libs                                     x86_64                          2.6.6-64.el6                            base                                                  5.3 M

Transaction Summary
=====================================================================================================================================================================================
Install       7 Package(s)
Upgrade       3 Package(s)

Total download size: 21 M
Is this ok [y/N]: y
Downloading Packages:
(1/10): ambari-metrics-monitor-2.2.0.0-1310.x86_64.rpm                                                                                                        | 172 kB     00:00     
(2/10): cloog-ppl-0.15.7-1.2.el6.x86_64.rpm                                                                                                                   |  93 kB     00:00     
(3/10): cpp-4.4.7-16.el6.x86_64.rpm                                                                                                                           | 3.7 MB     00:03     
(4/10): gcc-4.4.7-16.el6.x86_64.rpm                                                                                                                           |  10 MB     00:08     
(5/10): libgcc-4.4.7-16.el6.x86_64.rpm                                                                                                                        | 103 kB     00:00     
(6/10): mpfr-2.4.1-6.el6.x86_64.rpm                                                                                                                           | 157 kB     00:00     
(7/10): ppl-0.10.2-11.el6.x86_64.rpm                                                                                                                          | 1.3 MB     00:01     
(8/10): python-2.6.6-64.el6.x86_64.rpm                                                                                                                        |  76 kB     00:00     
(9/10): python-devel-2.6.6-64.el6.x86_64.rpm                                                                                                                  | 172 kB     00:00     
(10/10): python-libs-2.6.6-64.el6.x86_64.rpm                                                                                                                  | 5.3 MB     00:04     
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                1.1 MB/s |  21 MB     00:18     
Running rpm_check_debug
Running Transaction Test
Transaction Test Succeeded
Running Transaction
  Updating   : python-2.6.6-64.el6.x86_64                                                                                                                                       1/13 
  Updating   : python-libs-2.6.6-64.el6.x86_64                                                                                                                                  2/13 
  Updating   : libgcc-4.4.7-16.el6.x86_64                                                                                                                                       3/13 
  Installing : ppl-0.10.2-11.el6.x86_64                                                                                                                                         4/13 
  Installing : cloog-ppl-0.15.7-1.2.el6.x86_64                                                                                                                                  5/13 
  Installing : python-devel-2.6.6-64.el6.x86_64                                                                                                                                 6/13 
  Installing : mpfr-2.4.1-6.el6.x86_64                                                                                                                                          7/13 
  Installing : cpp-4.4.7-16.el6.x86_64                                                                                                                                          8/13 
  Installing : gcc-4.4.7-16.el6.x86_64                                                                                                                                          9/13 
  Installing : ambari-metrics-monitor-2.2.0.0-1310.x86_64                                                                                                                      10/13 
  Cleanup    : python-2.6.6-51.el6.x86_64                                                                                                                                      11/13 
  Cleanup    : python-libs-2.6.6-51.el6.x86_64                                                                                                                                 12/13 
  Cleanup    : libgcc-4.4.7-4.el6.x86_64                                                                                                                                       13/13 
  Verifying  : python-devel-2.6.6-64.el6.x86_64                                                                                                                                 1/13 
  Verifying  : gcc-4.4.7-16.el6.x86_64                                                                                                                                          2/13 
  Verifying  : ambari-metrics-monitor-2.2.0.0-1310.x86_64                                                                                                                       3/13 
  Verifying  : python-libs-2.6.6-64.el6.x86_64                                                                                                                                  4/13 
  Verifying  : mpfr-2.4.1-6.el6.x86_64                                                                                                                                          5/13 
  Verifying  : cloog-ppl-0.15.7-1.2.el6.x86_64                                                                                                                                  6/13 
  Verifying  : python-2.6.6-64.el6.x86_64                                                                                                                                       7/13 
  Verifying  : cpp-4.4.7-16.el6.x86_64                                                                                                                                          8/13 
  Verifying  : ppl-0.10.2-11.el6.x86_64                                                                                                                                         9/13 
  Verifying  : libgcc-4.4.7-16.el6.x86_64                                                                                                                                      10/13 
  Verifying  : python-libs-2.6.6-51.el6.x86_64                                                                                                                                 11/13 
  Verifying  : libgcc-4.4.7-4.el6.x86_64                                                                                                                                       12/13 
  Verifying  : python-2.6.6-51.el6.x86_64                                                                                                                                      13/13 

Installed:
  ambari-metrics-monitor.x86_64 0:2.2.0.0-1310                                                                                                                                       

Dependency Installed:
  cloog-ppl.x86_64 0:0.15.7-1.2.el6  cpp.x86_64 0:4.4.7-16.el6  gcc.x86_64 0:4.4.7-16.el6  mpfr.x86_64 0:2.4.1-6.el6  ppl.x86_64 0:0.10.2-11.el6  python-devel.x86_64 0:2.6.6-64.el6 

Dependency Updated:
  libgcc.x86_64 0:4.4.7-16.el6                              python.x86_64 0:2.6.6-64.el6                              python-libs.x86_64 0:2.6.6-64.el6                             

Complete!



# disk usage 只有当metric monitor 服务启动之后，才能统计得到。



times2(){
  
  orig_file=$1
  tmp_file=/tmp/$$

  cat $orig_file $orig_file > $tmp_file
  mv $tmp_file $orig_file
}






CREATE TABLE `pmt_kpi_mer_cust_mid_olap` (
  `nat_adr_prvv` varchar(50) DEFAULT NULL COMMENT '户籍地址所在省份',
  `nat_adr_sub_center` varchar(50) DEFAULT NULL COMMENT '户籍地址所在分中心',
  `nat_adr_cty` varchar(50) DEFAULT NULL COMMENT '户籍地址所在城市',
  `nat_adr_ara` varchar(50) DEFAULT NULL COMMENT '户籍地址所在区县',
  `mail_adr_prv` varchar(50) DEFAULT NULL COMMENT '账单地址所在省份',
  `mail_adr_sub_center` varchar(50) DEFAULT NULL COMMENT '账单地址所在分中心',
  `mail_adr_sub_center_l2` varchar(50) DEFAULT NULL COMMENT '账单地址所在二级分中心',
  `mail_adr_cty` varchar(50) DEFAULT NULL COMMENT '账单地址所在城市',
  `sale_chnl1_nme` varchar(80) DEFAULT NULL COMMENT '销售渠道1',
  `sale_chnl2_nme` varchar(80) DEFAULT NULL COMMENT '销售渠道2',
  `bus_type1_desc` varchar(80) DEFAULT NULL COMMENT '大行业',
  `bus_type2_desc` varchar(80) DEFAULT NULL COMMENT '小行业',
  `bus_spec_type` varchar(80) DEFAULT NULL COMMENT '特殊行业类型',
  `pos_desc` varchar(80) DEFAULT NULL COMMENT '职位',
  `main_cust_grp` varchar(80) DEFAULT NULL COMMENT '主要人群',
  `cust_sex` varchar(1) DEFAULT NULL COMMENT '性别',
  `cust_qualification` varchar(2) DEFAULT NULL COMMENT '学历',
  `cust_age_grp` varchar(2) DEFAULT NULL COMMENT '申请室年龄段',
  `cust_age_grp_new` varchar(2) DEFAULT NULL COMMENT '申请室年龄段（new）',
  `card_fj_year` varchar(10) DEFAULT NULL COMMENT '发卡年份',
  `card_fj_quat` varchar(10) DEFAULT NULL COMMENT '发卡季度',
  `card_fj_month` varchar(10) DEFAULT NULL COMMENT '发卡月份',
  `card_open_mths_grp` varchar(2) DEFAULT NULL COMMENT '账龄区间段',
  `card_open_mths_grp_new` varchar(2) DEFAULT NULL COMMENT '账龄区间段(新)',
  `cust_perm_crlimit_grp` varchar(2) DEFAULT NULL COMMENT '当前客户永久额度段',
  `cust_perm_crlimit_grp_new` varchar(2) DEFAULT NULL COMMENT '当前客户永久额度段(new)',
  `top_card_level` varchar(2) DEFAULT NULL COMMENT '最高卡级别',
  `tgt_cust_grp_flg` varchar(1) DEFAULT NULL COMMENT '是否目标人群',
  `m_h_qualification_flg` varchar(1) DEFAULT NULL COMMENT '中高学历标识',
  `main_urban_native_flg` varchar(1) DEFAULT NULL COMMENT '中大城市土著标识',
  `prof_white_collar_flg` varchar(1) DEFAULT NULL COMMENT '职业白领标识',
  `m_h_prp_owner_flg` varchar(1) DEFAULT NULL COMMENT '中高端小区业主标识',
  `rvlv_flg` varchar(1) DEFAULT NULL COMMENT '当前循环标识',
  `cash_flg` varchar(1) DEFAULT NULL COMMENT '当前取现标识',
  `installment_flg` varchar(1) DEFAULT NULL COMMENT '当前分期标识',
  `installment_type` varchar(20) DEFAULT NULL COMMENT '分期类型',
  `cust_valid_flg` varchar(1) DEFAULT NULL COMMENT '有效客户标识',
  `cust_active_ind` varchar(1) DEFAULT NULL COMMENT '客户活跃度',
  `mord_cash_flg` varchar(1) DEFAULT NULL COMMENT '是否现金分期(含转呆)',
  `mord_xkx_flg` varchar(1) DEFAULT NULL COMMENT '是否新快现分期(含转呆)',
  `mord_xinjb_flg` varchar(1) DEFAULT NULL COMMENT '是否信金宝分期(含转呆)',
  `mord_ymj_flg` varchar(1) DEFAULT NULL COMMENT '是否圆梦金分期(含转呆)',
  `mord_bill_flg` varchar(1) DEFAULT NULL COMMENT '是否账单分期(含转呆)',
  `mord_single_flg` varchar(1) DEFAULT NULL COMMENT '是否单笔分期(含转呆)',
  `sale_nbr_l1` varchar(6) DEFAULT NULL COMMENT '销售人员代码',
  `rlnship_due_m2_up_flg` varchar(1) DEFAULT NULL COMMENT '直系亲属逾期M2+标识',
  `cust_bf_due_grp` varchar(2) DEFAULT NULL COMMENT '逾期金额段',
  `cust_marital_st` varchar(1) DEFAULT NULL COMMENT '婚姻状况',
  `kpi_cnt_apm_fnfj` decimal(15,0) DEFAULT NULL COMMENT '终审量',
  `kpi_cnt_apm_aprv` decimal(15,0) DEFAULT NULL COMMENT '核准量',
  `kpi_cnt_apm_cncl` decimal(15,0) DEFAULT NULL COMMENT '取消量',
  `kpi_cnt_apm_fnfi_mtd` decimal(15,0) DEFAULT NULL COMMENT '当月终身量',
  `kpi_cnt_apm_aprv_mtd` decimal(15,0) DEFAULT NULL COMMENT '当月核准量',
  `kpi_cnt_apm_cncl_mtd` decimal(15,0) DEFAULT NULL COMMENT '当月取消量',
  `kpi_cnt_apm_main_mtd` decimal(15,0) DEFAULT NULL COMMENT '当月开户主账户量',
  `kpi_amt_cst_bf` decimal(18,2) DEFAULT NULL COMMENT '贷款金额',
  `kpi_cnt_cst_bf` decimal(15,0) DEFAULT NULL COMMENT '贷款人数',
  `kpi_amt_cst_fq` decimal(18,2) DEFAULT NULL COMMENT '分期贷款本金',
  `kpi_cnt_cst_fq` decimal(15,0) DEFAULT NULL COMMENT '分期贷款客户数',
  `kpi_amt_cst_bj_cash` decimal(18,2) DEFAULT NULL COMMENT '现金贷款本金',
  `kpi_cnt_cst_bj_cash` decimal(15,0) DEFAULT NULL COMMENT '现金贷款客户数',
  `kpi_amt_cst_yf` decimal(18,2) DEFAULT NULL COMMENT '贷款余额(含POS)',
  `kpi_amt_cst_rvlv_cur` decimal(18,2) DEFAULT NULL COMMENT '循环贷款本金',
  `kpi_cnt_cst_rvlv_cur` decimal(15,0) DEFAULT NULL COMMENT '循环贷款客户数',
  `kpi_amt_cst_txn` decimal(18,2) DEFAULT NULL COMMENT '交易金额',
  `kpi_cnt_cst_txn` decimal(15,0) DEFAULT NULL COMMENT '交易人数',
  `kpi_amt_cst_cash` decimal(18,2) DEFAULT NULL COMMENT '取现金额',
  `kpi_cnt_cst_cash` decimal(15,0) DEFAULT NULL COMMENT '取现人数',
  `kpi_amt_cst_cashout` decimal(18,2) DEFAULT NULL COMMENT '套现金额',
  `kpi_cnt_cst_cashout` decimal(15,0) DEFAULT NULL COMMENT '套现人数',
  `kpi_amt_cst_bf_due` decimal(18,2) DEFAULT NULL COMMENT '逾期金额',
  `kpi_cnt_cst_bf_due` decimal(15,0) DEFAULT NULL COMMENT '逾期人数',
  `kpi_amt_cst_crlimit` decimal(18,2) DEFAULT NULL COMMENT '客户授信额度金额',
  `kpi_amt_cst_avail_crlimit` decimal(18,2) DEFAULT NULL COMMENT '客户可用额度金额',
  `kpi_amt_cst_bf_m0` decimal(18,2) DEFAULT NULL COMMENT 'M0金额(本金含OPS)',
  `kpi_amt_cst_bf_m1` decimal(18,2) DEFAULT NULL COMMENT 'M1金额(本金含OPS)',
  `kpi_amt_cst_bf_m2` decimal(18,2) DEFAULT NULL COMMENT 'M2金额(本金含OPS)',
  `kpi_amt_cst_bf_m3` decimal(18,2) DEFAULT NULL COMMENT 'M3金额(本金含OPS)',
  `kpi_amt_cst_bf_m4` decimal(18,2) DEFAULT NULL COMMENT 'M4金额(本金含OPS)',
  `kpi_amt_cst_bf_m5` decimal(18,2) DEFAULT NULL COMMENT 'M5金额(本金含OPS)',
  `kpi_amt_cst_bf_m6` decimal(18,2) DEFAULT NULL COMMENT 'M6金额(本金含OPS)',
  `kpi_amt_cst_bf_m7` decimal(18,2) DEFAULT NULL COMMENT 'M7金额(本金含OPS)',
  `kpi_amt_cst_bf_m8` decimal(18,2) DEFAULT NULL COMMENT 'M8金额(本金含OPS)',
  `kpi_amt_cst_bf_mh` decimal(18,2) DEFAULT NULL COMMENT '历史挂账损失(本金含OPS)',
  `kpi_amt_cst_bf_hx` decimal(18,2) DEFAULT NULL COMMENT '核销金额',
  `kpi_cnt_cst_bf_hx` decimal(15,0) DEFAULT NULL COMMENT '核销客户数',
  `kpi_amt_cst_risk5_zc` decimal(18,2) DEFAULT NULL COMMENT '正常类贷款本金',
  `kpi_amt_cst_risk5_gz` decimal(18,2) DEFAULT NULL COMMENT '关注类贷款本金',
  `kpi_amt_cst_risk5_cj` decimal(18,2) DEFAULT NULL COMMENT '次级类贷款本金',
  `kpi_amt_cst_risk5_ky` decimal(18,2) DEFAULT NULL COMMENT '可疑类贷款本金',
  `kpi_amt_cst_risk5_ss` decimal(18,2) DEFAULT NULL COMMENT '损失类贷款本金',
  `kpi_cnt_cst_risk5_zc` decimal(15,0) DEFAULT NULL COMMENT '正常类贷款客户数',
  `kpi_cnt_cst_risk5_gz` decimal(15,0) DEFAULT NULL COMMENT '关注类贷款客户数',
  `kpi_cnt_cst_risk5_cj` decimal(15,0) DEFAULT NULL COMMENT '次级类贷款客户数',
  `kpi_cnt_cst_risk5_ky` decimal(15,0) DEFAULT NULL COMMENT '可疑类贷款客户数',
  `kpi_cnt_cst_risk5_ss` decimal(15,0) DEFAULT NULL COMMENT '损失类贷款客户数',
  `kpi_amt_cst_bf_m2_up` decimal(18,2) DEFAULT NULL COMMENT 'M2+贷款本金',
  `kpi_cnt_cst_bf_m2_up` decimal(15,0) DEFAULT NULL COMMENT 'M2+贷款客户数',
  `kpi_amt_cst_npl_bf` decimal(18,2) DEFAULT NULL COMMENT '不良贷款本金',
  `kpi_cnt_cst_npl_bf` decimal(15,0) DEFAULT NULL COMMENT '不良贷款客户数',
  `kpi_cnt_apm_aprv_cur` decimal(15,0) DEFAULT NULL COMMENT '当日发卡量',
  `kpi_amt_cst_pym_cur` decimal(18,2) DEFAULT NULL COMMENT '当日还款金额',
  `kpi_amt_cst_rtl_out` decimal(18,2) DEFAULT NULL COMMENT '境外消费金额',
  `kpi_cnt_rtl_out` decimal(15,0) DEFAULT NULL COMMENT '境外消费笔数',
  `kpi_amt_cst_cash_out` decimal(18,2) DEFAULT NULL COMMENT '境外取现金额',
  `kpi_cnt_cash_out` decimal(15,0) DEFAULT NULL COMMENT '境外取现笔数',
  `kpi_cnt_act_open_due` decimal(15,0) DEFAULT NULL COMMENT '开户及逾期账户数',
  `kpi_cnt_rtl_act_susp_rsk` decimal(15,0) DEFAULT NULL COMMENT '疑是风险账户数',
  `kpi_amt_rtl_act_susp_frd` decimal(18,2) DEFAULT NULL COMMENT '疑是欺诈金额',
  `kpi_amt_act_open_6m_m2_up` decimal(18,2) DEFAULT NULL COMMENT '发卡后第七个月为M2+金额',
  `kpi_cnt_act_open_6m_m2_up` decimal(15,0) DEFAULT NULL COMMENT '发卡后第七个月为M2+户数',
  `kpi_cnt_cst_susp_de_warn` decimal(15,0) DEFAULT NULL COMMENT '疑是大二报警户数',
  `kpi_cnt_cst_act_30d` decimal(15,0) DEFAULT NULL COMMENT '30天活跃客户数',
  `kpi_cnt_cst_act_60d` decimal(15,0) DEFAULT NULL COMMENT '60天活跃客户数',
  `kpi_cnt_cst_act_90d` decimal(15,0) DEFAULT NULL COMMENT '90天活跃客户数',
  `kpi_cnt_cst_cif` decimal(15,0) DEFAULT NULL COMMENT '有效客户数',
  `kpi_cnt_cst_int` decimal(15,0) DEFAULT NULL COMMENT '生息客户数',
  `kpi_cnt_cst` decimal(15,0) DEFAULT NULL COMMENT '总客户数',
  `kpi_amt_act_bf_open_6m` decimal(18,2) DEFAULT NULL COMMENT '账龄为6个月的账户贷款本金',
  `kpi_amt_cst_bf_m1_mtd` decimal(18,2) DEFAULT NULL COMMENT '当月新增M1贷款本金',
  `kpi_amt_cst_npl_bf_ytd` decimal(18,2) DEFAULT NULL COMMENT '当年新增不良贷款本金',
  `kpi_amt_cst_cash_limit` decimal(18,2) DEFAULT NULL COMMENT '现金授信额度',
  `kpi_amt_cst_avail_cash` decimal(18,2) DEFAULT NULL COMMENT '可用现金额度',
  `kpi_cnt_cst_cif_cashout` decimal(15,0) DEFAULT NULL COMMENT '有效套现客户数',
  `kpi_cnt_cst_yf_grw_6m` decimal(15,0) DEFAULT NULL COMMENT '近6期贷款金额持续增长客户数',
  `kpi_cnt_cst_bf_grw_4m` decimal(15,0) DEFAULT NULL COMMENT '近4期贷款本金持续增长客户数',
  `kpi_cnt_cst_vntage_ge_6m` decimal(15,0) DEFAULT NULL COMMENT '账龄大于等于6个月客户数',
  `kpi_cnt_cst_actn_src_dwn_m` decimal(15,0) DEFAULT NULL COMMENT '月度行为评分等级下降客户数',
  `kpi_cnt_cst_actn_src_dwn_q` decimal(15,0) DEFAULT NULL COMMENT '季度行为评分等级下降客户数',
  `kpi_cnt_cst_yf` decimal(15,0) DEFAULT NULL COMMENT '余额大于0客户数',
  `kpi_amt_cst_cc` decimal(18,2) DEFAULT NULL COMMENT '超存金额(不含核销)',
  `kpi_cnt_cst_cc` decimal(15,0) DEFAULT NULL COMMENT '超存客户数',
  `kpi_amt_cst_bf_m0_lst_lm` decimal(18,2) DEFAULT NULL COMMENT '上月M0金额(本金含OPS)',
  `kpi_amt_cst_bf_m1_lst_lm` decimal(18,2) DEFAULT NULL COMMENT '上月M1金额(本金含OPS)',
  `kpi_amt_cst_bf_m2_lst_lm` decimal(18,2) DEFAULT NULL COMMENT '上月M2金额(本金含OPS)',
  `kpi_amt_cst_bf_m3_lst_lm` decimal(18,2) DEFAULT NULL COMMENT '上月M3金额(本金含OPS)',
  `kpi_amt_cst_bf_m4_lst_lm` decimal(18,2) DEFAULT NULL COMMENT '上月M4金额(本金含OPS)',
  `kpi_amt_cst_bf_m5_lst_lm` decimal(18,2) DEFAULT NULL COMMENT '上月M5金额(本金含OPS)',
  `kpi_amt_cst_bf_m6_lst_lm` decimal(18,2) DEFAULT NULL COMMENT '上月M6金额(本金含OPS)',
  `kpi_amt_cst_bf_m7_lst_lm` decimal(18,2) DEFAULT NULL COMMENT '上月M7金额(本金含OPS)',
  `kpi_amt_cst_bf_m8_lst_lm` decimal(18,2) DEFAULT NULL COMMENT '上月M8金额(本金含OPS)',
  `kpi_amt_cst_bf_mh_lst_lm` decimal(18,2) DEFAULT NULL COMMENT '上月历史挂账金额(本金含OPS))S)',
  `kpi_amt_cst_bf_hx_lst_lm` decimal(18,2) DEFAULT NULL COMMENT '上月核销金额(本金含OPS)',
  `kpi_cnt_act_main_lst_1m` decimal(15,0) DEFAULT NULL COMMENT '上月当月新增主账户数',
  `kpi_cnt_act_main_lst_2m` decimal(15,0) DEFAULT NULL COMMENT '2个月前当月新增主账户数',
  `kpi_cnt_act_main_lst_5m` decimal(15,0) DEFAULT NULL COMMENT '5个月前当月新增主账户数',
  `kpi_cnt_act_main_lst_6m` decimal(15,0) DEFAULT NULL COMMENT '6个月前当月新增主账户数',
  `kpi_amt_cst_bf_hx_ytd` decimal(18,2) DEFAULT NULL COMMENT '当年核销账户贷款本金',
  `kpi_amt_cst_bf_hx_mtd` decimal(18,2) DEFAULT NULL COMMENT '当月核销账户贷款本金',
  `kpi_cnt_cst_bf_m0` decimal(15,0) DEFAULT NULL COMMENT 'M0客户数',
  `kpi_cnt_cst_bf_m1` decimal(15,0) DEFAULT NULL COMMENT 'M1客户数',
  `kpi_cnt_cst_bf_m2` decimal(15,0) DEFAULT NULL COMMENT 'M2客户数',
  `kpi_cnt_cst_bf_m3` decimal(15,0) DEFAULT NULL COMMENT 'M3客户数',
  `kpi_cnt_cst_bf_m4` decimal(15,0) DEFAULT NULL COMMENT 'M4客户数',
  `kpi_cnt_cst_bf_m5` decimal(15,0) DEFAULT NULL COMMENT 'M5客户数',
  `kpi_cnt_cst_bf_m6` decimal(15,0) DEFAULT NULL COMMENT 'M6客户数',
  `kpi_cnt_cst_bf_m7_up` decimal(15,0) DEFAULT NULL COMMENT 'M7+客户数',
  `kpi_cnt_cst_bf_hx_mtd` decimal(15,0) DEFAULT NULL COMMENT '当月核销客户数',
  `kpi_cnt_cst_bf_m0_lst_lm` decimal(15,0) DEFAULT NULL COMMENT '上月0客户数',
  `kpi_cnt_cst_bf_m1_lst_lm` decimal(15,0) DEFAULT NULL COMMENT '上月1客户数',
  `kpi_cnt_cst_bf_m2_lst_lm` decimal(15,0) DEFAULT NULL COMMENT '上月2客户数',
  `kpi_cnt_cst_bf_m3_lst_lm` decimal(15,0) DEFAULT NULL COMMENT '上月3客户数',
  `kpi_cnt_cst_bf_m4_lst_lm` decimal(15,0) DEFAULT NULL COMMENT '上月4客户数',
  `kpi_cnt_cst_bf_m5_lst_lm` decimal(15,0) DEFAULT NULL COMMENT '上月5客户数',
  `kpi_cnt_cst_bf_m6_lst_lm` decimal(15,0) DEFAULT NULL COMMENT '上月6客户数',
  `kpi_cnt_cst_bf_m7_up_lst_lm` decimal(15,0) DEFAULT NULL COMMENT '上月7+客户数',
  `kpi_cnt_cst_bf_m1_up` decimal(15,0) DEFAULT NULL COMMENT 'M1+客户数',
  `kpi_amt_cst_bf_m1_up` decimal(18,2) DEFAULT NULL COMMENT 'M1+贷款本金',
  `kpi_cnt_cst_bf_m4_up` decimal(15,0) DEFAULT NULL COMMENT 'M4+客户数',
  `kpi_amt_cst_bf_m4_up` decimal(18,2) DEFAULT NULL COMMENT 'M4+贷款本金',
  `kpi_amt_cst_bf_m7_up` decimal(18,2) DEFAULT NULL COMMENT 'M7+贷款本金',
  `dw_etl_date` varchar(20) DEFAULT NULL COMMENT '数据日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='风险维度监控指标维度整合层多维分析表'












DROP TABLE IF EXISTS DEFAULT.KYLIN_CAL_DT;

CREATE TABLE DEFAULT.KYLIN_CAL_DT
(
CAL_DT date
,YEAR_BEG_DT date
,QTR_BEG_DT date
,MONTH_BEG_DT date
,WEEK_BEG_DT date
,AGE_FOR_YEAR_ID smallint
,AGE_FOR_QTR_ID smallint
,AGE_FOR_MONTH_ID smallint
,AGE_FOR_WEEK_ID smallint
,AGE_FOR_DT_ID smallint
,AGE_FOR_RTL_YEAR_ID smallint
,AGE_FOR_RTL_QTR_ID smallint
,AGE_FOR_RTL_MONTH_ID smallint
,AGE_FOR_RTL_WEEK_ID smallint
,AGE_FOR_CS_WEEK_ID smallint
,DAY_OF_CAL_ID int
,DAY_OF_YEAR_ID smallint
,DAY_OF_QTR_ID smallint
,DAY_OF_MONTH_ID smallint
,DAY_OF_WEEK_ID int
,WEEK_OF_YEAR_ID tinyint
,WEEK_OF_CAL_ID int
,MONTH_OF_QTR_ID tinyint
,MONTH_OF_YEAR_ID tinyint
,MONTH_OF_CAL_ID smallint
,QTR_OF_YEAR_ID tinyint
,QTR_OF_CAL_ID smallint
,YEAR_OF_CAL_ID smallint
,YEAR_END_DT string
,QTR_END_DT string
,MONTH_END_DT string
,WEEK_END_DT string
,CAL_DT_NAME string
,CAL_DT_DESC string
,CAL_DT_SHORT_NAME string
,YTD_YN_ID tinyint
,QTD_YN_ID tinyint
,MTD_YN_ID tinyint
,WTD_YN_ID tinyint
,SEASON_BEG_DT string
,DAY_IN_YEAR_COUNT smallint
,DAY_IN_QTR_COUNT tinyint
,DAY_IN_MONTH_COUNT tinyint
,DAY_IN_WEEK_COUNT tinyint
,RTL_YEAR_BEG_DT string
,RTL_QTR_BEG_DT string
,RTL_MONTH_BEG_DT string
,RTL_WEEK_BEG_DT string
,CS_WEEK_BEG_DT string
,CAL_DATE string
,DAY_OF_WEEK string
,MONTH_ID string
,PRD_DESC string
,PRD_FLAG string
,PRD_ID string
,PRD_IND string
,QTR_DESC string
,QTR_ID string
,QTR_IND string
,RETAIL_WEEK string
,RETAIL_YEAR string
,RETAIL_START_DATE string
,RETAIL_WK_END_DATE string
,WEEK_IND string
,WEEK_NUM_DESC string
,WEEK_BEG_DATE string
,WEEK_END_DATE string
,WEEK_IN_YEAR_ID string
,WEEK_ID string
,WEEK_BEG_END_DESC_MDY string
,WEEK_BEG_END_DESC_MD string
,YEAR_ID string
,YEAR_IND string
,CAL_DT_MNS_1YEAR_DT string
,CAL_DT_MNS_2YEAR_DT string
,CAL_DT_MNS_1QTR_DT string
,CAL_DT_MNS_2QTR_DT string
,CAL_DT_MNS_1MONTH_DT string
,CAL_DT_MNS_2MONTH_DT string
,CAL_DT_MNS_1WEEK_DT string
,CAL_DT_MNS_2WEEK_DT string
,CURR_CAL_DT_MNS_1YEAR_YN_ID tinyint
,CURR_CAL_DT_MNS_2YEAR_YN_ID tinyint
,CURR_CAL_DT_MNS_1QTR_YN_ID tinyint
,CURR_CAL_DT_MNS_2QTR_YN_ID tinyint
,CURR_CAL_DT_MNS_1MONTH_YN_ID tinyint
,CURR_CAL_DT_MNS_2MONTH_YN_ID tinyint
,CURR_CAL_DT_MNS_1WEEK_YN_IND tinyint
,CURR_CAL_DT_MNS_2WEEK_YN_IND tinyint
,RTL_MONTH_OF_RTL_YEAR_ID string
,RTL_QTR_OF_RTL_YEAR_ID tinyint
,RTL_WEEK_OF_RTL_YEAR_ID tinyint
,SEASON_OF_YEAR_ID tinyint
,YTM_YN_ID tinyint
,YTQ_YN_ID tinyint
,YTW_YN_ID tinyint
,CRE_DATE string
,CRE_USER string
,UPD_DATE string
,UPD_USER string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

DROP TABLE IF EXISTS DEFAULT.KYLIN_CATEGORY_GROUPINGS;

CREATE TABLE DEFAULT.KYLIN_CATEGORY_GROUPINGS
(
LEAF_CATEG_ID bigint
,LEAF_CATEG_NAME string
,SITE_ID int
,CATEG_BUSN_MGR string
,CATEG_BUSN_UNIT string
,REGN_CATEG string
,USER_DEFINED_FIELD1 string
,USER_DEFINED_FIELD3 string
,CRE_DATE string
,UPD_DATE string
,CRE_USER string
,UPD_USER string
,META_CATEG_ID decimal
,META_CATEG_NAME string
,CATEG_LVL2_ID decimal
,CATEG_LVL3_ID decimal
,CATEG_LVL4_ID decimal
,CATEG_LVL5_ID decimal
,CATEG_LVL6_ID decimal
,CATEG_LVL7_ID decimal
,CATEG_LVL2_NAME string
,CATEG_LVL3_NAME string
,CATEG_LVL4_NAME string
,CATEG_LVL5_NAME string
,CATEG_LVL6_NAME string
,CATEG_LVL7_NAME string
,CATEG_FLAGS decimal
,ADULT_CATEG_YN string
,DOMAIN_ID decimal
,USER_DEFINED_FIELD5 string
,VCS_ID decimal
,GCS_ID decimal
,MOVE_TO decimal
,SAP_CATEGORY_ID decimal
,SRC_ID tinyint
,BSNS_VRTCL_NAME string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

DROP TABLE IF EXISTS DEFAULT.KYLIN_SALES;

CREATE TABLE DEFAULT.KYLIN_SALES
(
TRANS_ID bigint
,PART_DT date
,LSTG_FORMAT_NAME string
,LEAF_CATEG_ID bigint
,LSTG_SITE_ID int
,SLR_SEGMENT_CD smallint
,PRICE decimal(19,4)
,ITEM_COUNT bigint
,SELLER_ID bigint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH 'DEFAULT.KYLIN_SALES.csv' OVERWRITE INTO TABLE DEFAULT.KYLIN_SALES;
LOAD DATA LOCAL INPATH 'DEFAULT.KYLIN_CAL_DT.csv' OVERWRITE INTO TABLE DEFAULT.KYLIN_CAL_DT;
LOAD DATA LOCAL INPATH 'DEFAULT.KYLIN_CATEGORY_GROUPINGS.csv' OVERWRITE INTO TABLE DEFAULT.KYLIN_CATEGORY_GROUPINGS;

# Connection failed: [Errno 111] Connection refused to 0.0.0.0:6188

Ambari Metrics  /  n01.kylin.hdp

后来自己好了。可能跟主机运行情况有关。例如：存储占用，网络，内存占用等等。


# ambari web :  User: root is not allowed to impersonate admin

HDFS has not been configured for Ambari as a proxy user. Refer to Setup HDFS Proxy User.

https://docs.hortonworks.com/HDPDocuments/Ambari-2.1.2.0/bk_ambari_views_guide/content/_setup_HDFS_proxy_user.html

未解决。






# kylin 

## Exception: Non-standard token 'NaN': enable JsonParser.Feature.ALLOW_NON_NUMERIC_NUMBERS to allow
 at [Source: java.io.StringReader@e0190f; line: 1, column: 520]


## #10 Step Name: Build N-Dimension Cuboid Data : 43-Dimension


Exception: Non-standard token 'NaN': enable JsonParser.Feature.ALLOW_NON_NUMERIC_NUMBERS to allow
 at [Source: java.io.StringReader@36c803ee; line: 1, column: 519]

## hdfs 清理

使用 hdfs账号操作：

KYLIN_HOME=/opt/apache-kylin-1.3-HBase-1.1-SNAPSHOT-bin
hbase org.apache.hadoop.util.RunJar ${KYLIN_HOME}/lib/kylin-job-1.3-SNAPSHOT.jar org.apache.kylin.job.hadoop.cube.StorageCleanupJob --delete true







# hadoop fs 
[hdfs@n01 hadoop]$ hadoop fs -du sh /kylin/ /user /tmp/ /mr-history  /mapred /hdp /ats /apps /app-logs


# hadoop fs 
[hdfs@n01 hadoop]$ hadoop fs -rm -r /kylin/kylin_metadata/kylin-174a883c-7817-49da-80cd-fee6d78313b6
16/02/01 10:16:22 INFO fs.TrashPolicyDefault: Namenode trash configuration: Deletion interval = 360 minutes, Emptier interval = 0 minutes.
Moved: 'hdfs://n01.kylin.hdp:8020/kylin/kylin_metadata/kylin-174a883c-7817-49da-80cd-fee6d78313b6' to trash at: hdfs://n01.kylin.hdp:8020/user/hdfs/.Trash/Current




# hadoop fs 

[hdfs@n01 hadoop]$ hadoop fs -du -h /
5.1 M    /app-logs
10.7 G   /apps
3.7 M    /ats
443.0 M  /hdp
5.5 M    /kylin
0        /mapred
17.8 M   /mr-history
570.9 K  /tmp
8.4 G    /user
[hdfs@n01 hadoop]$ hadoop fs -du -h /user
95.5 K  /user/ambari-qa
0       /user/hcat
8.4 G   /user/hdfs
19.8 M  /user/hive
[hdfs@n01 hadoop]$ hadoop fs -du -h /user/hdfs
8.3 G   /user/hdfs/.Trash
19.8 M  /user/hdfs/.hiveJars
79.7 M  /user/hdfs/.staging
[hdfs@n01 hadoop]$ hadoop fs -du -h /user/hdfs/.Trash
8.3 G  /user/hdfs/.Trash/Current
[hdfs@n01 hadoop]$ hadoop fs -expunge
16/02/01 10:56:33 INFO fs.TrashPolicyDefault: Namenode trash configuration: Deletion interval = 360 minutes, Emptier interval = 0 minutes.
16/02/01 10:56:33 INFO fs.TrashPolicyDefault: Created trash checkpoint: /user/hdfs/.Trash/160201105633
[hdfs@n01 hadoop]$ hadoop fs -du -h /user/hdfs/.Trash
8.3 G  /user/hdfs/.Trash/160201105633
[hdfs@n01 hadoop]$ 



[hdfs@n01 hadoop]$ hdfs dfsadmin -report
Configured Capacity: 133661270016 (124.48 GB)
Present Capacity: 104527372540 (97.35 GB)
DFS Remaining: 49782731004 (46.36 GB)
DFS Used: 54744641536 (50.98 GB)
DFS Used%: 52.37%
Under replicated blocks: 42
Blocks with corrupt replicas: 0
Missing blocks: 0
Missing blocks (with replication factor 1): 0

-------------------------------------------------
Live datanodes (3):

Name: 10.0.2.12:50010 (n02.kylin.hdp)
Hostname: n02.kylin.hdp
Decommission Status : Normal
Configured Capacity: 40781819904 (37.98 GB)
DFS Used: 16988676096 (15.82 GB)
Non DFS Used: 9643020204 (8.98 GB)
DFS Remaining: 14150123604 (13.18 GB)
DFS Used%: 41.66%
DFS Remaining%: 34.70%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 6
Last contact: Mon Feb 01 11:07:12 CST 2016


Name: 10.0.2.11:50010 (n01.kylin.hdp)
Hostname: n01.kylin.hdp
Decommission Status : Normal
Configured Capacity: 56260349952 (52.40 GB)
DFS Used: 21258522624 (19.80 GB)
Non DFS Used: 11218243500 (10.45 GB)
DFS Remaining: 23783583828 (22.15 GB)
DFS Used%: 37.79%
DFS Remaining%: 42.27%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 6
Last contact: Mon Feb 01 11:07:12 CST 2016


Name: 10.0.2.13:50010 (n03.kylin.hdp)
Hostname: n03.kylin.hdp
Decommission Status : Normal
Configured Capacity: 36619100160 (34.10 GB)
DFS Used: 16497442816 (15.36 GB)
Non DFS Used: 8272633772 (7.70 GB)
DFS Remaining: 11849023572 (11.04 GB)
DFS Used%: 45.05%
DFS Remaining%: 32.36%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 6
Last contact: Mon Feb 01 11:07:12 CST 2016




# compress hive table hive 表 压缩

http://stackoverflow.com/questions/31867875/setting-compression-on-hive-table


## 创建带压缩的表。

[hdfs@n01 bin]$ hive
WARNING: Use "yarn jar" to launch YARN applications.

Logging initialized using configuration in file:/etc/hive/2.3.4.0-3485/0/hive-log4j.properties
hive> 
    > SET hive.exec.compress.intermediate=true;
    hive> SET hive.exec.compress.output=true;
    hive> SET mapred.output.compression.type=BLOCK;
    hive> show tables;
    OK
    kylin_cal_dt
    kylin_category_groupings
    kylin_intermediate_fullcubetest7alldimandmeasure_clone_19700101000000_2922789940817071255_174a883c_7817_49da_80cd_fee6d78313b6
    kylin_sales
    pmt_kpi_mer_cust_mid_olap
    Time taken: 2.302 seconds, Fetched: 5 row(s)
    hive> 
        > 
            > create table pmt_olap_snappy
                >   stored as orc
                    >   tblproperties ("orc.compress"="SNAPPY")
                        >   as
                            > select * from pmt_kpi_mer_cust_mid_olap ;
                            Query ID = hdfs_20160201124603_10a1ff66-b764-40d8-8659-add33dbbb540
                            Total jobs = 1
                            Launching Job 1 out of 1


                            Status: Running (Executing on YARN cluster with App id application_1454250386966_0019)

                            --------------------------------------------------------------------------------
                                    VERTICES      STATUS  TOTAL  COMPLETED  RUNNING  PENDING  FAILED  KILLED
                                    --------------------------------------------------------------------------------
                                    Map 1                RUNNING     13          0        2       11       0       0
                                    --------------------------------------------------------------------------------
                                    VERTICES: 00/01  [>>--------------------------] 0%    ELAPSED TIME: 189.63 s   
                                    --------------------------------------------------------------------------------




# 为什么kylin 使用 hive 作为输入数据存储， 使用 hbase作为输出数据存储？

因为 hive 可以通过sql方式存储分布式数据，进行分布式计算。可以并行。

而采用hbase 存储输出数据，是因为hbase是列式存储，适合olap。



# 自律，坚持，耐心

https://www.zhihu.com/question/37167038




==========================
Creating target directory...
==========================

Command start time 2016-02-06 18:12:56

Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password).
SSH command execution finished
host=n04.kylin.hdp, exitcode=255
Command end time 2016-02-06 18:12:56

ERROR: Bootstrap of host n04.kylin.hdp fails because previous action finished with non-zero exit code (255)
ERROR MESSAGE: Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password).

STDOUT: 
Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password).





# 为什么 ambari.repo 的内容，就算再ambari web 前台修改stack 之后，还是没有变化？


Connection to n04.kylin.hdp closed.
SSH command execution finished
host=n04.kylin.hdp, exitcode=0
Command end time 2016-02-08 15:23:03

==========================
Copying repo file to 'tmp' folder...
==========================

Command start time 2016-02-08 15:23:03

/etc/yum.repos.d/ambari.repo: No such file or directory
scp /etc/yum.repos.d/ambari.repo
host=n04.kylin.hdp, exitcode=1
Command end time 2016-02-08 15:23:03

==========================
Moving file to repo dir...
==========================

Command start time 2016-02-08 15:23:03
mv: cannot stat `/var/lib/ambari-agent/tmp/ambari1454916183.repo': No such file or directory

Connection to n04.kylin.hdp closed.
SSH command execution finished
host=n04.kylin.hdp, exitcode=1
Command end time 2016-02-08 15:23:03

==========================



根据错误日志，有一个复制过程！ 文件要从 n01 复制到 n04 , 所以修改 repo的路径，不能只修改 n04， 还要修改n01！！


# Exception: Couldn't load 'os_family.json' file
新增节点的时候，报这个错误！




==========================
Running setup agent script...
==========================

Command start time 2016-02-08 18:53:19
('', None)
('', None)

Connection to n04.kylin.hdp closed.
SSH command execution finished
host=n04.kylin.hdp, exitcode=255
Command end time 2016-02-08 18:53:24

ERROR: Bootstrap of host n04.kylin.hdp fails because previous action finished with non-zero exit code (255)
ERROR MESSAGE: tcgetattr: Invalid argument
Connection to n04.kylin.hdp closed.

STDOUT: tput: unknown terminal "unknown"
('', None)
('', None)

Connection to n04.kylin.hdp closed.


 raise Fail(err_msg)
 resource_management.core.exceptions.Fail: Execution of '/usr/bin/yum -d 0 -e 0 -y install 'hive_2_3_*'' returned 1. Error Downloading Packages:
   hive_2_3_4_0_3485-1.2.1.2.3.4.0-3485.el6.noarch: failure: hive/hive_2_3_4_0_3485-1.2.1.2.3.4.0-3485.el6.noarch.rpm from local-HDP-2.3.4.0: [Errno 256] No more mirrors to try.

下载失败


# 如何查看hadoop 集群中各个节点 的运行日志

[root@n01 ~]# find / -name "*n0*log"
/var/log/hadoop/hdfs/hadoop-hdfs-namenode-n01.kylin.hdp.log
/var/log/hadoop/hdfs/hadoop-hdfs-datanode-n01.kylin.hdp.log
/var/log/ambari-metrics-collector/hbase-ams-master-n01.kylin.hdp.log
/var/log/ambari-metrics-collector/hbase-root-master-n01.kylin.hdp.log
/var/log/hbase/hbase-hbase-master-n01.kylin.hdp.log
/var/log/hbase/hbase-hbase-regionserver-n01.kylin.hdp.log
/var/log/hadoop-yarn/yarn/yarn-yarn-nodemanager-n01.kylin.hdp.log
[root@n01 ~]# ssh n02.kylin.hdp 'find / -name "*n0*log"'
/var/log/hadoop/hdfs/hadoop-hdfs-secondarynamenode-n02.kylin.hdp.log
/var/log/hadoop/hdfs/hadoop-hdfs-datanode-n02.kylin.hdp.log
/var/log/hadoop-yarn/yarn/yarn-yarn-timelineserver-n02.kylin.hdp.log
/var/log/hadoop-yarn/yarn/yarn-yarn-resourcemanager-n02.kylin.hdp.log
/var/log/hadoop-mapreduce/mapred/mapred-mapred-historyserver-n02.kylin.hdp.log
[root@n01 ~]# ssh n03.kylin.hdp 'find / -name "*n0*log"'
/var/log/hadoop/hdfs/hadoop-hdfs-datanode-n03.kylin.hdp.log
[root@n01 ~]# ssh n04.kylin.hdp 'find / -name "*n0*log"'
/var/log/hadoop/hdfs/hadoop-hdfs-datanode-n04.kylin.hdp.log
/var/log/hadoop/hdfs/hadoop-hdfs-datanode-n03.kylin.hdp.log
/var/log/hadoop/root/hadoop-hdfs-nfs3-n04.kylin.hdp.log
/var/log/hbase/hbase-hbase-regionserver-n04.kylin.hdp.log
/var/log/hadoop-yarn/yarn/yarn-yarn-nodemanager-n04.kylin.hdp.log



# 如何解决节点冲突

n03 和 n04 冲突！ 因为 n04 是从 n03 复制过来的。



# 如何高效利用阿里云计算？


#  hdfs  命令

sudo -u hdfs hdfs dfsadmin -report -dead 

# 博客推荐  http://bradhedlund.com/about/


# calculated column


# 添加节点n04 不显示 live 的原因

[root@n04 ~]# find / -name "*.xml" | xargs grep -i n03
/etc/hadoop/2.3.4.0-3485/0/yarn-site.xml:      <value>n02.kylin.hdp:2181,n03.kylin.hdp:2181,n01.kylin.hdp:2181</value>
/etc/hadoop/2.3.4.0-3485/0/yarn-site.xml:      <value>n02.kylin.hdp:2181,n03.kylin.hdp:2181,n01.kylin.hdp:2181</value>
/etc/hive/conf.backup/hive-site.xml:      <value>n02.kylin.hdp:2181,n03.kylin.hdp:2181,n01.kylin.hdp:2181</value>
/etc/hive/conf.backup/hive-site.xml:      <value>n02.kylin.hdp:2181,n03.kylin.hdp:2181,n01.kylin.hdp:2181</value>
/etc/hive/2.3.4.0-3485/0/hive-site.xml:      <value>n02.kylin.hdp:2181,n03.kylin.hdp:2181,n01.kylin.hdp:2181</value>
/etc/hive/2.3.4.0-3485/0/hive-site.xml:      <value>n02.kylin.hdp:2181,n03.kylin.hdp:2181,n01.kylin.hdp:2181</value>
/etc/hbase/conf.backup/hbase-site.xml:      <value>n02.kylin.hdp,n03.kylin.hdp,n01.kylin.hdp</value>
/etc/hbase/2.3.4.0-3485/0/hbase-site.xml:      <value>n02.kylin.hdp,n03.kylin.hdp,n01.kylin.hdp</value>
/usr/share/foomatic/db/source/printer/DEC-LN03.xml:<printer id="printer/DEC-LN03">
/usr/share/foomatic/db/source/printer/DEC-LN03.xml:  <model>LN03</model>
/usr/share/foomatic/db/source/printer/DEC-LN03.xml:  <driver>ln03</driver>
/usr/share/foomatic/db/source/opt/2.xml:      <driver>ln03</driver>
/usr/share/foomatic/db/source/driver/ln03.xml:<driver id="driver/ln03">
/usr/share/foomatic/db/source/driver/ln03.xml: <name>ln03</name>
/usr/share/foomatic/db/source/driver/ln03.xml:  <prototype>gs -q -dBATCH -dPARANOIDSAFER -dQUIET -dNOPAUSE -sDEVICE=ln03%A%Z -sOutputFile=- -</prototype>
/usr/share/foomatic/db/source/driver/ln03.xml:   <id>printer/DEC-LN03</id><!-- DEC LN03 -->
[root@n04 ~]# find / -name "*.xml" | xargs grep -i n04



# CHANGE namenode 

Manual commands
Copy the contents of /hadoop/hdfs/namenode on the source host n01.kylin.hdp to /hadoop/hdfs/namenode on the target host n04.kylin.hdp.
Login to the target host n04.kylin.hdp and change permissions for the NameNode dirs by running:
chown -R hdfs:hadoop /hadoop/hdfs/namenode
Create marker directory by running:
mkdir -p /var/lib/hdfs/namenode/formatted


# 解决ambari namenode 不能 move 的问题

1. 修改 web 前台 stack version 的 http repo 地址 , 这个地址影响的是 /etc/yum.repos.d/HDP*repo 文件。

2. 修改 后台 /etc/yum.repos.d/ 地址。

3. 不仅仅是 n01 要改，其他节点也可能要改。

4. 节点移动中出现的问题：

4.1. http 连接不上的情况： 重启 ambari server / agent 

4.2. 重启服务检查失败：不断重试！

# 节点添加遇到的问题

1. 节点添加，可以检测到datanode ， 但是不是alive

2. 由于我添加节点是基于上一个节点的虚拟机添加的，很可能有配置冲突或者缺失的问题。



# 全新添加节点需要做的事情：






# 全新添加节点需要做的事情：


1. 调通网络

2. 复制配置

3. 修改配置 

# exception: 

/usr/hdp/current/hadoop-hdfs-namenode/bin/hdfs dfsadmin -fs hdfs://n01.kylin.hdp:8020 -safemode get
safemode: Call From n01.kylin.hdp/10.0.2.11 to n01.kylin.hdp:8020 failed on connection exception: java.net.ConnectException: Connection refused; For more details see:  http://wiki.apache.org/hadoop/ConnectionRefused

/usr/hdp/current/hadoop-hdfs-namenode/bin/hdfs dfsadmin -fs hdfs://n01.kylin.hdp:8020 -safemode get
safemode: Call From 8020 failed on connection exception: java.net.ConnectException: Connection refused; For more details see:  http://wiki.apache.org/hadoop/ConnectionRefused


# 
Python script has been killed due to timeout after waiting 300 secs

2016-02-16 17:20:46,757 ERROR [main] client.AsyncProcess: Failed to get region location 



/usr/hdp/current/hbase-client/bin/hbase --config /usr/hdp/current/hbase-client/conf shell /var/lib/ambari-agent/tmp/hbase-smoke.sh && /var/lib/ambari-agent/tmp/hbaseSmokeVerify.sh /usr/hdp/current/hbase-client/conf id000a0e02_date311616 /usr/hdp/current/hbase-client/bin/hbase



# namenode 安装问题解决：

## 背景

更改了namenode所在的节点

## 问题：

报 8020 n01 端口 connection refused 

## 解决： 


把hbase.site.xml 中的 n01 改成n02 : 

<property>
      <name>hbase.rootdir</name>
      <value>hdfs://n02.kylin.hdp:8020/apps/hbase/data</value>
    </property>




2016-02-17 00:12:50,157 INFO  [n01:16000.activeMasterManager] zookeeper.MetaTableLocator: Failed verification of hbase:meta,,1 at address=n01.kylin.hdp,16020,1455635936835, exception=org.apache.hadoop.hbase.NotServingRegionException: Region hbase:meta,,1 is not online on n01.kylin.hdp,16020,1455639158319



java.net.ConnectException: Call From n01.kylin.hdp/10.0.2.11 to n01.kylin.hdp:8020 failed on connection exception: java.net.ConnectException: Connection refused; For more details see:  http://wiki.apache.org/hadoop/ConnectionRefused




[root@n02 ~]# find / -name "*.xml" | xargs grep -i "n01\.kylin\.hdp\:8020"
/etc/hadoop/conf.backup/core-site.xml:      <value>hdfs://n01.kylin.hdp:8020</value>
/etc/hbase/conf.backup/core-site.xml:      <value>hdfs://n01.kylin.hdp:8020</value>
/etc/hbase/conf.backup/hdfs-site.xml:      <value>n01.kylin.hdp:8020</value>
/etc/hbase/conf.backup/hbase-site.xml:      <value>hdfs://n01.kylin.hdp:8020/apps/hbase/data</value>


2016-02-17 00:29:54,754 ERROR [RS_OPEN_REGION-n01:16020-1] coprocessor.CoprocessorHost: The coprocessor org.apache.kylin.storage.hbase.coprocessor.endpoint.IIEndpoint threw java.net.ConnectException: Call From n01.kylin.hdp/10.0.2.11 to n01.kylin.hdp:8020 failed on connection exception: java.net.ConnectException: Connection refused; For more details see:  http://wiki.apache.org/hadoop/ConnectionRefused


# 解决hbase 不能启动的问题：

先添加一个 hbase master ， 然后再 删除不能启动的 hbase master 。 

最终发现其实是ntp同步的问题。

# 各节点对时

ssh n01.kylin.hdp date ; ssh n02.kylin.hdp date; ssh n03.kylin.hdp date ; ssh n04.kylin.hdp date


# 

tail: cannot open `/var/log/ambari-agent/ambari-agent.log' for reading: No such file or directory


直接 touch !

# 通过AMBARI 手工添加节点，根本上要解决的是依赖的问题！

1. 数据库依赖 ： postgre 

2. ambari server/agent : 需要手工安装！！

3. 旧的配置需要手工清理！  host cleanup ! 




# 


iTraceback (most recent call last):
  File "/var/lib/ambari-agent/cache/common-services/AMBARI_METRICS/0.1.0/package/scripts/metrics_monitor.py", line 58, in <module>
    AmsMonitor().execute()
  File "/usr/lib/python2.6/site-packages/resource_management/libraries/script/script.py", line 219, in execute
    method(env)
  File "/var/lib/ambari-agent/cache/common-services/AMBARI_METRICS/0.1.0/package/scripts/metrics_monitor.py", line 40, in start
    action = 'start'
  File "/usr/lib/python2.6/site-packages/ambari_commons/os_family_impl.py", line 89, in thunk
    return fn(*args, **kwargs)
  File "/var/lib/ambari-agent/cache/common-services/AMBARI_METRICS/0.1.0/package/scripts/ams_service.py", line 90, in ams_service
    user=params.ams_user
  File "/usr/lib/python2.6/site-packages/resource_management/core/base.py", line 154, in __init__
    self.env.run()
  File "/usr/lib/python2.6/site-packages/resource_management/core/environment.py", line 158, in run
    self.run_action(resource, action)
  File "/usr/lib/python2.6/site-packages/resource_management/core/environment.py", line 121, in run_action
    provider_action()
  File "/usr/lib/python2.6/site-packages/resource_management/core/providers/system.py", line 238, in action_run
    tries=self.resource.tries, try_sleep=self.resource.try_sleep)
  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 70, in inner
    result = function(command, **kwargs)
  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 92, in checked_call
    tries=tries, try_sleep=try_sleep)
  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 140, in _call_wrapper
    result = _call(command, **kwargs_copy)
  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 291, in _call
    raise Fail(err_msg)
resource_management.core.exceptions.Fail: Execution of '/usr/sbin/ambari-metrics-monitor --config /etc/ambari-metrics-monitor/conf/ start' returned 255. psutil build directory is not empty, continuing...
Verifying Python version compatibility...
Using python  /usr/bin/python2.6
Checking for previously running Metric Monitor...
Starting ambari-metrics-monitor
/usr/sbin/ambari-metrics-monitor: line 148: /var/log/ambari-metrics-monitor/ambari-metrics-monitor.out: Permission denied
Verifying ambari-metrics-monitor process status...
ERROR: ambari-metrics-monitor start failed. For more details, see /var/log/ambari-metrics-monitor/ambari-metrics-monitor.out:
====================
2016-02-16 19:38:23,880 [INFO] emitter.py:91 - server: http://n01.kylin.hdp:6188/ws/v1/timeline/metrics
2016-02-16 19:39:23,894 [INFO] emitter.py:91 - server: http://n01.kylin.hdp:6188/ws/v1/timeline/metrics
2016-02-16 19:40:23,906 [INFO] emitter.py:91 - server: http://n01.kylin.hdp:6188/ws/v1/timeline/metrics
2016-02-16 19:41:23,925 [INFO] emitter.py:91 - server: http://n01.kylin.hdp:6188/ws/v1/timeline/metrics
2016-02-16 19:42:23,943 [INFO] emitter.py:91 - server: http://n01.kylin.hdp:6188/ws/v1/timeline/metrics
2016-02-16 19:43:23,958 [INFO] emitter.py:91 - server: http://n01.kylin.hdp:6188/ws/v1/timeline/metrics
2016-02-16 19:44:23,971 [INFO] emitter.py:91 - server: http://n01.kylin.hdp:6188/ws/v1/timeline/metrics
2016-02-16 19:45:23,990 [INFO] emitter.py:91 - server: http://n01.kylin.hdp:6188/ws/v1/timeline/metrics
2016-02-16 19:46:24,002 [INFO] emitter.py:91 - server: http://n01.kylin.hdp:6188/ws/v1/timeline/metrics
2016-02-16 19:47:24,017 [INFO] emitter.py:91 - server: http://n01.kylin.hdp:6188/ws/v1/timeline/metrics
====================
Monitor out at: /var/log/ambari-metrics-monitor/ambari-metrics-monitor.out


## 解决：

[root@n02 ~]# su - ams 
[ams@n02 ~]$ /usr/sbin/ambari-metrics-monitor --config /etc/ambari-metrics-monitor/conf/ start
psutil build directory is not empty, continuing...
Verifying Python version compatibility...
Using python  /usr/bin/python2.6
Checking for previously running Metric Monitor...
/var/run/ambari-metrics-monitor/ambari-metrics-monitor.pid found with no process. Removing 17925...
Starting ambari-metrics-monitor
/usr/sbin/ambari-metrics-monitor: line 148: /var/log/ambari-metrics-monitor/ambari-metrics-monitor.out: Permission denied
Verifying ambari-metrics-monitor process status...
ERROR: ambari-metrics-monitor start failed. For more details, see /var/log/ambari-metrics-monitor/ambari-metrics-monitor.out:
====================
2016-02-23 19:09:06,003 [INFO] host_info.py:291 - hostname_script: None
2016-02-23 19:09:06,016 [INFO] host_info.py:303 - Cached hostname: n02.kylin.hdp
2016-02-23 19:09:06,017 [INFO] controller.py:102 - Adding event to cache, all : {u'metrics': [{u'value_threshold': u'128', u'name': u'bytes_out'}], u'collect_every': u'10'}
2016-02-23 19:09:06,017 [INFO] controller.py:110 - Adding event to cache,  : {u'metrics': [], u'collect_every': u'15'}
2016-02-23 19:09:06,017 [INFO] main.py:65 - Starting Server RPC Thread: /usr/lib/python2.6/site-packages/resource_monitoring/main.py start
2016-02-23 19:09:06,018 [INFO] controller.py:57 - Running Controller thread: Thread-1
2016-02-23 19:09:06,018 [INFO] emitter.py:45 - Running Emitter thread: Thread-2
2016-02-23 19:09:06,019 [INFO] emitter.py:65 - Nothing to emit, resume waiting.
====================
Monitor out at: /var/log/ambari-metrics-monitor/ambari-metrics-monitor.out
[ams@n02 ~]$ ll /var/log/ambari-metrics-monitor/ambari-metrics-monitor.out
-rw-r--r-- 1 zookeeper hadoop 830 Feb 23 19:09 /var/log/ambari-metrics-monitor/ambari-metrics-monitor.out
[ams@n02 ~]$ exit
logout
[root@n02 ~]# ssh n01.kylin.hdp ls -l /var/log/ambari-metrics-monitor/ambari-metrics-monitor.out
-rw-r--r-- 1 ams hadoop 13952 Feb 23 22:35 /var/log/ambari-metrics-monitor/ambari-metrics-monitor.out
[root@n02 ~]# chown ams:hadoop /var/log/ambari-metrics-monitor/ambari-metrics-monitor.out
[root@n02 ~]# su - ams
[ams@n02 ~]$ /usr/sbin/ambari-metrics-monitor --config /etc/ambari-metrics-monitor/conf/ start
psutil build directory is not empty, continuing...
Verifying Python version compatibility...
Using python  /usr/bin/python2.6
Checking for previously running Metric Monitor...
/var/run/ambari-metrics-monitor/ambari-metrics-monitor.pid found with no process. Removing 18072...
Starting ambari-metrics-monitor
Verifying ambari-metrics-monitor process status...
Metric Monitor successfully started
Server log at: /var/log/ambari-metrics-monitor/ambari-metrics-monitor.out



# ambari hbase : connection failed: error 111 connection refused to 16030


http://stackoverflow.com/questions/33866576/connection-issue-when-using-hbase-in-ambari



I have fix this issue. I read the log file in /var/log/hbase/*.log of my region servers ,and find that it's clock is not sync with the master's. So I make all the servers to sync it's clock to the master's using ntpd. Then I restart the ambari components and no alert showed up!!! Think this may help those with the problem.


hbase region server 不能启动的原因： 各节点之间的时间不同步！


# ambari 

./log/ambari-agent/ambari-alerts.log:ERROR 2016-02-18 09:23:27,783 script_alert.py:112 - [Alert][hive_server_process] Failed with result CRITICAL: ['Connection failed on host n02.kylin.hdp:10000 (Traceback (most recent call last):\n  File "/var/lib/ambari-agent/cache/common-services/HIVE/0.12.0.2.0/package/alerts/alert_hive_thrift_port.py", line 192, in execute\n    ssl_keystore=hive_ssl_keystore_path, ssl_password=hive_ssl_keystore_password)\n  File "/usr/lib/python2.6/site-packages/resource_management/libraries/functions/hive_check.py", line 69, in check_thrift_port_sasl\n    timeout=beeline_check_timeout\n  File "/usr/lib/python2.6/site-packages/resource_management/core/base.py", line 154, in __init__\n    self.env.run()\n  File "/usr/lib/python2.6/site-packages/resource_management/core/environment.py", line 158, in run\n    self.run_action(resource, action)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/environment.py", line 121, in run_action\n    provider_action()\n  File "/usr/lib/python2.6/site-packages/resource_management/core/providers/system.py", line 238, in action_run\n    tries=self.resource.tries, try_sleep=self.resource.try_sleep)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 70, in inner\n    result = function(command, **kwargs)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 92, in checked_call\n    tries=tries, try_sleep=try_sleep)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 140, in _call_wrapper\n    result = _call(command, **kwargs_copy)\n  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 291, in _call\n    raise Fail(err_msg)\nFail: Execution of \'! beeline -u \'jdbc:hive2://n02.kylin.hdp:10000/;transportMode=binary\' -e \'\' 2>&1| awk \'{print}\'|grep -i -e \'Connection refused\' -e \'Invalid URL\'\' returned 1. Error: Could not open client transport with JDBC Uri: jdbc:hive2://n02.kylin.hdp:10000/;transportMode=binary: java.net.ConnectException: Connection refused (state=08S01,code=0)\nError: Could not open client transport with JDBC Uri: jdbc:hive2://n02.kylin.hdp:10000/;transportMode=binary: java.net.ConnectException: Connection refused (state=08S01,code=0)\n)']

重启 hiveServer2 即可！



# 平衡hdfs 节点 存储 


[hdfs@n01 bin]$  hadoop balancer 
DEPRECATED: Use of this script to execute hdfs command is deprecated.
Instead use the hdfs command for it.

16/02/18 11:00:01 INFO balancer.Balancer: namenodes  = [hdfs://n01.kylin.hdp:8020]
16/02/18 11:00:01 INFO balancer.Balancer: parameters = Balancer.BalancerParameters [BalancingPolicy.Node, threshold = 10.0, max idle iteration = 5, #excluded nodes = 0, #included nodes = 0, #source nodes = 0, #blockpools = 0, run during upgrade = false]
16/02/18 11:00:01 INFO balancer.Balancer: included nodes = []
16/02/18 11:00:01 INFO balancer.Balancer: excluded nodes = []
16/02/18 11:00:01 INFO balancer.Balancer: source nodes = []
Time Stamp               Iteration#  Bytes Already Moved  Bytes Left To Move  Bytes Being Moved
16/02/18 11:00:04 INFO balancer.KeyManager: Block token params received from NN: update interval=10hrs, 0sec, token lifetime=10hrs, 0sec
16/02/18 11:00:04 INFO block.BlockTokenSecretManager: Setting block keys
16/02/18 11:00:04 INFO balancer.KeyManager: Update block keys every 2hrs, 30mins, 0sec
16/02/18 11:00:05 INFO balancer.Balancer: dfs.balancer.movedWinWidth = 5400000 (default=5400000)
16/02/18 11:00:05 INFO balancer.Balancer: dfs.balancer.moverThreads = 1000 (default=1000)
16/02/18 11:00:05 INFO balancer.Balancer: dfs.balancer.dispatcherThreads = 200 (default=200)
16/02/18 11:00:05 INFO balancer.Balancer: dfs.datanode.balance.max.concurrent.moves = 5 (default=5)
16/02/18 11:00:05 INFO balancer.Balancer: dfs.balancer.getBlocks.size = 2147483648 (default=2147483648)
16/02/18 11:00:05 INFO balancer.Balancer: dfs.balancer.getBlocks.min-block-size = 10485760 (default=10485760)
16/02/18 11:00:05 INFO block.BlockTokenSecretManager: Setting block keys
16/02/18 11:00:05 INFO balancer.Balancer: dfs.balancer.max-size-to-move = 10737418240 (default=10737418240)
16/02/18 11:00:05 INFO balancer.Balancer: dfs.blocksize = 134217728 (default=134217728)
16/02/18 11:00:05 INFO net.NetworkTopology: Adding a new node: /default-rack/10.0.2.13:50010
16/02/18 11:00:05 INFO net.NetworkTopology: Adding a new node: /default-rack/10.0.2.12:50010
16/02/18 11:00:05 INFO net.NetworkTopology: Adding a new node: /default-rack/10.0.2.14:50010
16/02/18 11:00:05 INFO net.NetworkTopology: Adding a new node: /default-rack/10.0.2.11:50010
16/02/18 11:00:05 INFO balancer.Balancer: 0 over-utilized: []
16/02/18 11:00:05 INFO balancer.Balancer: 1 underutilized: [10.0.2.14:50010:DISK]
16/02/18 11:00:05 INFO balancer.Balancer: Need to move 3.29 GB to make the cluster balanced.
16/02/18 11:00:05 INFO balancer.Balancer: chooseStorageGroups for SAME_RACK: overUtilized => underUtilized
16/02/18 11:00:05 INFO balancer.Balancer: chooseStorageGroups for SAME_RACK: overUtilized => belowAvgUtilized
16/02/18 11:00:05 INFO balancer.Balancer: chooseStorageGroups for SAME_RACK: underUtilized => aboveAvgUtilized
16/02/18 11:00:05 INFO balancer.Balancer: Decided to move 475.67 MB bytes from 10.0.2.13:50010:DISK to 10.0.2.14:50010:DISK
16/02/18 11:00:05 INFO balancer.Balancer: Decided to move 3.38 GB bytes from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK
16/02/18 11:00:05 INFO balancer.Balancer: Decided to move 2.86 GB bytes from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK
16/02/18 11:00:05 INFO balancer.Balancer: chooseStorageGroups for ANY_OTHER: overUtilized => underUtilized
16/02/18 11:00:05 INFO balancer.Balancer: chooseStorageGroups for ANY_OTHER: overUtilized => belowAvgUtilized
16/02/18 11:00:05 INFO balancer.Balancer: chooseStorageGroups for ANY_OTHER: underUtilized => aboveAvgUtilized
16/02/18 11:00:05 INFO balancer.Balancer: Will move 6.70 GB in this iteration
16/02/18 11:00:05 INFO balancer.Dispatcher: Start moving blk_1073749664_8879 with size=72614176 from 10.0.2.13:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.11:50010
16/02/18 11:00:05 INFO balancer.Dispatcher: Start moving blk_1073749404_8619 with size=91326717 from 10.0.2.13:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.11:50010
16/02/18 11:00:05 INFO balancer.Dispatcher: Start moving blk_1073749339_8554 with size=21432503 from 10.0.2.13:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.11:50010
16/02/18 11:00:05 INFO balancer.Dispatcher: Start moving blk_1073741826_1002 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:00:05 INFO balancer.Dispatcher: Start moving blk_1073749337_8552 with size=134217728 from 10.0.2.13:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.11:50010
16/02/18 11:00:23 INFO balancer.Dispatcher: Successfully moved blk_1073749339_8554 with size=21432503 from 10.0.2.13:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.11:50010
16/02/18 11:00:23 INFO balancer.Dispatcher: Start moving blk_1073749272_8487 with size=118401068 from 10.0.2.13:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.11:50010
16/02/18 11:01:01 INFO balancer.Dispatcher: Successfully moved blk_1073749664_8879 with size=72614176 from 10.0.2.13:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.11:50010
16/02/18 11:01:01 INFO balancer.Dispatcher: Start moving blk_1073749271_8486 with size=134217728 from 10.0.2.13:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.11:50010
16/02/18 11:01:20 INFO balancer.Dispatcher: Successfully moved blk_1073749404_8619 with size=91326717 from 10.0.2.13:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.11:50010
16/02/18 11:01:20 INFO balancer.Dispatcher: Start moving blk_1073750001_9216 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:01:43 INFO balancer.Dispatcher: Successfully moved blk_1073741826_1002 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:01:43 INFO balancer.Dispatcher: Start moving blk_1073750000_9215 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:01:55 INFO balancer.Dispatcher: Successfully moved blk_1073749337_8552 with size=134217728 from 10.0.2.13:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.11:50010
16/02/18 11:01:55 INFO balancer.Dispatcher: Start moving blk_1073749935_9150 with size=107481476 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:01:58 INFO balancer.Dispatcher: Successfully moved blk_1073749272_8487 with size=118401068 from 10.0.2.13:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.11:50010
16/02/18 11:01:58 INFO balancer.Dispatcher: Start moving blk_1073749934_9149 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:02:51 INFO balancer.Dispatcher: Successfully moved blk_1073749271_8486 with size=134217728 from 10.0.2.13:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.11:50010
16/02/18 11:02:51 INFO balancer.Dispatcher: Start moving blk_1073749933_9148 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:03:07 INFO balancer.Dispatcher: Successfully moved blk_1073750001_9216 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:03:07 INFO balancer.Dispatcher: Start moving blk_1073749932_9147 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:03:17 INFO balancer.Dispatcher: Successfully moved blk_1073749935_9150 with size=107481476 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:03:17 INFO balancer.Dispatcher: Start moving blk_1073749867_9082 with size=40505780 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:03:31 INFO balancer.Dispatcher: Successfully moved blk_1073750000_9215 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:03:31 INFO balancer.Dispatcher: Start moving blk_1073749866_9081 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:03:47 INFO balancer.Dispatcher: Successfully moved blk_1073749934_9149 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:03:47 INFO balancer.Dispatcher: Start moving blk_1073749865_9080 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:03:50 INFO balancer.Dispatcher: Successfully moved blk_1073749867_9082 with size=40505780 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:03:50 INFO balancer.Dispatcher: Start moving blk_1073749864_9079 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:04:37 INFO balancer.Dispatcher: Successfully moved blk_1073749933_9148 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:04:37 INFO balancer.Dispatcher: Start moving blk_1073749863_9078 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:04:51 INFO balancer.Dispatcher: Successfully moved blk_1073749932_9147 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:04:51 INFO balancer.Dispatcher: Start moving blk_1073749798_9013 with size=26737915 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:05:14 INFO balancer.Dispatcher: Successfully moved blk_1073749798_9013 with size=26737915 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:05:14 INFO balancer.Dispatcher: Start moving blk_1073749797_9012 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:05:17 INFO balancer.Dispatcher: Successfully moved blk_1073749866_9081 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:05:17 INFO balancer.Dispatcher: Start moving blk_1073749796_9011 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:05:34 INFO balancer.Dispatcher: Successfully moved blk_1073749864_9079 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:05:34 INFO balancer.Dispatcher: Start moving blk_1073749795_9010 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:05:36 INFO balancer.Dispatcher: Successfully moved blk_1073749865_9080 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:05:36 INFO balancer.Dispatcher: Start moving blk_1073749730_8945 with size=82671416 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:06:21 INFO balancer.Dispatcher: Successfully moved blk_1073749863_9078 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:06:21 INFO balancer.Dispatcher: Start moving blk_1073749729_8944 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:06:50 INFO balancer.Dispatcher: Successfully moved blk_1073749730_8945 with size=82671416 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:06:50 INFO balancer.Dispatcher: Start moving blk_1073741830_1006 with size=98340772 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:07:04 INFO balancer.Dispatcher: Successfully moved blk_1073749796_9011 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:07:04 INFO balancer.Dispatcher: Start moving blk_1073741829_1005 with size=97380893 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:07:06 INFO balancer.Dispatcher: Successfully moved blk_1073749797_9012 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:07:06 INFO balancer.Dispatcher: Start moving blk_1073741828_1004 with size=58504680 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:07:10 INFO balancer.Dispatcher: Successfully moved blk_1073749795_9010 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:07:10 INFO balancer.Dispatcher: Start moving blk_1073741827_1003 with size=75996718 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:07:57 INFO balancer.Dispatcher: Successfully moved blk_1073741828_1004 with size=58504680 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:07:57 INFO balancer.Dispatcher: Start moving blk_1073751012_10242 with size=15830286 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:07 INFO balancer.Dispatcher: Successfully moved blk_1073741830_1006 with size=98340772 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:07 INFO balancer.Dispatcher: Start moving blk_1073748932_8147 with size=14698276 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:07 INFO balancer.Dispatcher: Successfully moved blk_1073749729_8944 with size=134217728 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:07 INFO balancer.Dispatcher: Start moving blk_1073749599_8814 with size=14572978 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:13 INFO balancer.Dispatcher: Successfully moved blk_1073751012_10242 with size=15830286 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:13 INFO balancer.Dispatcher: Start moving blk_1073749469_8684 with size=15730621 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:14 INFO balancer.Dispatcher: Successfully moved blk_1073741827_1003 with size=75996718 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:14 INFO balancer.Dispatcher: Start moving blk_1073748532_7741 with size=98258470 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:19 INFO balancer.Dispatcher: Successfully moved blk_1073748932_8147 with size=14698276 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:19 INFO balancer.Dispatcher: Start moving blk_1073748530_7739 with size=106574765 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:21 INFO balancer.Dispatcher: Successfully moved blk_1073749599_8814 with size=14572978 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:21 INFO balancer.Dispatcher: Start moving blk_1073748529_7738 with size=106793890 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:24 INFO balancer.Dispatcher: Successfully moved blk_1073741829_1005 with size=97380893 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:24 INFO balancer.Dispatcher: Start moving blk_1073748528_7737 with size=268435456 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:25 INFO balancer.Dispatcher: Successfully moved blk_1073749469_8684 with size=15730621 from 10.0.2.11:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:08:25 INFO balancer.Dispatcher: Start moving blk_1073748526_7735 with size=268435456 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:09:34 INFO balancer.Dispatcher: Successfully moved blk_1073748532_7741 with size=98258470 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:09:43 INFO balancer.Dispatcher: Successfully moved blk_1073748530_7739 with size=106574765 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:09:44 INFO balancer.Dispatcher: Successfully moved blk_1073748529_7738 with size=106793890 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:10:37 INFO balancer.Dispatcher: Successfully moved blk_1073748528_7737 with size=268435456 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
16/02/18 11:10:38 INFO balancer.Dispatcher: Successfully moved blk_1073748526_7735 with size=268435456 from 10.0.2.12:50010:DISK to 10.0.2.14:50010:DISK through 10.0.2.12:50010
Feb 18, 2016 11:10:39 AM          0              3.68 GB             3.29 GB            6.70 GB
16/02/18 11:10:48 INFO balancer.Balancer: dfs.balancer.movedWinWidth = 5400000 (default=5400000)
16/02/18 11:10:48 INFO balancer.Balancer: dfs.balancer.moverThreads = 1000 (default=1000)
16/02/18 11:10:48 INFO balancer.Balancer: dfs.balancer.dispatcherThreads = 200 (default=200)
16/02/18 11:10:48 INFO balancer.Balancer: dfs.datanode.balance.max.concurrent.moves = 5 (default=5)
16/02/18 11:10:48 INFO balancer.Balancer: dfs.balancer.getBlocks.size = 2147483648 (default=2147483648)
16/02/18 11:10:48 INFO balancer.Balancer: dfs.balancer.getBlocks.min-block-size = 10485760 (default=10485760)
16/02/18 11:10:48 INFO balancer.Balancer: dfs.balancer.max-size-to-move = 10737418240 (default=10737418240)
16/02/18 11:10:48 INFO balancer.Balancer: dfs.blocksize = 134217728 (default=134217728)
16/02/18 11:10:48 INFO net.NetworkTopology: Adding a new node: /default-rack/10.0.2.11:50010
16/02/18 11:10:48 INFO net.NetworkTopology: Adding a new node: /default-rack/10.0.2.12:50010
16/02/18 11:10:48 INFO net.NetworkTopology: Adding a new node: /default-rack/10.0.2.14:50010
16/02/18 11:10:48 INFO net.NetworkTopology: Adding a new node: /default-rack/10.0.2.13:50010
16/02/18 11:10:48 INFO balancer.Balancer: 0 over-utilized: []
16/02/18 11:10:48 INFO balancer.Balancer: 0 underutilized: []
The cluster is balanced. Exiting...
Feb 18, 2016 11:10:48 AM          1              3.68 GB                 0 B               -1 B
Feb 18, 2016 11:10:48 AM Balancing took 10.783266666666666 minutes



# 使用ambari 添加计算节点的经历

大年初一，在家闲得慌，于是打算为本地vbox 上的hadoop集群尝试增加一个节点，为阿里云节点扩展测试做准备。

## 背景

1. 本地virtualBox 上有一套3个节点(n01,n02,n03)的ambari hadoop 集群环境, 需要添加n04. 
2. 阿里云上有一台单节点的ambari hadoop 集群环境 n01,  需要添加 n02,n03,n04
3. 阿里云按时计费，而我经费有限。所以要在最短的时间内做好节点扩展，花最少的钱做最多的事情。
4. 所以所有的准备工作，我都要在本地virtualBox上做好，把可能出现的异常都排除掉。保证在阿里云上的部署一次性成功完成！


## 过程

1. 新增主机
为了减少新增节点主机的配置，我直接复制了邻近节点的主机镜像
2. 修改ip/mac/hostname 
不能与现有的冲突
3. host cleanup
我一开始没有做hostcleanup ， 而是直接把 ambari server / agent 都卸载了 ， 而还残留了很多配置文件，导致 在 ambari web 上register host的时候失败。
然后我吧 ambari server 和 agent 都装上，register 成功，但是 节点3和节点4（新增节点）冲突，具体表现为：

只要节点3和节点4同时启动，那么hdfs中统计到的：

    DataNodes Status    3 live / 0 dead / 0 decommissioning

只有3个 live ！

但我明明有4个节点起来了啊！

    DataNodes   4/4 Started

也是显示 4个节点启动了！


应该是4个live 才对！

网上说是namenode和新的datanode通信有问题，于是我把namenode移动到新的节点上，问题依旧！

而把namenode移动回来的过程中，又发生了很多异常问题！

1. namenode无法启动 --  hbase.site.xml 中的n0? 错乱，修改之！
2. hbase无法启动 -- 时间不同步
3. region server 无法启动 -- 时间不同步


我先排除了namenode的问题， 打算暂时把 hbase 的问题放一放，先添加节点。

被无法register 的问题折腾了几天之后，我打算把新节点的环境还原到最干净的状态,就连mysql , postgres 都删除了。但是发现报各种目录缺失的异常。于是我就把postgres , ambari server 和 agent 手工装回去。

竟然就注册通过了！

注册通过之后，就好办了。


# 使用ambari为hdp集群添加节点的若干问题

### ambari add host 时，为何不能register 节点？老是报找不目录，文件没有权限之类的问题？返回值不为0 的情况？

如果host来自其他节点的复制，不是全新的host ， 那么需要先做host cleanup。

然后再在新节点上安装ambari server 和 agent 。 

### 如何做host cleanup ?

删除旧的目录，旧的配置文件。删除已经安装了的插件.

注意： ambari server / agent / postgre 可以卸载重组，也可以不卸载，但可能需要reinitialize . 

参考：

http://clarkupdike.blogspot.com/2014/09/resetting-deleting-and-cleaning-out.html

https://cwiki.apache.org/confluence/display/AMBARI/Host+Cleanup+for+Ambari+and+Stack



### host cleanup 的时候，如何批量卸载节点上的组件？

生成列表：

    yum list installed | grep HDP|awk -F" " '{print "yum -erase -y",  $1}'

串行移除：

clean(){
yum erase -y @local-HDP-2.3.4.0
yum erase -y datafu_2_3_4_0_3485.noarch
yum erase -y hadoop_2_3_4_0_3485.x86_64
yum erase -y hadoop_2_3_4_0_3485-client.x86_64
yum erase -y hadoop_2_3_4_0_3485-conf-pseudo.x86_64
yum erase -y hadoop_2_3_4_0_3485-doc.x86_64
yum erase -y hadoop_2_3_4_0_3485-hdfs.x86_64
yum erase -y 2.7.1.2.3.4.0-3485.el6
yum erase -y hadoop_2_3_4_0_3485-hdfs-fuse.x86_64
yum erase -y 2.7.1.2.3.4.0-3485.el6
yum erase -y 2.7.1.2.3.4.0-3485.el6
yum erase -y 2.7.1.2.3.4.0-3485.el6
yum erase -y hadoop_2_3_4_0_3485-hdfs-zkfc.x86_64
yum erase -y 2.7.1.2.3.4.0-3485.el6
yum erase -y hadoop_2_3_4_0_3485-libhdfs.x86_64
yum erase -y hadoop_2_3_4_0_3485-mapreduce.x86_64
yum erase -y 2.7.1.2.3.4.0-3485.el6
yum erase -y hadoop_2_3_4_0_3485-source.x86_64
yum erase -y hadoop_2_3_4_0_3485-yarn.x86_64
yum erase -y 2.7.1.2.3.4.0-3485.el6
yum erase -y 2.7.1.2.3.4.0-3485.el6
yum erase -y 2.7.1.2.3.4.0-3485.el6
yum erase -y 2.7.1.2.3.4.0-3485.el6
yum erase -y hbase_2_3_4_0_3485.noarch
yum erase -y hbase_2_3_4_0_3485-doc.noarch
yum erase -y hbase_2_3_4_0_3485-master.noarch
yum erase -y hbase_2_3_4_0_3485-regionserver.noarch
yum erase -y hbase_2_3_4_0_3485-rest.noarch
yum erase -y hbase_2_3_4_0_3485-thrift.noarch
yum erase -y hbase_2_3_4_0_3485-thrift2.noarch
yum erase -y hdp-select.noarch
yum erase -y hive_2_3_4_0_3485.noarch
yum erase -y hive_2_3_4_0_3485-hcatalog.noarch
yum erase -y 1.2.1.2.3.4.0-3485.el6
yum erase -y hive_2_3_4_0_3485-jdbc.noarch
yum erase -y hive_2_3_4_0_3485-metastore.noarch
yum erase -y hive_2_3_4_0_3485-server.noarch
yum erase -y hive_2_3_4_0_3485-server2.noarch
yum erase -y hive_2_3_4_0_3485-webhcat.noarch
yum erase -y 1.2.1.2.3.4.0-3485.el6
yum erase -y mysql-connector-java.noarch
yum erase -y @local-HDP-2.3.4.0
yum erase -y 0.5.0.2.3.4.0-3485.el6
yum erase -y ranger_2_3_4_0_3485-hdfs-plugin.x86_64
yum erase -y ranger_2_3_4_0_3485-hive-plugin.x86_64
yum erase -y ranger_2_3_4_0_3485-yarn-plugin.x86_64
yum erase -y snappy.x86_64
yum erase -y snappy-devel.x86_64
yum erase -y sqoop_2_3_4_0_3485.noarch
yum erase -y sqoop_2_3_4_0_3485-metastore.noarch
yum erase -y tez_2_3_4_0_3485.noarch
yum erase -y zookeeper_2_3_4_0_3485.noarch
}

执行：
    clean

即可！

### datanode  n04 复制自另外的节点n03，并已经添加成功，但是节点不是live , 为什么？

n04 的配置跟n03 冲突！ 只能识别其中的一个为live！ 这就是对于复制节点要做host cleanup 的原因。

### hdfs  8020  端口 connection refused 如何解决？
确认 hdfs 的 hbase.rootdir 是否配置了正确的节点。

例如，我尝试把hbase.site.xml 中的 n01 改成n02 :

 <property>
      <name>hbase.rootdir</name>
      <value>hdfs://n02.kylin.hdp:8020/apps/hbase/data</value>
 </property>

再做namenode移动的时候，可以通过节点检查。


### 如何查看节点同步情况：

    ssh n01.kylin.hdp date ; ssh n02.kylin.hdp date; ssh n03.kylin.hdp date ; ssh n04.kylin.hdp date

### 如何同步各个节点的时间：

1. 保证ntpd 服务已经安装

2. /etc/init.d/ntpd restart

hbase region server 不能启动的原因可能就是 时间不同步。

###  [Alert][hive_server_process] Failed with result CRITICAL: ['Connection failed on host n     02.kylin.hdp:10000 

重启 hiveServer2 即可！

### 如何平衡hdfs各节点的存储 ？

    hadoop balancer 

命令，可以均衡各个节点上的存储。但注意均衡后也不是绝对平均的！







### 为什么添加节点过程中会报各种异常？

归根结底，是系统中的依赖条件不满足。当然还有配置错误。所以按手册流程来操作就非常重要。



# 通过复制／修改cubename.json 内容，可以构建一个新的cube。

# 通过 rebalance 可以平衡各个节点的存储分布！

# 注册节点的时候遇到的各种问题，都与ambari server/agent 没有安装好, 以及 host 没有 cleanup 有关系！

例如这个：

ERROR 2016-02-16 19:51:48,558 main.py:315 - Fatal exception occurred:
Traceback (most recent call last):
  File "/usr/lib/python2.6/site-packages/ambari_agent/main.py", line 312, in <module>
    main(heartbeat_stop_callback)
  File "/usr/lib/python2.6/site-packages/ambari_agent/main.py", line 248, in main
    stop_agent()
  File "/usr/lib/python2.6/site-packages/ambari_agent/main.py", line 195, in stop_agent
    sys.exit(1)
SystemExit: 1
INFO 2016-02-16 19:51:48,565 ExitHelper.py:53 - Performing cleanup before exiting...
', None)

Connection to n04.kylin.hdp closed.


#ambari  rest api 

[hdfs@n01 ~]$ curl --user admin:admin http://10.0.2.11:8080/api/v1/clusters
{
  "href" : "http://10.0.2.11:8080/api/v1/clusters",
  "items" : [
    {
      "href" : "http://10.0.2.11:8080/api/v1/clusters/kylinCluster",
      "Clusters" : {
        "cluster_name" : "kylinCluster",
        "version" : "HDP-2.3"
      }
    }
  ]
}[hdfs@n01 ~]$ 


# 让数据翻番的方法：
## times2(){      orig_file=$1;   tmp_file=/tmp/$$;    cat $orig_file $orig_file > $tmp_file;   mv $tmp_file $orig_file; }


times2 () 
{ 
    orig_file=$1;
    tmp_file=/tmp/$$;
    cat $orig_file $orig_file > $tmp_file;
    mv $tmp_file $orig_file
}



# Apache Kylin: Intermediate table not found

http://stackoverflow.com/questions/35075276/apache-kylin-intermediate-table-not-found


java.io.IOException: NoSuchObjectException(message:default.kylin_intermediate_kylin_sales_cube_desc_19700101000000_20160101000000_38b1539f_1f69_406d_89ed_96f3ca776841 table not found)



——————hive-site.xml——————————

<property>
  <name>hive.metastore.uris</name>
  <value>thrift://localhost:9083</value>
  <description>Thrift URI for the remote metastore. Used by metastore client to connect to remote metastore.</description>
</property>
——————hive-site.xml——————————

然后启动： nohup hive —service metastore -p 9083 &

http://stackoverflow.com/questions/35075276/apache-kylin-intermediate-table-not-found



