# 安装
> brew install privoxy

# 配置

poon@WMBP:/tmp$ tail /usr/local/etc/privoxy/config
```
forward-socks5   /               127.0.0.1:1080 .
#listen-address  localhost:8118
#local network do not use proxy
forward         192.168.*.*/     .
forward            10.*.*.*/     .
forward           127.*.*.*/     .
```

# 执行
> poon@WMBP:/tmp$ /usr/local/sbin/privoxy

## 报错1：
> 2016-08-29 14:33:04.875 00000130 Fatal error: can't check configuration file '/private/tmp/config':  No such file or directory

## 报错1解决：
> poon@WMBP:/tmp$ cp /usr/local/etc/privoxy/config /private/tmp/config

# 再次执行

poon@WMBP:/tmp$ /usr/local/sbin/privoxy

# 试一下访问google
poon@WMBP:/tmp$ wget www.google.com

没反应。原因是还没有设置terminal 环境变量：设置之：

> poon@WMBP:/tmp$ export http_proxy='http://127.0.0.1:8118'
> poon@WMBP:/tmp$ export https_proxy='http://127.0.0.1:8118'

# 不用wget测试了，换乘 docker 测试：

poon@WMBP:/tmp$ docker search hadoop
NAME                             DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
sequenceiq/hadoop-docker         An easy way to try Hadoop                       351                  [OK]
sequenceiq/hadoop-ubuntu         An easy way to try Hadoop on Ubuntu             34                   [OK]
ruo91/hadoop                     Apache hadoop 2.x - Pseudo-Distributed Mode     12                   [OK]
uhopper/hadoop                   Base Hadoop image with dynamic configurati...   9                    [OK]
gelog/hadoop                     WORK IN PROGRESS. NOT PRODUCTION READY          5                    [OK]
uhopper/hadoop-resourcemanager   Hadoop resourcemanager                          3                    [OK]
athlinks/hadoop                  Distributed Highly Available Hadoop Cluste...   3                    [OK]
dockmob/hadoop                   Docker images for Apache Hadoop (YARN, HDF...   3                    [OK]
uhopper/hadoop-nodemanager       Hadoop nodemanager                              2                    [OK]
uhopper/hadoop-datanode          Hadoop datanode                                 2                    [OK]
uhopper/hadoop-namenode          Hadoop namenode                                 2                    [OK]
lewuathe/hadoop-master           Multiple node hadoop cluster on Docker.         2                    [OK]
mcapitanio/hadoop                Docker image running Hadoop in psedo-distr...   1                    [OK]
harisekhon/hadoop-dev            Apache Hadoop (HDFS + Yarn) + Dev Tools + ...   1                    [OK]
harisekhon/hadoop                Apache Hadoop (HDFS + Yarn, tags 2.5 - 2.7)     1                    [OK]
ading1977/hadoop                 Docker image for multi-node hadoop cluster.     0                    [OK]
qnib/d-hadoop                    QNIBTerminal Image using CDH to install Ha...   0                    [OK]
meteogroup/hadoop                Apache™ Hadoop® in a docker image.              0                    [OK]
actionml/hadoop                  Docker Hadoop container (standalone)            0                    [OK]
julialang/hadoop                 Julia Hadoop Docker Image                       0                    [OK]
takaomag/hadoop                  docker image of archlinux (hadoop)              0                    [OK]
cjongseok/hadoop                 hadoop image woking with consul                 0                    [OK]
qnib/hadoop                                                                      0                    [OK]
lewuathe/hadoop-slave            Multiple node hadoop cluster on Docker.         0                    [OK]
takaomag/hadoop-datanode         docker image of archlinux (hadoop-datanode)     0                    [OK]


搞定！
