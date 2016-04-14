Title: 翻山涉水:使用docker快速构建hadoop运行环境
Slug: docker_gfw_hadoop
Authors: Poon

（点击上方**`BI实验室`**↑↑，可快速关注）


# 摘要

本文将介绍如果使用docker快速获取一个hadoop运行环境的。特别针对国内无法直接pull取docker容器的问题提供了翻墙解决方案。所谓翻山：这里指使用shadowsocks翻过GFW访问被墙的网络；所谓涉水，是指使用privoxy把socks代理转成http/https代理，让terminal命令行工具也可以借助socks代理来翻墙，达到命令行和GUI都能借助shadowsocks同步翻墙的效果。让命令行和GUI能够共享socks代理网络，达到融通状态。

# 什么是docker

docker , 一个基于 LXC 虚拟机技术的容器引擎。为应用部署而生。

# 为什么选docker

传统的硬件服务器或者虚拟机方案有如下弊端：

1. 每台服务器只运行一套应用程序/服务，导致计算资源浪费
2. 要为每台服务器购置相应的硬件，导致成本太高
3. 每次部署一台服务器，都要从头开始，部署流程和时间太长，效率低
4. 为了保证性能／环境一致性，扩展时常常受限于硬件供应商
5. 不易于扩展

docker 的出现，能解决上述问题。

# 我为何要和docker发生关系？

我的痛点主要是我的笔记本cpu/内存/空间资源有限，所以需要一个轻量级一点的方案，可以让我专注于 应用和方案本身，而不是每次都为系统资源捉急，甚至操碎了心，最后连做事的心情都没有了。

所以我打算借docker来为我解决这些问题。

# 使用docker遇到的问题

## mac下docker 和 linux 下docker架构不一样

docker 为linux 而生， docker在mac下的架构与在linux下的架构有所不同，需要额外的linux虚拟机支持。
这个问题好办，只要在mac下安装virtualbox , 之后在mac版 docker的安装过程中，会自动为你创建linux虚拟机。所以，当你发现你的virtualbox中无缘无故多出一台linux虚拟机，就不要大惊小怪了。

## docker 容器pull不下来的问题

docker的容器，来自docker hub . 

网上有一句话，人生中最好的东西，都是免费的。
我也有一句话，互联网上最好的东西，都被墙掉了。

docker hub 也不例外。在普通的公网环境下，你无法通过docker pull 的方式来下载一个容器，就连最简单的hello-world都不行。

那么问题来了，怎么搭通天地线，让docker容器能够顺利pull下来？ 毕竟docker装了不能白装，要用起来。

有一个叫kitematic的工具，可以通过可视化界面的方式，pull到一部分容器，但是大部分容器，都无法弄下来。 会报404 、 500 之类莫名奇妙的错误。 我怀疑其后台也是调用命令行方式来pull的。

所以，我要解决的是，让terminal能够执行docker pull ，直接通过docker提供的命令把容器拖下来。

# 思路

我的想法很简单，就是让terminal 下执行的命令能够走代理访问被墙掉的网站。

比如 wget / curl 这些命令，如果能够通过某种配置，让它们能够直接访问google.com  ， facebook.com 等站点，那么 docker pull 同理也可以访问了。

目前 我的情况是：

1. 通过 shadowsocks 我可以通过浏览器访问 google.com 之类的网站。
2. 但是无法通过terminal wget / curl 来访问 google.com 之类的网站。
3. kitematic 能够打开docker hub repo ， 但是无法下载容器。

所以，我要做的，是让 terminal 支持 docer pull 命令方式来 pull 容器。

## 步骤

### 首先安装 privoxy 

假定你已经有了shadowsocks环境，那接下来我们就来安装 privoxy。　

这个工具可以让 socks 代理转成 http 代理， 并且支持命令方式配置。

	brew install privoxy

无需人工干预，自动安装。

### 修改 privoxy config

修改配置文件

	vim /usr/local/etc/privoxy/config

```

forward-socks5   /  127.0.0.1:1080 .
#下面这条可能默认就有，如果没有，请加上
#listen-address  localhost:8118 
#local network do not use proxy
forward         192.168.*.*/     .
forward            10.*.*.*/     .
forward           127.*.*.*/     .

```

完了 :wq 保存即可。

### 启动privoxy 



	/usr/local/sbin/privoxy

执行这个命令，直接就在后台启动了。

如果你不想再后台启动，可以执行：


/usr/local/sbin/privoxy --no-daemon


这样，privoxy将挂起。作用是便于调试。

