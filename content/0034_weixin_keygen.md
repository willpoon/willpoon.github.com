集群环境配置：无密码登录是怎么样实现的？

# 背景 在配置hadoop 集群的时候，涉及到无密码登录的问题。也就是机器A、机器B、机器C...之间互访时，不需要密码就可以登录，来去自如。

刚开始觉得很神奇，还可以这样？不用输入密码登录确实很方便，但会不会有安全问题？但仔细想想其验证过程，这种担心是多余的。这种方式也叫证书登录。

# 验证过程

## 传统的密码登录验证过程：

1. 用户输入密码
2. 服务器校验
3. 密码对就登录，否则拒绝

## 无密码登录验证过程

1. 用户发起登录请求
2. 服务器根据公钥判断来访者是否有权限（是否认识该用户）
3. 认识就让登录，否则切换为密码登录验证模式


这有点像看电影：正常情况下，大家都凭票进场。但员工例外。于是，检票员对于陌生人都无一例外的验票。但是如果是影院员工，因为之前电影院有交底，刷脸就可以了^ ^

# 如何实现

##  客户端


	 ssh-keygen 一直回车， 提示：   	Generating public/private rsa key pair. 	Enter file in which to save the key (/root/.ssh/id_rsa):  	Enter passphrase (empty for no passphrase):  	Enter same passphrase again:  	Your identification has been saved in /root/.ssh/id_rsa. 	Your public key has been saved in /root/.ssh/id_rsa.pub. 	The key fingerprint is: 	12:b1:8b:ca:12:55:44:79:ba:bc:18:bd:ec:4f:26:96 root@dmp.example.com 	The key's randomart image is: 	+--[ RSA 2048]----+ 	|       .o.       | 	|        o+.      | 	|       .+o       | 	|       oo.       | 	|    .+S.       | 	|   . .o +.       | 	|    o. +Eoo      | 	|    ....++    | 	|    .. ....      | 	+-----------------+



## 服务器端

把刚刚生成的 id_rsa.pub 上传到服务器，存到保险柜：

	cd ~/.ssh 	cat id_rsa.pub >> authorized_keys 


## 测试登录

	 ssh n01.kylin.hdp 	  提示：

	Last login: Tue Jan 19 15:07:16 2016 from x.x.x.101

即成功！

# FAQ

## 无密码登录如何验证身份？ 通过匹配公钥、私钥 字串对。

## 无密码登录怎么设置无密码？ 生产私钥的时候不设置密码就可以了。

## 服务器如何验证用户是否非法？ 先验证机器、用户，再验证密码特征。与ip环境无关。

## 是不是把公钥copy到另外一台机器，也可以实现无密码登录？ 是的，前提那台机器也有这样的用户。

## 无密码登录的作用是什么？
1. 方便懒人！
2. 自动化验证！

## RSA容易破解吗？ 据说一般人难以破解。破解了也没关系，反正你是无密码的。

## 是否有安全隐患？ 有！就是当你的私钥被人盗用的时候！但是，在集群环境下，私钥一般也都是放在服务器上的，如果别人能登录服务器，不就已经沦陷了吗？

