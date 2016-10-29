现在一直使用的翻墙工具是shadowsocks，通过各个网站发布的测试账号，实现免费翻墙。

但由于该工具只对桌面应用有效，terminal下的命令例如wget，curl和其他网络相关的命令行工具无法走shadowsocks通道访问被墙资源。

那么，有没有办法把shadowsocks通道‘借’给terminal使用呢？

没有做不到，只有想不到！

privoxy就是一个这样的工具。它将socks代理转成http代理，让终端可以借助http代理访问被墙资源。

当然，privoxy的功能不止于此。


> Privoxy is a non-caching web proxy with advanced filtering capabilities for enhancing privacy, modifying web page data and HTTP headers, controlling access, and removing ads and other obnoxious Internet junk. Privoxy has a flexible configuration and can be customized to suit individual needs and tastes. It has application for both stand-alone systems and multi-user networks.


privoxy 的功能和安装详见官网：http://www.privoxy.org/

使用privoxy 很简单，只需要把privoxy 执行，然后设置http代理即可。

## 1. 找到privoxy 所在目录
cd到这个目录的原因是调用该目录下的config文件。

> cd /usr/local/etc/privoxy/
## 2. 执行 privoxy
> /usr/local/sbin/privoxy
## 3. 设置代理端口

> export http_proxy='http://127.0.0.1:8118'
> export https_proxy='http://127.0.0.1:8118'

或者封装成函数式命令：

```
pri(){
cd /usr/local/etc/privoxy/
/usr/local/sbin/privoxy
export http_proxy='http://127.0.0.1:8118'
export https_proxy='http://127.0.0.1:8118'
}
```
调用:

> pri 

现在可以敲命令翻墙了！比如大家都知道youtube是被墙了的，看我怎么用 youtube-dl 命令把youtube的视频download 下来：

先在浏览器访问youtube，找到一个pentaho的教学视频链接，然后使用youtube-dl来下载：（最近在了解pentaho，国内pentaho的视频真心少！做IT技术咨询&BI也是要不断更新自己的，只能求诸万能的google 和 youtube啦！）

```
youtube-dl https://www.youtube.com/watch?v=28f_qUo4U4c 
[youtube] 28f_qUo4U4c: Downloading webpage
[youtube] 28f_qUo4U4c: Downloading video info webpage
[youtube] 28f_qUo4U4c: Extracting video information
[download] Resuming download at byte 53636968
[download] Destination: Pentaho Data Integration short demo-28f_qUo4U4c.mp4
[download] 100% of 56.88MiB in 03:54

```

youtube-dl 是一个很好很强大的 youtube 视频下载工具，有空写个帖子介绍一下！最后，大家翻墙愉快！