### 设置 docker运行环境：

如果你的terminal shell环境没有特别设置，很可能无法正常执行docker , 因此，执行docker之前，要先把环境设置好。方法有两种：

1. 通过kitematic左下角的 `CLI` 图标打开。

2. 通过命令行配置

	bash -c "clear && DOCKER_HOST=tcp://192.168.99.100:2376 DOCKER_CERT_PATH=/Users/poon/.docker/machine/machines/default DOCKER_TLS_VERIFY=1 /bin/bash"

相当于对环境初始化一下。功能与 kitematic 等同。

如果没有初始化环境，将会报如下错误：

```
$ docker pull sequenceiq/hadoop-docker:2.7.1
Warning: failed to get default registry endpoint from daemon (Cannot connect to the Docker daemon. Is the docker daemon running on this host?). Using system default: https://index.docker.io/v1/
Cannot connect to the Docker daemon. Is the docker daemon running on this host?

```



### 设置环境变量

mac下的环境变量名和linux的环境变量名的区别是：大小写不一样！

	export http_proxy='http://127.0.0.1:8118'
	export https_proxy='http://127.0.0.1:8118'

如果要取消设置：

	unset http_proxy
	unset https_proxy


### 执行pull 操作

	docker pull sequenceiq/hadoop-docker:2.7.0


结果如下：

```

bash-3.2$ docker pull sequenceiq/hadoop-docker:2.7.1

2.7.1: Pulling from sequenceiq/hadoop-docker
b253335dcf03: Downloading [===========================>                       ]  28.3 MB/50.9 MB
a3ed95caeb02: Download complete 
69623ef05416: Download complete 
8d2023764774: Downloading [===============>                                   ] 27.55 MB/88.09 MB
0c3c0ff61963: Download complete 
ff0696749bf6: Downloading [>                                                  ] 2.702 MB/153.4 MB
72accdc282f3: Waiting 
5298ddb3b339: Waiting 
f252bbba6bda: Waiting 
3984257f0553: Waiting 
26343a20fa29: Waiting 
f3e272e0e801: Waiting 
ad78a593ca62: Waiting 
673712aa7667: Waiting 
aaf06cd0aa6e: Waiting 
fed9c9377250: Waiting 
d4385c519f63: Waiting 
49ca93868354: Waiting 
98e62c38a660: Waiting 
3679d1cf91a0: Waiting 
31ae294be02b: Waiting 
13605254d8c3: Waiting 
a54805751dfa: Waiting 
38537e9c387f: Waiting 
dc639853e053: Waiting 
e267620cd7fd: Waiting 
93990a6b26ca: Waiting 
11ffe2baf32d: Waiting 
c91b10bf3a44: Waiting 
adede6edfea0: Waiting 
4afb2f219fa7: Waiting 
0335bc4000de: Waiting 
e6c5265506dc: Waiting 
3bb2b06400be: Waiting 
d9665143ac9a: Waiting 
2a1a28b12647: Waiting 
5c175609cbf3: Waiting 
e2a7d6798159: Waiting 
88d87e462c71: Waiting 
3a404fc6437e: Waiting 
5517052ef612: Waiting 
fa61c616ddd1: Waiting 
d4ab0c19cb91: Waiting 
9aa826a9ca93: Waiting 
b2ecd44f6d78: Waiting 
824658b0b14c: Waiting 
e5c31d8cbbce: Waiting 

```

剩下的就是等待容器下载完毕。


# docker 容器测试

	$ docker run -it sequenceiq/hadoop-docker:2.7.1 /etc/bootstrap.sh -bash

运行结果:


```

/
Starting sshd:                                             [  OK  ]
16/04/13 22:25:55 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Starting namenodes on [af4d640b141e]
af4d640b141e: starting namenode, logging to /usr/local/hadoop/logs/hadoop-root-namenode-af4d640b141e.out
localhost: starting datanode, logging to /usr/local/hadoop/logs/hadoop-root-datanode-af4d640b141e.out
Starting secondary namenodes [0.0.0.0]
0.0.0.0: starting secondarynamenode, logging to /usr/local/hadoop/logs/hadoop-root-secondarynamenode-af4d640b141e.out
16/04/13 22:26:13 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
starting yarn daemons
starting resourcemanager, logging to /usr/local/hadoop/logs/yarn--resourcemanager-af4d640b141e.out
localhost: starting nodemanager, logging to /usr/local/hadoop/logs/yarn-root-nodemanager-af4d640b141e.out
bash-4.1# pwd
/


```


# 测试 hadoop map / reduce 任务执行：

