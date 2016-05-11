Title:  OBIEE:登陆不同主机对应到同一Catalog的问题
Slug:  obiee_loginAgetB
Authors: Poon



[点击上方 BI实验室 ↑↑↑，可快速关注]


# 现象

现在有两套biee环境，一套是开发环境，一套是测试环境。 分别对应ip 10.24.1.101 ; 10.24.1.102 ; 

无论登陆 10.241.1.101 , 10.241.1.102 

成功登陆之后，catalog都指向同一个目录：开发环境catalog目录。

# 分析

一开始怀疑是 instanceconfig.xml 出了问题，但是发现instanceconfig.xml 在最近两套环境中都没有被修改过。

然后我从登陆流程入手。

因为用户是通过ldap服务器登陆的，最终登陆的地方，是由ldap的设置决定。

而ldap服务器是在rpd中设置的。

在我的项目中，无论开发环境还是测试环境，我们都采用域名的方式访问。我们姑且称之为 ： ldapServer 吧！


当在开发环境时，hosts应该是这样的：

```
10.24.1.101 ldapServer

```

当在测试环境时，hosts应该是这样的：

```
10.24.1.102 ldapServer

```

然而，当我核查测试环境的时候，发现hosts是这样的：


```
10.24.1.101 ldapServer

```

当我把 hosts修改回 

```
10.24.1.102 ldapServer

```

之后，问题解决。

# 结论

原来biee对catalog的读取，并不是根据登陆时所访问的ip决定。而是根据ldap服务器对catalog的设置而定。

catloag可以从analyticss中分离出来。



本文首发于微信公众号： **`BI实验室`** ，微信搜索 **`BI实验室`** 或 **`magicof01`** ，也可以扫描下方二维码快速关注哦！

![求关注forIMX3](http://www.imx3.com/img/weixin_bi_common/sdr_code_tree.png)

![求关注forWeChat](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yGH30FHU6SYaJPqvibh7Wib9Pg2V6rc7zjaPJ7aKk9NcpQb9IIhZLCIG8CB4b0QV2vKWopevlhvafw/0?wx_fmt=png)


