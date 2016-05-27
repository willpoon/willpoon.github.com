Title:  bash:当通配符(*)遇上文件名的空格(Space)
Slug:  whenWildcardMeetSpace
Authors: Poon



[点击上方 BI实验室 ↑↑↑，可快速关注]


# 有如下文件：
> $ll

```
-rw-r--r--@ 1 poon  staff  152753 May 27 09:08 Screen Shot 2016-05-27 at 09.08.26.png
-rw-r--r--@ 1 poon  staff  261409 May 27 09:14 Screen Shot 2016-05-27 at 09.14.27.png
-rw-r--r--@ 1 poon  staff   57746 May 27 09:14 Screen Shot 2016-05-27 at 09.14.44.png
```

执行命令：

> for png in `ls Screen*png`; do echo $png; done

结果：

```
Screen
Shot
2016-05-27
at
09.08.26.png
Screen
Shot
2016-05-27
at
09.14.27.png
Screen
Shot
2016-05-27
at
09.14.44.png
```

空格导致echo 的时候把一个文件名拆成多个。

怎么解决？

通过万能的google和stackoverflow，我找到了如下方法：

> for png in *\ *png; do echo $png; done

结果：

```
Screen Shot 2016-05-27 at 09.08.26.png
Screen Shot 2016-05-27 at 09.14.27.png
Screen Shot 2016-05-27 at 09.14.44.png
```

结果，通配完整，成功！

# 结论

使用 `*\ *` 可以通配空格！

参考：

<<Work the Shell - Dealing with Spaces in Filenames>>

本文首发于微信公众号： **`BI实验室`** ，微信搜索 **`BI实验室`** 或 **`magicof01`** ，也可以扫描下方二维码快速关注哦！

![求关注forIMX3](http://www.imx3.com/img/weixin_bi_common/sdr_code_tree.png)

![求关注forWeChat](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yGH30FHU6SYaJPqvibh7Wib9Pg2V6rc7zjaPJ7aKk9NcpQb9IIhZLCIG8CB4b0QV2vKWopevlhvafw/0?wx_fmt=png)