命令：

	# bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar grep input output 'dfs[a-z.]+'


结果输出：

```	

16/04/13 22:39:04 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
16/04/13 22:39:05 INFO client.RMProxy: Connecting to ResourceManager at /0.0.0.0:8032
16/04/13 22:39:06 INFO input.FileInputFormat: Total input paths to process : 31
16/04/13 22:39:06 INFO mapreduce.JobSubmitter: number of splits:31
16/04/13 22:39:07 INFO mapreduce.JobSubmitter: Submitting tokens for job: job_1460600778025_0001
16/04/13 22:39:07 INFO impl.YarnClientImpl: Submitted application application_1460600778025_0001
16/04/13 22:39:07 INFO mapreduce.Job: The url to track the job: http://af4d640b141e:8088/proxy/application_1460600778025_0001/
16/04/13 22:39:07 INFO mapreduce.Job: Running job: job_1460600778025_0001
16/04/13 22:39:17 INFO mapreduce.Job: Job job_1460600778025_0001 running in uber mode : false
16/04/13 22:39:17 INFO mapreduce.Job:  map 0% reduce 0%
16/04/13 22:39:46 INFO mapreduce.Job:  map 10% reduce 0%
16/04/13 22:39:47 INFO mapreduce.Job:  map 19% reduce 0%
16/04/13 22:40:09 INFO mapreduce.Job:  map 23% reduce 0%
16/04/13 22:40:12 INFO mapreduce.Job:  map 26% reduce 0%
16/04/13 22:40:13 INFO mapreduce.Job:  map 39% reduce 0%
16/04/13 22:40:36 INFO mapreduce.Job:  map 42% reduce 0%
16/04/13 22:40:37 INFO mapreduce.Job:  map 45% reduce 0%
16/04/13 22:40:38 INFO mapreduce.Job:  map 55% reduce 15%
16/04/13 22:40:41 INFO mapreduce.Job:  map 55% reduce 18%
16/04/13 22:41:01 INFO mapreduce.Job:  map 68% reduce 18%
16/04/13 22:41:02 INFO mapreduce.Job:  map 71% reduce 20%
16/04/13 22:41:05 INFO mapreduce.Job:  map 71% reduce 24%
16/04/13 22:41:25 INFO mapreduce.Job:  map 81% reduce 24%
16/04/13 22:41:26 INFO mapreduce.Job:  map 87% reduce 24%
16/04/13 22:41:27 INFO mapreduce.Job:  map 87% reduce 28%
16/04/13 22:41:30 INFO mapreduce.Job:  map 87% reduce 29%
16/04/13 22:41:47 INFO mapreduce.Job:  map 100% reduce 29%
16/04/13 22:41:48 INFO mapreduce.Job:  map 100% reduce 31%
16/04/13 22:41:49 INFO mapreduce.Job:  map 100% reduce 100%
16/04/13 22:41:49 INFO mapreduce.Job: Job job_1460600778025_0001 completed successfully
16/04/13 22:41:49 INFO mapreduce.Job: Counters: 50

```




# 常见问题

## bash-3.2$ docker pull sequenceiq/hadoop-docker:2.7.0

```

Error response from daemon: Get https://registry-1.docker.io/v2/sequenceiq/hadoop-docker/manifests/2.7.0: Get https://auth.docker.io/token?scope=repository%3Asequenceiq%2Fhadoop-docker%3Apull&service=registry.docker.io: net/http: request canceled (Client.Timeout exceeded while awaiting headers)

```

## bash-3.2$ docker pull sequenceiq/hadoop-docker:2.7.1

```
Pulling repository docker.io/sequenceiq/hadoop-docker
Network timed out while trying to connect to https://index.docker.io/v1/repositories/sequenceiq/hadoop-docker/images. You may want to check your internet connection or if you are behind a proxy.
```

这些都是由于网络没有打通导致的，可以尝试如下操作重新设置网络：

1. 开启 shadowsocks 并确认可以上google等网站。
2. 确认 privoxy 下的 config 文件已经正确设置端口转发
3. 启动 privoxy 
4. 设置 http_proxy , https_proxy
5. 重新执行 docker pull

后续将给大家介绍 hadoop 在docker中的配置和实际应用方面的经验，例如伪分布式环境，敬请期待。

![bottom求关注](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yGH30FHU6SYaJPqvibh7Wib9Pg2V6rc7zjaPJ7aKk9NcpQb9IIhZLCIG8CB4b0QV2vKWopevlhvafw/0?wx_fmt=png)



