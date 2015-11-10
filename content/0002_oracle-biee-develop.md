Title: Oracle BIEE 经验总结_update2015-11-09
Date: 2015-11-09 14:47
Modified: 2015-11-10 11:30
Category: Tech
Tags: oracle,biee,BI
Slug: oracle-biee-develop
Authors: Poon
Summary:  使用biee开发前前后有也有两年多了，对oracle这套产品，也有一点小小心得，在此总结一下，抛砖引玉。持续更新中...

# 前言
使用biee开发前前后有也有两年多了，对oracle这套产品，也有一点小小心得，在此总结一下，抛砖引玉。持续更新中...

# 经验技巧

### physical layer 不支持with子句


如果你打算将：
with tab as（  ） 这样的子句放到物理表视图中，那么rpd将会让你失望。因为rpd中的视图实质上是一个形如 select * from ( ) tab 的子查询。而如果你要将with放到子查询中，将会影响biee前端自动生成with 子句。如果你要用with子句写查询语句，简易先 create view yourviewname as 来建立一个视图，然后再在物理层中调用。

### Session variable 可以放到物理层

你可以将VALUEOF(NQSESSION.RQVAR) 在物理层中引用Session Variable，然后通过在前端使用request variable来修改session variable的值。

### BIEE的timestamp类型的日期运算：推算前n天，后n天，前n月，后n月等。

使用timestampdiff（）函数，可控制的粒度可以细到秒，粗到年！

### 利用biee的提示,将展示变量传递到会话变量

#### 背景：

1. 一个服务器变量 TABLE_NAME_INOUT，又叫 session variable , 对应前端是 request variable  ， 该变量需要保存一个表名，该表名具有INOUT的特征。
2. 在业务上，为业务人员设计了一个提示框，二选1，对于业务，是切换客户层级，而对于后台，是切换数据表。
3. 关系梳理： 用户提示：客户层级切换  <—> 后台表名切换
4. 需要在这中间 添加一个转换机制 ：输入 ： 储蓄/资产 ， 转换为 ： DPSIT/ASSET


#### 设计：
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

####其他tips：

1. 默认值的填写： 如果是服务器变量，直接填写 : var_name , 不需要 valueof , 也不需要 nq_session 
2. 如果是 变量表达式：就是表示变量：格式：@{pv} 即可。有默认值也可以添加默认值。

# 异常处理

### ora-32034:unsupported use of with clause at OCI call OCIstmtExecute.

解决办法：检查rpd物理层子查询中是否有with子句。有的话，改成子查询的形式。



<s>本文最后更新于: 2015-11-09 14:46</s>

本文最后更新于: 2015-11-10 11:37


