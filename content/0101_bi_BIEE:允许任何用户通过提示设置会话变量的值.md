Title:  BIEE:允许任何用户通过提示设置会话变量的值
Slug:  bi_0101
Authors: Poon
 
# 背景

最近在群里有朋友问为何通过提示无法为会话变量赋值。刚好我也碰到过这个问题。
当我们在rpd中定义了一个会话变量(session variable )，然后企图通过提示中的请求变量(request variable) 来改变会话变量的值的时候，却发现数据并没有根据提示的设置而改变。
同时报如下错误：

nQSerror:13015 您无权设置变量 'xxxx' 的值, 有关此错误的详细信息，请让系统管理员查看日志。


png


# 原因

这是因为会话变量的值设置权限没有设置给任意用户。


# 解决

如下图，通过rpd 修改 会话变量的设值权限：

允许任何用户设置值( enable any user to set the value )


png 


经此设置之后，除weblogic以外的普通用户也能够通过提示中的请求变量来改变会话变量的值了。


以下，原创凑字数专用!300字怎么就不算原创了？！
关键字： obiee,rpd,提示,权限，会话变量，session variable , 请求变量 ,request variable，展示变量,presentation variable , 提示设值，变量修改，变量覆盖， enable any user to set the value , 您无权设置变量xxx的值
关键字： obiee,rpd,提示,权限，会话变量，session variable , 请求变量 ,request variable，展示变量,presentation variable , 提示设值，变量修改，变量覆盖， enable any user to set the value , 您无权设置变量xxx的值
关键字： obiee,rpd,提示,权限，会话变量，session variable , 请求变量 ,request variable，展示变量,presentation variable , 提示设值，变量修改，变量覆盖， enable any user to set the value , 您无权设置变量xxx的值


本文首发于微信公众号： **`BI实验室`** ，微信搜索 **`BI实验室`** 或 **`bidatalab`** ，也可以扫描下方二维码快速关注哦！

![求关注forWeChat](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yGH30FHU6SYaJPqvibh7Wib9Pg2V6rc7zjaPJ7aKk9NcpQb9IIhZLCIG8CB4b0QV2vKWopevlhvafw/0?wx_fmt=png)


