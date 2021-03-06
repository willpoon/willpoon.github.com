Title:  OBIEE:从一次报表性能调优谈提示的默认值设置技巧
Slug:   obieeDefaultValue
Authors: Poon





# 缘起

有一张报表，打开非常慢。我查了一下，问题出在提示的默认值设置上：

该提示把 sql 结果 作为默认值，而这段sql 是: 

> select max(报表.统计日期) from “主题报表”

正常来说，对于一般的表，这段sql没有什么问题。但是如果该报表对应的物理层是一个张很大的表，或者是封装出来的复杂的视图，就会出现性能问题。恰好，在本例子中，报表恰好调用的是视图，同时还调用了一张大表。因此，套用聚合函数 max()的时候，出现了查询很久才能出结果的情况。

因此，在本例中，不能用 sql 结果作为默认值。

# 默认值的选择

biee提供了好几种设置默认值的方式：

特定值
变量表达式
服务器变量
SQL结果

其中 “特定值” 是不可动态变化的。而其他的3个，都可以根据变量的取值，或者 SQL的取数结果而动态变化。

# 调优方法

上述案例使用的就是  SQL结果 作为默认值，为了提高效率，我采用了另外一种方式来计算默认值，这种方法也是 'SQL结果'的方式：

> select TIMESTAMPADD(SQL_TSI_DAY,-1,CURRENT_DATE) FROM "主题报表"


这种方法其实是根据内置biee变量 CURRENT_DATE 来获取 T-1 的结果。 而TIMESTAMPADD(SQL_TSI_DAY,-1,) 就是为了得到－1 的效果。


这种方法与上面的select max() 相比，不需要对后台表做全表扫描、排序、去重等运算，只用对current_date 做一个日期偏移计算即可，瞬间出结果。最后报表效率得到巨大提升。

# 其他可能

我们也可以使用 服务器变量 来赋默认值。

例如：我们可以在rpd中定义一个 stat_dt 的变量，采用 初始化块的方式 为stat_dt 赋初值。然后把stat_dt 这个变量名 填写到 提示 的默认选择框中，对应的默认选择类型为 服务器变量。

而对于初始化块来说，其本质也是对 current_date 做日期偏移量计算。

所以在本次优化中，我采用了 TIMESTAMPADD(SQL_TSI_DAY,-1,CURRENT_DATE) 作为 T－1 的计算，而没有采用 rpd 变量的方式。 省却了一个配rpd变量的过程。

# 说明

有人可能会问，既然能够用 TIMESTAMPADD(SQL_TSI_DAY,-1,CURRENT_DATE)  来计算，为啥还用 select max(报表.统计日期) 来计算呢？

最主要的原因，是为了取到日期最近一天的数据。 对于日报，正常的数据日期为 T - 1 ， 但如果某一天系统发生了异常，max() 的结果有可能就不是T-1，但是max()的结果，还是能代表数据的最近一天的数据的。 这是 select max() 最大的优点。

而通过 current_date 偏移 能够确切地得到 T - 1 ，但万一数据不是 T － 1 ， 得到的默认结果将是空集。但这种情况毕竟是少数。



本文首发于微信公众号： **`BI实验室`** ，微信搜索 **`BI实验室`** 或 **`magicof01`** ，也可以扫描下方二维码快速关注哦！

![求关注forIMX3](http://www.imx3.com/img/weixin_bi_common/sdr_code_tree.png)



