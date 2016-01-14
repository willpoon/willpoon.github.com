Title: 大数据 best practice
Category: Tech
Tags: 大数据,hadoop
Slug: big_data
Authors: Poon

[TOC]

<!-- ^ -->

终于开始写大数据方面的东西了！这可能是关于大数据实践方面写得最详细的，详细里面写得最易懂的！

<!-- $ -->


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

1.5.2. Setting Up a Local Repository


yum -y install yum-utils createrepo


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
