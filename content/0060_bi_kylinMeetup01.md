Title:  kylin:提升业务分析人员的幸福指数的大数据OLAP引擎
Slug:  kylin_fast_olap_Engine
Authors: Poon



（点击上方 **`BI实验室`** ↑↑，可快速关注）

# 前言

	2016.04.24 去北京参加了 kylin 2nd Meetup , 进一步了解了kylin在各行各业、不同业务场景中的应用实践。我印象比较深的是中移动哥们的一个提法：
	造轮子的人->基于轮子二次开发的人->用户。
	想想大部分的产品，都是这么一个模式。
	科技就是这样，少数的人造了轮子，然后另外一部分基于这个轮子结合用户的需求，定制别的产品，然后给一大群用户使用。
	这种层次的划分，不但让我们早到了产品演变的路向，同时一下就让我们找准了自己的定位。这种有内而外的分层思想很值得借鉴。

	kylin确实是一个不错的OLAP工具。以下是关于kylin的功能介绍，译自官方，比较粗略，不当之处，还请多多指正！如果你对kylin感兴趣，可以到 kylin.apache.org 官方网站了解跟进。


# apache kylin 概览

Apache Kylin™  是一个源自eBay公司的，基于Hadoop之上的，支持超大数据集的，提供SQL查询界面的开源多维分析(OLAP)引擎。

只用简单的3步，Apache Kylin™ 就可以让你以亚秒级速度查询Hive中的大表：

1. 以星型模型构建Hive中表与表之间的关系。
2. 通过离线批处理对Hive表做处理，生成cube
3. 通过 Rest API, ODBC , JDBC等接口，用sql查询 Hive tables . 



# 什么是kylin 

- 可扩展的、超快速的OLAP引擎
kylin是为降低Hadoop上数据查询延迟而生，支持100亿行＋的数据
- 支持ansi sql on Hadoop: 
kylin为hadoop提供了大量的ansi sql查询语法支持
- 交互查询能力
用户可以通过Kylin的亚秒级查询来与Hadoop上的数据做交互查询，速度比用Hive查询快得多！
- MOLAP Cube
用户可以在kylin中定义Cube数据模型并支持超过100亿条记录的Cube构建。
- 与BI工具无缝整合
Kylin目前提供了对诸如Tableau,PowerBI和Excel等工具的整合能力.对Microstrategy的整合能力也即将推出。
- 其他亮点:
- 任务管理和监控
- 压缩和编码支持
- Cube的增量刷新
- Leverage HBase Coprocessor for query latency 
- 使用HyperLogLog估算count(distinct)
- 为Cube提供简易的管理、构建、监控和查询界面
- 通过ACL权限管理保障Cube/Project的安全性
- 支持LDAP集成


#### APACHE KYLIN™ OVERVIEW

Apache Kylin™ is an open source Distributed Analytics Engine designed to provide SQL interface and multi-dimensional analysis (OLAP) on Hadoop supporting extremely large datasets, original contributed from eBay Inc.
Apache Kylin™ lets you query big Hive tables at sub-second latency in 3 simple steps.
Identify a set of Hive tables in star schema.
Build a cube from the Hive tables in an offline batch process.
Query the Hive tables using SQL and get results in sub-seconds, via Rest API, ODBC, or JDBC.


#### WHAT IS KYLIN?

- Extremely Fast OLAP Engine at Scale: 
Kylin is designed to reduce query latency on Hadoop for 10+ billions of rows of data
- ANSI SQL Interface on Hadoop: 
Kylin offers ANSI SQL on Hadoop and supports most ANSI SQL query functions
- Interactive Query Capability: 
Users can interact with Hadoop data via Kylin at sub-second latency, better than Hive queries for the same dataset
- MOLAP Cube:
User can define a data model and pre-build in Kylin with more than 10+ billions of raw data records
- Seamless Integration with BI Tools:
Kylin currently offers integration capability with BI Tools like Tableau, PowerBI and Excel. Integration with Microstrategy is coming soon
- Other Highlights: 
- Job Management and Monitoring 
- Compression and Encoding Support 
- Incremental Refresh of Cubes 
- Leverage HBase Coprocessor for query latency 
- Approximate Query Capability for distinct Count (HyperLogLog) 
- Easy Web interface to manage, build, monitor and query cubes 
- Security capability to set ACL at Cube/Project Level 
- Support LDAP Integration


本文首发于微信公众号： **`BI实验室`** ，微信搜索 **`BI实验室`** 或 **`magicof01`** ，也可以扫描下方二维码快速关注哦！

![求关注forIMX3](http://www.imx3.com/img/weixin_bi_common/sdr_code_tree.png)

![求关注forWeChat](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yGH30FHU6SYaJPqvibh7Wib9Pg2V6rc7zjaPJ7aKk9NcpQb9IIhZLCIG8CB4b0QV2vKWopevlhvafw/0?wx_fmt=png)


