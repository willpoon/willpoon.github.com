1. docker images 和 kitematic 会有冲突！

2. 通过ssh访问容器：

poon@WMBP:~$ docker run -it mysql bash
root@b7242b12045d:/# 


3. 如何解决容器冲突：

docker: Error response from daemon: Conflict. The name "/mysql" is already in use by container 6efb82aa265cef78a52756ffe5aeed443722589145785a4f430b089dad35282a. You have to remove (or rename) that container to be able to reuse that name..


4. 如何添加、删除、管理容器






bash -c "clear && DOCKER_HOST=tcp://192.168.99.100:2376 DOCKER_CERT_PATH=/Users/poon/.docker/machine/machines/default DOCKER_TLS_VERIFY=1 docker exec -it mysql sh"



5. docker attach

poon@WMBP:~$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                 CREATED             STATUS                        PORTS               NAMES
af14d8585914        mysql               "/entrypoint.sh bash"   2 minutes ago       Exited (127) 26 seconds ago                       suspicious_yalow
a0b325cc9628        hello-world         "/hello"                3 minutes ago       Exited (0) 3 minutes ago                          furious_babbage
poon@WMBP:~$ docker attach af14d8585914
You cannot attach to a stopped container, start it first
poon@WMBP:~$ docker start af14d8585914
af14d8585914
poon@WMBP:~$ docker attach af14d8585914
root@af14d8585914:/# 
root@af14d8585914:/# 



6. docker 启动 mysql数据库

poon@WMBP:~$ docker run --name mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql:latest


poon@WMBP:~$ docker run --name mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql:latest
e19d61ebd3f52d6a890e691c1cae0c261729c725d3f8f33beb8050581919757e
poon@WMBP:~$ 
poon@WMBP:~$ 
poon@WMBP:~$ 
poon@WMBP:~$ 
poon@WMBP:~$ 
poon@WMBP:~$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
e19d61ebd3f5        mysql:latest        "/entrypoint.sh mysql"   12 seconds ago      Up 11 seconds       3306/tcp            mysql
poon@WMBP:~$ docker exec -it mysql /bin/bash


root@e19d61ebd3f5:/# ps -ef|grep -i mysql
mysql        1     0  1 11:08 ?        00:00:00 mysqld
root       110   104  0 11:09 ?        00:00:00 grep -i mysql




7. 通过命令行客户端连接docker mysql :

poon@WMBP:~/Git/gitblog_imx3/output/content$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
ca7f9b403955        mysql:latest        "/entrypoint.sh mysql"   7 minutes ago       Up 7 minutes        0.0.0.0:3366->3306/tcp   mysql


poon@WMBP:~/Git/gitblog_imx3/output/content$ mysql -uroot -p -h 127.0.0.1 -P3366
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 5
Server version: 5.7.11 MySQL Community Server (GPL)

Copyright (c) 2000, 2015, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 


8. 设置 docker 和 宿主机的端口映射：

8.1 使用 kitematic 端口映射: run -it -p 8080:8181 -p 22:2222
8.2 使用 iptables & docker 命令行

http://udn.yyuap.com/doc/docker_practice/advanced_network/port_mapping.html

http://my.oschina.net/u/266752/blog/541433

http://www.iyunv.com/thread-33701-1-1.html



9.docker 删除镜像


docker rmi imageId
docker rmi imageId

注意：先停止、删除容器，再删除image。


10. 与容器交互：

poon@WMBP:~$ docker run -it 4135d0066baf /bin/bash
pentaho@4e01af00d8ce:~/data-integration$

or:

sudo docker run -i -t wmarinho/pentaho-biserver:5.1-TRUNK /bin/bash





docker run -it --name pentaho  -p 8080:8080 -p 8181:8181 -e PGHOST=127.0.0.1 wmarinho/pentaho-kettle


docker run -it 4135d0066baf /bin/bash



11. 查看 docker images 内容文件




12. docker entrypoint 



root@f5ffcee32ec5:/# export MYSQL_ROOT_PASSWORD=123456
root@f5ffcee32ec5:/# ./entrypoint.sh mysqld
Initializing database

注意环境变量需要export ！


docker run -it mysql bash



##docker run --name mysql -e MYSQL_ROOT_PASSWORD=123456  mysql:latest -p 3366:3306 --entrypoint  "./entrypoint.sh mysqld && /bin/bash"

## 挂后台，密码，端口映射：
docker run  -p 3366:3306 --name mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql:latest




13. 查看容器日志

docker logs -f <容器名orID>



14. 有时docker会无法连接，基本的命令 如 docker images , docker ps -a 等都无法响应。这时需要重启docker，或者重启电脑。




15. pentaho 

## works : 
docker run --name pentaho-kettle   -p 8181:8181   -it  4135d0066baf  /bin/bash  




16. 如何分析容器占用的内存




17. 

poon@WMBP:~/Git/gitblog_imx3/output/content$ docker run -d -p 2222:22 -p 8888:8080 -e AUTHORIZED_KEYS="`cat ~/.ssh/id_rsa.pub`" bytekast/docker-pentaho-ce-5.3:latest  


poon@WMBP:~/Git/gitblog_imx3/output/content$ docker run -d -p 2222:22 -p 8888:8080 bytekast/docker-pentaho-ce-5.3:latest




poon@WMBP:~/Git/gitblog_imx3/output/content$ ssh -p 2222 root@127.0.0.1
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the RSA key sent by the remote host is
08:8e:a6:cd:16:12:64:8f:9b:7c:1e:e8:26:ae:b4:8c.
Please contact your system administrator.
Add correct host key in /Users/poon/.ssh/known_hosts to get rid of this message.
Offending RSA key in /Users/poon/.ssh/known_hosts:27
RSA host key for [127.0.0.1]:2222 has changed and you have requested strict checking.

解决： 

删除 /Users/poon/.ssh/known_hosts 中 冲突条目。




CONTAINER ID        IMAGE                                   COMMAND                  CREATED             STATUS                  PORTS                                                    NAMES

89f65878449c        bytekast/docker-pentaho-ce-5.3:latest   "/bin/sh -c '/home/pe"   3 days ago          Exited (0) 2 days ago   5432/tcp, 0.0.0.0:2222->22/tcp, 0.0.0.0:8888->8080/tcp   thirsty_davinci





# 2016-09-13 22:21

poon@WMBP:~/Git/gitblog_imx3/output/content$ docker pull alexeiled/docker-oracle-xe-11g


# 2016-09-14 08:39

docker 对于我来说，最大的好处是，想要获得一个服务，不要繁琐的安装配置，只需要pull下来启动就可以用了！

不像虚拟机，你得先要有一台主机，然后下载软件，安装，配置。过程非常繁琐。 浪费时间，各种依赖关系要处理。


