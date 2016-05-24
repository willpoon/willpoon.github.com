Title: Macro(宏)：让excel处理化繁为简
Slug:  excelMacro
Authors: Poon


请通过以下链接查看图文版本：

http://mp.weixin.qq.com/s?__biz=MzAwMDgwMDAyOA==&mid=502864067&idx=1&sn=b3dfbc8a73268f599547d5fbd3bf3581#rd

今天向大家介绍 excel 的 宏。

#  问题背景

做bi数据处理，免不了经常处理excel的数据。

当通过excel提供的数据不符合我们的要求的时候，我们常常要调整格式、布局等等。

当要调整的表格只有一两个的时候，我们只要手工调整即可。

但是如果要调整的数据有几十份上百份，你还手工调吗？

作为程序员，我第一时间考虑是否能够通过编程的方式，做批量处理。

幸运的是，对于excel，有vba可以用于程序化计算和处理。

但问题来了，我对excel vba 并不熟悉，虽然知道vba很强大，能完成很多工作，但是我却不知道从哪里入手！

在这种情况下，很可能我只是想写一个很简单的批处理功能，但由于对语法、类库、方法函数等不熟悉，就要耗费大量的时间来google语法和函数功能，调用方法。

怎么破？

这时，我想起了excel有宏的功能。

# 宏

宏，这个名字，听起来给人很高深莫测的感觉，让人以为是什么高大上的东西。其实 它只是 英文 macro的中文翻译。macro 就是 ‘巨大’ ，‘宏大’的意思。

macro 是一种脚本语言。称之为 宏，表示 该 脚本功能强大，能够实现excel普通情况下不能实现的功能。

宏的本质是一种脚本，也就是vbs (visual basic script) . 但是却不需要我们自己编写。它可以通过excel自动生成。

# 宏的录制

宏脚本是通过录制来生成的。

所谓录制，就是excel 把一系列的操作 用 vbs 语言表示出来，然后组合成一个过程，又或者说一段可在excel中执行的程序，从而达到批处理的效果。

## view -> record macro  点击录制按钮

## store macro in ... 指定宏的位置：可以是当前工作簿，也可以自己建一个专门保存宏的工作簿。

## shortcut key 为宏设置执行的快捷键

## 录制过程

点击ok开始录制之后，excel就会将你的操作通过vba脚本按顺序记录起来。直到你结束宏的录制为止。

比如我对3个sheet页，每个sheet页都做了一次文本复制，生成的宏脚本如下：

```vba
Sub Macro9()
'
' Macro9 Macro
'
' Keyboard Shortcut: Option+Cmd+j
'
    Sheets("Sheet1").Select
    Range("A1:B1").Select
    Selection.Copy
    Range("B3").Select
    ActiveSheet.Paste
    Sheets("Sheet2").Select
    Range("A1:B1").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("B3").Select
    ActiveSheet.Paste
'
    Sheets("Sheet3").Select
    Range("A1:B1").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("B3").Select
    ActiveSheet.Paste
    Application.CutCopyMode = False
    ActiveWorkbook.Save
End Sub
```

同时，这段脚本也是可以编辑的。

## 结束录制

只要点击 stop Record(停止按钮的位置和开始录制一样) ， 就可以停止录制宏。

# 宏的好处

1. 一次录制，多次执行。
2. 把多个重复繁琐的操作，封装成一键操作。
3. 可以保存操作。
4. 可以自定义和修改。
5. 可以分发和复用。

...

注意：由于我的电脑不是windows，用的是mac版的excel，所以界面和windows有所差异。



本文首发于微信公众号： **`BI实验室`** ，微信搜索 **`BI实验室`** 或 **`magicof01`** ，也可以扫描下方二维码快速关注哦！

![求关注forIMX3](http://www.imx3.com/img/weixin_bi_common/sdr_code_tree.png)
