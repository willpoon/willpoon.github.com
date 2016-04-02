Title: [翻译]OBIEE 11g – 如何让biee下载excel报表时不合并单元格？
Slug: biee_excel_merging_cells
Authors: Poon

[TOC]

# 中文译文

很多用户喜欢把biee报表导出到excel。但是，却被excel的自动合并单元格问题搞得头大。


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

And add the following lines anywhere in between <ServerInstance> and </ServerInstance>

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



# 英文原文

Title: OBIEE 11g – Unmerge Cells When Downloading OBI Reports to Excel
Slug: biee_excel_merging_cells
Authors: Poon
Status: draft


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

And add the following lines anywhere in between <ServerInstance> and </ServerInstance>

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


