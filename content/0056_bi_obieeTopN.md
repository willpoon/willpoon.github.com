Title:  biee:topN的本质
Slug:  obiee_topN
Authors: Poon



在使用biee取前N条数据的时候，我很好奇，为什么一个topN函数，就能把记录按指定列排序，并且过滤出来。于是我做了如下测试，看看obiee是怎么实现的：

## 逻辑sql

```sql

SET VARIABLE PREFERRED_CURRENCY='USD';SELECT
   0 s_0,
   "A - Sample Sales"."Julian Cal"."T50 Julian Day Num" s_1,
   topN("A - Sample Sales"."Julian Cal"."T50 Julian Day Num",12) s_2
FROM "A - Sample Sales"
ORDER BY 1, 2 ASC NULLS LAST
FETCH FIRST 5000001 ROWS ONLY

```

##  物理sql

```SQL

WITH 
SAWITH0 AS (select T42404.Julian_Day_Num as c1,
     Rank() OVER ( ORDER BY T42404.Julian_Day_Num DESC NULLS LAST ) as c2
from 
     BISAMPLE.SAMP_TIME_DAY_D T42404 /* D01 Time Day Grain */ ),
SAWITH1 AS (select D1.c1 as c1
from 
     SAWITH0 D1
where  ( case  when D1.c2 <= 12 then D1.c2 end  <= 12 ) ),
SAWITH2 AS (select D1.c1 as c1,
     D1.c2 as c2,
     D1.c3 as c3
from 
     (select 0 as c1,
               D1.c1 as c2,
               case  when Rank() OVER ( ORDER BY D1.c1 DESC NULLS LAST ) <= 12 then Rank() OVER ( ORDER BY D1.c1 DESC NULLS LAST ) end  as c3,
               ROW_NUMBER() OVER (PARTITION BY D1.c1 ORDER BY D1.c1 ASC) as c4
          from 
               SAWITH1 D1
     ) D1
where  ( D1.c4 = 1 ) )
select D1.c1 as c1, D1.c2 as c2, D1.c3 as c3 from ( select distinct D1.c1 as c1,
     D1.c2 as c2,
     D1.c3 as c3
from 
     SAWITH2 D1
order by c1, c2 ) D1 where rownum <= 5000001

```

# 分析

SAWITH0: 使用rank()为列值排序，添加序号
SAWITH1: 使用where过滤序号，取topN 的。
SAWITH2: 使用partition分组，使用 where D1.c4 = 1 去重。

总的来说，topN() 也就是把取数逻辑封装了一下而已。而且是显式封装：通过日志可以查到详细代码。

# 总结

1. 如果不清楚biee内置函数是怎么实现的，可以通过日志查其实现过程。加深对biee的理解。




本文首发于微信公众号： **`BI实验室`** ，微信搜索 **`BI实验室`** 或 **`magicof01`** ，也可以扫描下方二维码快速关注哦！

![求关注forIMX3](http://www.imx3.com/img/weixin_bi_common/sdr_code_tree.png)


