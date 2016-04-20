Title: OBIEE: 为什么通过后台FTP更新的RPD没有生效？
Slug: obiee_centralconfiguration
Authors: Poon

（点击上方**`BI实验室`**↑↑，可快速关注）


# 问题

开发人员通过ftp把最新的RPD上传到后台目录，重启OBIEE后发现RPD并没有更新。同时发现现有的主题区域也有差异。

# 分析

我们知道，主题区域是跟随RPD的presentation层的。这说明biee在用的RPD不是我们上传的rpd。

# 核查

rpd 文件的配置在：

> NQSConfig.INI

文件中。

我们发现配置 rpd  的参数：

> [REPOSITORY]
> Star = abc_xxx.rpd 

中，abc_xxx并非是我们上传的名字，xxx 是一串数字。这说明rpd 是通过 em 前端更新的，并且带了xxx作为自动递增版本号。

要改回来也很简单，只需要把 abc_xxx.rpd 改成 你ftp上传的名字，比如abc.rpd 就行了。

# 解决

如何 防止 em 自动 更新 [repository] 配置？

在

> ./user_projects/domains/bifoundation_domain/config/fmwconfig/biee-domain.xml 

中， 把 centralConfigurationEnabled 设置成 false . 

这样，就禁止通过em来更新rpd，只能通过ftp上传rpd来更新。也就防止了NQSConfig.INI 中 rpd的指向被修改了。

![bottom求关注](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yGH30FHU6SYaJPqvibh7Wib9Pg2V6rc7zjaPJ7aKk9NcpQb9IIhZLCIG8CB4b0QV2vKWopevlhvafw/0?wx_fmt=png)

