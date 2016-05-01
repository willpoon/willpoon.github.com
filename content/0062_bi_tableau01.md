Title:  tableau使用心得
Slug:  tableau_user_experience
Authors: Poon





tableau使用心得

早就听闻tableau大名。还有qlikview. 被gartner摆到'领导者'象限之后，更是名声大噪.

之前我也下过几次试用版安装了，但没有深入了解。这次有需要用到，于是就下视频照着学了一下，初探端倪。

任何东西都是，入门容易，精通难。所以我并没打算花太多时间在这个工具上。但是既然作为一款拥有‘领导者’角色的BI工具，了解一下其特征还是很有必要的。

tableau有几个显著的特点

首先，你会发现， tableau : 

# 收费

呵呵哒。初学者只能找trail edition 或者 cracked edition 来学习，除非你是土豪。
tableau根据功能、用户数、使用时长来定价。真的是酒香不怕巷子深。产品好，坑挖的再大也会有人往里跳！
同时trail 版 只能支持文件作为数据源。不像biee 等工具， 你可以下载个sandbox ，然后无限制地使用。 

话又说回来，tableau还是有很多优点的：

# 什么都能连

你知道的数据库，tableau都能连！不能直连的，也可通过odbc来连！

# 学习门槛低

首先，tableau上手非常容易。用过excel的人，应该都能够直接上手tableau。
其次，官方有各种视频、文本、案例提供支持。更新得很及时。保证是lastest.

对比 biee ， tableau没有为每个窗口都提供help，而更倾向于在线帮助。

# 轻量级

不像biee ， 你如果要从头做一张报表，你首先要装数据库、biee suite ， 然后开发rpd，开发 analysis , 开发仪表盘... 
tableau 透过 tableau desktop ,  一旦与数据源建立了连接之后，就能通过简单的拖拉拽功能来快速创建一个报表。
如果说biee从搭环境到开发一张报表所用的时间是1天，那么tableau是1个小时。
但是发布的话，还是要搭一个tablau server，而且仅仅支持windows的！

# 更智能

比如：

1. 自动识别维度和度量
2. 自动对维度打标、着色等
3. 自动求和
4. 推荐展示方式
5. 自动识别关联条件
...

# 给人亲切感

在tableau身下，你能找到 ppt , excel , 以及其他数据分析工具的身影，很多功能都有相似之处，但同时又会感觉更好用！


# 丰富的图表展示
比如 heat map , maps , treemap , circle view , box-and-whisker plot , packed bubbles , bullet , scatter plots 等等， 非常直观， 能够迅速帮助数据分析人员发现数据问题。


目前我对tableau的研究还停留在比较浅的阶段，所以暂时先聊这么多。有机会再跟各位聊更多的使用心得。

如果要进一步学习 tableau , 可以上 tableau learning 学习！   ( 但是tableau的网站访问速度就不太理想了，至少对于中国区而言：登陆/账户密码重置页面非常缓慢。建议成功登陆之后，把视频和文字、案例数据全部下载到自己电脑上学习。)



本文首发于微信公众号： **`BI实验室`** ，微信搜索 **`BI实验室`** 或 **`magicof01`** ，也可以扫描下方二维码快速关注哦！

![求关注forIMX3](http://www.imx3.com/img/weixin_bi_common/sdr_code_tree.png)



