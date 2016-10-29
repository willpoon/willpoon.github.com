我们知道，电信等各大运营商已经把外网换成大内网了。如果想自建服务器，要先穿透内网这重屏障。之前一直寻找穿透方法，但是都没有找到，要不是要花钱，成本hold不住，要不就是太复杂，懒的搞。最近和一同事聊起。再研究&尝试了一下，发现其实并不难。(难道之前用google的姿势不对？)

实现穿透常用的方案有：

1.花生壳
2.vps,xtunnel
3.ngrok 反向代理
4.其他类似工具...

昨天我使用xtunnel，已经能够实现穿透，能够比较方便地实现外网访问本机。支持http和tcp。使用方法很简单，这里就不一一介绍了。但是我对该程序的使用不是很爽，于是想看看别的工具，于是找到了ngrok。以下是实验过程：



# ngrok 

 下载：https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-darwin-amd64.zip

 教程：
 	https://dashboard.ngrok.com/get-started
    https://ngrok.com/docs

## http测试：

```
poon@WMBP:~/Downloads$ python -m 'SimpleHTTPServer' 
Serving HTTP on 0.0.0.0 port 8000 ...
127.0.0.1 - - [19/Sep/2016 08:54:48] "GET / HTTP/1.1" 200 -
127.0.0.1 - - [19/Sep/2016 08:54:49] code 404, message File not found
127.0.0.1 - - [19/Sep/2016 08:54:49] "GET /favicon.ico HTTP/1.1" 404 -
127.0.0.1 - - [19/Sep/2016 08:55:35] "GET /pools.info HTTP/1.1" 200 -
127.0.0.1 - - [19/Sep/2016 09:13:59] "GET / HTTP/1.1" 200 -
127.0.0.1 - - [19/Sep/2016 09:16:09] "GET /ngrok-stable-darwin-amd64.zip HTTP/1.1" 200 -
```

> ./ngrok http 8000

## tcp端口测试：

指定需要映射的本地端口：

> ./ngrok tcp 2222


首次使用，为了防止非法登陆，需要安装authtoken 
> $ ./ngrok authtoken a8cd7LSHXAfRZiUsg2Pkm9ZF4_6scANwWr5F94nStTtRfeD



默认docker的root密码不能远程登录，新开一个新用户poon:

```
root@89f65878449c:~# useradd -d /home/poon -m poon
root@89f65878449c:~# passwd poon
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
root@89f65878449c:~# chown poon -R /home/poon
root@89f65878449c:~# su - poon
```


使用新用户poon来登陆：

```
$ ssh poon@0.tcp.ngrok.io -p 13847 
Warning: Permanently added the RSA host key for IP address '[45.79.9.205]:13847' to the list of known hosts.
poon@0.tcp.ngrok.io's password: 
Last login: Mon Sep 19 03:43:23 2016 from 172.17.0.1

```

# ngrok 使用心得：

1. 由于ngrok的服务器在国外，如果使用vpn访问，速度会比国内访问快些。

2. ngrok 的tcp 端口（如ssh） 不太稳定，偶而会连不上。

3. 域名和端口会动态变化，每次启动都可能不一样。

4. 国内也有一些使用ngrok建的服务器，有公司的也有个人的，当官方的不稳定的时候，可以多收集几个别的服务来替代。

5. ngrok 免费版只支持单个http和tcp服务。不能多开。


