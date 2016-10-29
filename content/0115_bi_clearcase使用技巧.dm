工作中需要用到clearcase 做版本管理。

当涉及文件更新的时候，需要先checkout，再checkin.

如果文件只有一两个则无所谓，但如果需要checkout的文件有几十上百个，那文件筛选过程是很痛苦的事情。

如何快速、准确选定文件并checkout，绕开痛苦的文件筛选过程呢？

我想起了命令行批处理的方式。经查询，有cleartool这个工具。

只要支持命令，就可以实现批量。

更新一个文件，需要先checkout，checkout的方式如下：

> cleartool co -c 'v20160921VERSIONCheckOout' CodeOfversion.java

checkout 之后，将新文件替换旧文件，然后check in ：

> cleartool ci -c 'v20160921VERSIONCheckOout' CodeOfversion.java

这样，对于多个文件，只需要指定需要check out 和 check in 的文件名作为参数即可。



