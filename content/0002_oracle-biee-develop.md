Title: Oracle BIEE 经验总结
Category: Tech
Tags: oracle,biee,BI
Slug: oracle-biee-develop
Authors: Poon
Summary:  使用biee开发前前后有也有两年多了，对oracle这套产品，也有一点小小心得，在此总结一下，抛砖引玉。持续更新中...

[TOC]

# 0.前言
使用biee开发前前后有也有两年多了，对oracle这套产品，也有一点小小心得，在此总结一下，抛砖引玉。持续更新中...

# 1.经验技巧

### 1.1.physical layer 不支持with子句


如果你打算将：
with tab as（  ） 这样的子句放到物理表视图中，那么rpd将会让你失望。因为rpd中的视图实质上是一个形如 select * from ( ) tab 的子查询。而如果你要将with放到子查询中，将会影响biee前端自动生成with 子句。如果你要用with子句写查询语句，简易先 create view yourviewname as 来建立一个视图，然后再在物理层中调用。

### 1.2.Session variable 可以放到物理层

你可以将VALUEOF(NQSESSION.RQVAR) 在物理层中引用Session Variable，然后通过在前端使用request variable来修改session variable的值。

### 1.3.BIEE的timestamp类型的日期运算：推算前n天，后n天，前n月，后n月等。

使用timestampdiff（）函数，可控制的粒度可以细到秒，粗到年！

### 1.4.利用biee的提示,将展示变量传递到会话变量

#### 1.4.1.背景：

1. 一个服务器变量 TABLE_NAME_INOUT，又叫 session variable , 对应前端是 request variable  ， 该变量需要保存一个表名，该表名具有INOUT的特征。
2. 在业务上，为业务人员设计了一个提示框，二选1，对于业务，是切换客户层级，而对于后台，是切换数据表。
3. 关系梳理： 用户提示：客户层级切换  <—> 后台表名切换
4. 需要在这中间 添加一个转换机制 ：输入 ： 储蓄/资产 ， 转换为 ： DPSIT/ASSET


#### 1.4.2.设计：
1. rpd: NQ_SESSION.TABLE_NAME_INOUT

2. analytics 提示a设计：表示变量pv: 作为 转换到表名的输入。该提示a 不能设计为 请求变量， 否则传递无效。

3. analytics 提示b设计：请求变量：TABLE_NAME_INOUT ,  列公式设计：

    case when pv=‘xxx' then ‘dfadfa’
    when pv =‘yyy’ then ‘dfads'
    end
    
4. 注意事项: 如果 pv变量传递的是字符串，那么需要用 单引号引起来。如： ‘@{pv}’

5.  define pv = ‘xxx’ ; define rqv = case when pv …. end 

6. 列公式不是必需的。可以用 ‘anychar’ 代替。

7. 默认值的设置，一定要正确。

#### 1.4.3. 其他tips：

1. 默认值的填写： 如果是服务器变量，直接填写 : var_name , 不需要 valueof , 也不需要 nq_session 
2. 如果是 变量表达式：就是表示变量：格式：@{pv} 即可。有默认值也可以添加默认值。

### 1.5. BIEE分析报表的格式套用/批量设置解答：
1.  把格式设置存为默认会发生什么？

    如果把格式存为默认，那么系统中的所有报表都将会采用该设置作为默认值。例如，我们把一个整数列的格式设置为两位小数，那么对于其他报表，如果没有特别设置，都将采用该设置作为默认值。
