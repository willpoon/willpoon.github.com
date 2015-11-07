Title: Oracle BIEE 经验总结
Date: 2015-11-06 11:12
Modified: 2015-11-07 22:12
Category: Tech
Tags: oracle,biee,BI
Slug: oracle-biee-develop
Authors: Poon
Summary:  使用biee开发前前后有也有两年多了，对oracle这套产品，也有一点小小心得，在此总结一下，抛砖引玉。持续更新中...

# 前言
使用biee开发前前后有也有两年多了，对oracle这套产品，也有一点小小心得，在此总结一下，抛砖引玉。持续更新中...

# 经验技巧
## physical layer 不支持with子句


如果你打算将：
with tab as（  ） 这样的子句放到物理表视图中，那么rpd将会让你失望。因为rpd中的视图实质上是一个形如 select * from ( ) tab 的子查询。而如果你要将with放到子查询中，将会影响biee前端自动生成with 子句。如果你要用with子句写查询语句，简易先 create view yourviewname as 来建立一个视图，然后再在物理层中调用。

## Session variable 可以放到物理层
你可以将VALUEOF(NQSESSION.RQVAR) 在物理层中引用Session Variable，然后通过在前端使用request variable来修改session variable的值。

# 异常处理

## ora-32034:unsupported use of with clause at OCI call OCIstmtExecute.

解决办法：检查rpd物理层子查询中是否有with子句。有的话，改成子查询的形式。
