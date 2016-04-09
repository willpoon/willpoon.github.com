Title: control-m和informatica如何和perl/python搭配让干活不累
Slug: perl_control-m_informatica
Authors: Poon

# 引言

今天聊聊BI中的著名调度工具control-m和著名抽数工具informatica. 这两个工具都有一个共同的特点，支持以xml方式配置作业。

做个小调查，用到 control-m 或者 informatica 的朋友，你们是怎么开发调度作业和接口抽取配置的？是采用可视化原厂提供的可视化配置工具，还是另有捷径？

我所在的项目，采用excel + perl+xml+control-m/informatica 命令行来开发/配置 control-m调度作业和抽数作业配置。

为甚么用perl ? 因为perl 有excel工具包，还有 xml 工具包。而perl的作用，是把 配置在excel中的调度信息解析成xml，然后利用 control-m 的命令行工具，把 xml格式的 job任务配置写入到control-m/EM 服务器中，最后通过 control-m/desktop 上传到control-m server 。

# 优势
这样做的好处是什么呢？ 

1. 所有jobs的配置都可以通过excel来配置&维护。
2. 不需要通过频繁点control-m/desktop上的菜单／窗口，就能添加作业信息。
3. 可以批量。这是最最最最重要的一点。
4. 可以批量增删改。

...

# 关键

那这样做的难点又是什么呢？

1. perl程序的开发。(当然，这里不仅限于用perl，比如python也可以，如果你熟悉)。 perl程序的主要功能是从excel中把作业的配置信息解析出来，然后转换成xml格式的文件。
2. 依赖关系的确定。一个作业的执行，有可能依赖很多其他上游作业。要把这些作业都梳理出来，是细活，很花时间。不要紧，因为我们有perl/python 。 我们可以用perl来解析存储过程，然后把里面依赖的表都抓出来，然后建立表和作业之间的依赖关系。最终形成  `当前作业－ 上游作业` 之间的映射关系，填到excel配置中。

所以，其实我们不但用perl/python 来帮我们把excel转成xml , 还用 perl/python 来输出 作业之间的依赖关系，更进一步， 还可以 输出 每个作业的其他各种信息，比如：所在层次，调度方式，调度id，作业名称,变量设置...等等。

最终，我们实际上只用执行两个脚本：

1. 辅助excel配置的perl脚本
2. 把excel转成xml的perl脚本

就完成整个control-m / informatica 的作业配置。

然后再写一个加载脚本，就把作业加载到中央服务器中了。

# 总结

使用perl/python 配置的最重要意义，是减少手工操作，实现批量作业的增删改。降低了开发难度，同时提高了生产效率。试想，你是找一个懂excel的容易，还是找一个懂control-m/informatica的人容易捏？



![bottom求关注](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yGH30FHU6SYaJPqvibh7Wib9Pg2V6rc7zjaPJ7aKk9NcpQb9IIhZLCIG8CB4b0QV2vKWopevlhvafw/0?wx_fmt=png)