2. 从已经保存的报表中借用格式，套用到新报表中，是怎么一个规则？

    以下是官方说法：

    Applying Formatting from Columns [官方链接](http://docs.oracle.com/cd/E28280_01/bi.1111/e10544/format.htm#BIEUG1192i)
    This functionality works best for views when attribute, measure, or hierarchical column numbers align precisely or for a single column template that can be applied to all columns. If a single column exists in the saved analysis, then its formatting is applied to all columns in the tables, pivot tables, and trellises of the target analysis.

    For multiple columns, formatting is applied positionally, from left to right for column headings and values. A column that exceeds the number in the saved analysis gets the closest column's format repeated. For example, suppose the saved analysis contains four columns formatted with these colors in this order: red, green, blue, yellow. In the target analysis, its six columns would acquire these colors in this order: red, green, blue, yellow, yellow, yellow.

解析：

1. 如果保存的报表只有一列,那么新报表的格式将全部采用那列的格式。
2. 如果属性列，度量列和层级列的数量和对齐都是一致的，那么将会一一匹配。
3. 如果列数不等，新报表列数多，那么新报表中不能匹配的列将重复最后一列。比如，4列老报表的列颜色设置为 红绿蓝黄，那么6列新报表的颜色为红绿蓝黄黄黄！

## 1.6  Oracle BIEE从开发迁移到生产时，如何处置修改配置这些麻烦事？

### 1.6.1 RPD 密码的修改
连接池越多，要改的密码就越多！你愿意每次投产，都要做这种没有技术含量，而风险又大的活？of course not !
通过使用 admintool.exe /command 命令，通过配置的方式，修改密码，只需要执行批处理即可！

a. run.bat 批处理脚本： 

	set ORACLE_BI_LANG=en
	set path=%path%;"C:\Program Files\Oracle Business Intelligence Enterprise Edition Plus Client 2 2\oraclebi\orahome\bifoundation\server\bin"
	REM set ORACLE_HOME=C:\Program Files\Oracle Business Intelligence Enterprise Edition Plus Client 2 2\oraclebi\orahome
	REM set ORACLE_INSTANCE=C:\Program Files\Oracle Business Intelligence Enterprise Edition Plus Client 2 2\oraclebi\orainst
	REM set ORACLE_BI_APPLICATION=coreapplication
	AdminTool.exe /command D:\poon\cases\rpd\PRDUCTION\AutoChangeAcct\prd.txt

b.  prd.txt 命令内容：

	// 离线打开rpd
	OpenOffline D:\poon\cases\rpd\PRDUCTION\AutoChangeAcct\rpd001.rpd passwordhere

	 //设置连接池

	SetProperty "Connection Pool" "1_5C"."5C_BIEEMGROPR" "DSN" "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=bieehost)(PORT=1528)))(CONNECT_DATA=(SERVICE_NAME=biee)))"

	// 设置用户名
	SetProperty "Connection Pool" "1_5C"."5C_BIEEMGROPR" "User" "bieemgropr"

	//设置密码
	SetProperty "Connection Pool" "1_5C"."5C_BIEEMGROPR" "Password" "passwordhere"

	// 保存rpd
	Save


## 1.7 weblogic －服务－数据源－中的 jndi 对应后台哪个xml配置文件？

    ${BIEE_HOME}/user_projects/domains/bifoundation_domain/config/jdbc/bieeds-jdbc.xml

另外，连接池url的格式为：

    jdbc:oracle:thin:@ip_or_domain:port/sid


## 1.8 BIEE报表如何实现单元格绿白相间？

如图，在结果中，点击表属性。如图：

![设置biee表单元格样式](img/00001-04.jpg)
 

## oracle biee try it live 的地址是？
2015-11-21 10:24

地址： 

    http://slc02ojq.oracle.com:7780/analytics/

帐号密码:

    Prodney/Admin123

参考：

    https://community.oracle.com/message/13342070

备注：


slc02ojq  works
slc02ojy  works

<s>slc02oky</s>

slc02ojl fail
slc02ojw fail
slc02ojr fail 
slc02oka fail


### odbc.ini 有什么用？

odbc.ini 是用户配置展示层到bi server层的数据连接的。我们知道，biee有展示服务，有bi service 服务，一个是展示层，一个是服务层。这两层数据之间数据如何通信？就是通过odbc数据源配置，使得biee的展示层能够存取后台数据库的数据。


### 1.6.2 服务器ip / 端口的修改
不要再用ip 了 ！ 赶紧改用域名把！ 把你的开发主机 的hosts 改一下，采用与生产环境主机相同的域名！就不用每次都把ip改来改去了。


## biee 用户权限配置管理方面的case!

### 背景

 在一个部门里，有几个业务员，其中有一个业务员很NB，他懂得自己开发报表。其他人想学他那样，但是自己又不会开发，所以软磨硬泡，要求他共享出来。这哥们的报表本来保存在个人文件夹里的，现在只能向管理员申请一个共享文件夹的目录，并且需要读写删等权限。而其他人，需要对这个目录具有打开查看的权限。这些访问用户该如何赋权？

### 方案

#### 挨个用户按用户名赋权

对目录右键查找相应用户，直接赋权。

#### 创建应用程序角色

为该共享目录创建应用程序角色，最后区分角色的权限，比如：

目录a读取权限角色
目录a修改权限角色
目录a删除权限角色
or 
目录a管理员角色
目录a用户角色


## 跨部门报表共享

其实跟我们开发人员开发报表没什么区别。只是需要建一个与部门并列的目录，用于存放共享报表。如果涉及多部门，再在该目录划分。

再通过用户权限角色，把用户划分成一个个群体，挂接到相应的目录上。

然后通过 用户－组 配置工具， 为用户添加权限。

## biee analysis 中的标题是可以填写 presentation 变量的。 

# 2.异常处理

### 2.1 ora-32034:unsupported use of with clause at OCI call OCIstmtExecute.

解决办法：检查rpd物理层子查询中是否有with子句。有的话，改成子查询的形式。


### 2.2 nqserror:43119 nqserror:42039: report 总计函数的by子句中的列必须在选择列表中。

该异常我理解为：select dim... report_sum( measure by dim... ) from table ...
dim... 没有对应上！

如何排除该异常：把视图中exclude掉的字段，试验性地添加到include列中。如果你不希望挪上去的列展示出来，再把该列设置为隐藏即可！

<s>本文最后更新于: 2015-11-09 14:46</s>

<s>本文最后更新于: 2015-11-10 11:37</s>

<s>本文最后更新于: 2015-11-10 15:57</s>

本文最后更新于: 2015-11-17 15:00

### 2.3 biee catalog 指向 不正确如何解决？

修改 instanceconfig.xml , 将 <CatalogPath> 标签中的路径改为正确的路径。

### 2.4 加载的rpd 不是我们想要的repository ， 怎么改成我们要的rpd?

修改 NQSConfig.INI

    Star = yourRPDname.rpd , DEAULT;

如果rpd通过前端em上传的，通常会出现rpd名字被修改，导致引用不正确的情况。



