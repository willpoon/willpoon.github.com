
Title: OBIEE 11g – 如何让biee下载excel报表时不合并单元格？
Slug: biee_excel_merging_cells
Authors: Poon

![0](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1xdOC12ZtaIrtlvJDzE49yT6zEoSJa6onbuzklkAGcCu7mXIzbakspj0a8icQdYRaUUSVkffuZGwDw/0?wx_fmt=gif)

[TOC]

# 中文译文

很多用户喜欢把biee报表导出到excel。但是，却被excel的自动合并单元格问题搞得头大。
例如，下图中的obiee 分析，先按 year,brand 分组、排序，然后按 office 汇总 revenue 。由于在 不同的office 之间有着相同的 year, brand ,结果 year , brand 列的列值就自动合并，没有一行行repeat出来：

![1](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yRcLEKR4kcy0feSrXjiaJuUOKw67HkJZr6EsEia5TYMSNHQDSyChghTicvB0HBr9kEe7nFibKLoMibgPA/0?wx_fmt=png)

当导出到excel的时候，结果中保留了在obiee报表中的原貌：被排序之后，相同列值会自动合并，而没有对每一行的每一个单元格作填充。如何解除这种导出到excel 时，单元格自动合并的问题呢？



![2](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yRcLEKR4kcy0feSrXjiaJuU89NAWWLiae7sCCYWRibuEQQ3T3h2NrEc9TkKoSoiaMgpm0n5I0sanCDSA/0?wx_fmt=png)


在 instanceconfig.xml 文件中：

```
 <EXALYTICS/OBIEE_HOME>/\Middleware\instances\instance1\config\OracleBIPresentationServicesComponent\coreapplication_obips1
```
将设置从：


```
 <WebConfig xmlns=”oracle.bi.presentation.services/config/v1.1″>
```

改为：

```xml

<WebConfig xmlns=”oracle.bi.presentation.services/config/v1.1″
xmlns:xsi=”http://www.w3.org/2001/XMLSchema-instance”>
```


并在 `<ServerInstance> ... </ServerInstance>` 标签内添加以下几行：

```xml 
<Download>
<Export xsi:type=”excel”>
<DataValue>UseFormattedValue</DataValue>
<RepeatRows>true</RepeatRows>
</Export>
</Download>

```

重启 OBIEE.

修改设置后，在biee报表中，会保留单元格合并的格式，但是在excel中，将会把具有相同列值的单元格拆分出来，一行一个列值地展示，如下图展示：

![3](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yRcLEKR4kcy0feSrXjiaJuU96dgcmJYrN9wtv7vXic2pCLw5qXJBQonjcAibLuUymm1hj4nJZvd11mg/0?wx_fmt=png)

参考文档: Doc ID 1930660.1

## poon的实测经验

经本人试验，对于单元格合并问题，总结出如下设置经验：

1. obiee 11.1.1.5.0 默认配置是：obiee报表上单元格自动合并。excel导出也是自动合并。
2. 如果打补丁打到 obiee 11.1.1.5.5 之后，obiee报表上单元格也是自动合并，但excel导出却会逐行显示。
3. 以上修改设置 11.1.1.5.x 不适用。只对 11.1.1.7 以上的版本才适用。
4. 如果让11.1.1.7.x 及以上的版本导出excel的时候，合并单元格，怎么设置？ 很简单，只需要把 `<RepeatRows>true</RepeatRows>` 改成 `<RepeatRows>false</RepeatRows>` 即可？
5. 11.1.1.5.5 (BP5) 有没有办法让导出来的excel自动合并单元格？答案是，我暂时没有找到。现在我使用 bp5 导出到excel的biee报表都是没有作列值合并的。

#  english version

Title: OBIEE 11g – Unmerge Cells When Downloading OBI Reports to Excel
Slug: biee_excel_merging_cells
Authors: Poon


Many users of OBI like the functionality of being to export OBI reports into excel. However, it can be frustrating for the user when excel automatically merges cells for them.

For example, the OBIEE report is doing a group sort by year, brand and then a sum by individual office.   With this group sort, the year and brand value are not repeated in each row and only display when the brand or year changes as shown in the screen shot below:

![1](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yRcLEKR4kcy0feSrXjiaJuUOKw67HkJZr6EsEia5TYMSNHQDSyChghTicvB0HBr9kEe7nFibKLoMibgPA/0?wx_fmt=png)


When  exported to Excel, it retains the distinct group sort look of the OBIEE  report, as shown below, but the preferred Excel display is to repeat the group sort columns in every row so that every cell in every row has a value.



![2](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yRcLEKR4kcy0feSrXjiaJuU89NAWWLiae7sCCYWRibuEQQ3T3h2NrEc9TkKoSoiaMgpm0n5I0sanCDSA/0?wx_fmt=png)


In the instanceconfig.xml file located in 

```
 <EXALYTICS/OBIEE_HOME>/\Middleware\instances\instance1\config\OracleBIPresentationServicesComponent\coreapplication_obips1
```
 change the following:

From:

```
 <WebConfig xmlns=”oracle.bi.presentation.services/config/v1.1″>
```

To:

```xml

<WebConfig xmlns=”oracle.bi.presentation.services/config/v1.1″
xmlns:xsi=”http://www.w3.org/2001/XMLSchema-instance”>
```

And add the following lines anywhere in between `<ServerInstance> and </ServerInstance>`

```xml
<Download>
<Export xsi:type=”excel”>
<DataValue>UseFormattedValue</DataValue>
<RepeatRows>true</RepeatRows>
</Export>
</Download>

```

Restart OBIEE.

After making these changes, the OBIEE report format will remain in group sort (merged cells) format, but the Excel report will show repeating values for the group sort as shown below:

![3](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yRcLEKR4kcy0feSrXjiaJuU96dgcmJYrN9wtv7vXic2pCLw5qXJBQonjcAibLuUymm1hj4nJZvd11mg/0?wx_fmt=png)

Reference: Doc ID 1930660.1

origin from : http://ecapitaladvisors.com/blog/obiee-11g-unmerge-cells-when-downloading-obi-reports-to-excel 


![orgin](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1zF5l0bmF3v9E7sWGzdx4ic7MeiaF5ZDvWyWAc9sODdhGPxhIcBMSEic2WIFP1BibMFd5Sq9E7fgsBs0g/0?wx_fmt=jpeg)



