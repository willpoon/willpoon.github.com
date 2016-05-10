Title:  windows:休眠和睡眠的区别你知道吗
Slug:  sleepVShiberation
Authors: Poon



（点击上方 **`BI实验室`** ↑↑，可快速关注）

商业智能(BI)领域，任务调度是重要一环。调度工作做得好不好，能体现出BI水平的高低。 如果使用操作系统自带的工具做任务调度，linux有crontab , 而windows有计划任务(task scheduler)。
最近我们需要通过计划任务来调度计算机的开关机和休眠睡眠问题。其中休眠和睡眠着实让我们困惑了一下。那么：

# 睡眠、休眠和混合睡眠之间有什么区别？

“睡眠”是一种节能状态，当您希望再次开始工作时，可使计算机快速恢复全功率工作（通常在几秒钟之内）。让计算机进入睡眠状态就像暂停 DVD 播发机一样：计算机会立即停止当前操作，并做好在您要继续工作时重新启动的准备。

“休眠”是一种主要为笔记本电脑设计的电源节能状态。睡眠通常会将工作和设置保存在内存中并消耗少量的电量，而休眠则将打开的文档和程序保存到硬盘中，然后关闭计算机。在 Windows 使用的所有节能状态中，休眠使用的电量最少。对于笔记本电脑，如果您知道将有很长一段时间不使用它，并且在那段时间不可能给电池充电，则您应使用休眠模式。

“混合睡眠”主要是为台式计算机设计的。混合睡眠是睡眠和休眠的组合 - 它将所有打开的文档和程序保存到内存和硬盘中，然后让计算机进入低耗能状态，以便可以快速恢复工作。这样，如果发生电源故障，Windows 可从硬盘中恢复您的工作。如果打开了混合睡眠，让计算机进入睡眠状态的同时，计算机也自动进入了混合睡眠状态。在台式计算机上，混合睡眠通常默认为打开状态。

`以上摘自：http://windows.microsoft.com/zh-CN/windows7/Sleep-and-hibernation-frequently-asked-questions`

总结：睡眠把数据存在内存，耗电多，但是恢复快。 休眠把数据存在硬盘，耗电少，但是恢复慢。

另外，经本人实测：睡眠之后，台式机的指示灯是亮着的；而休眠之后，台式机的指示灯是关闭的。


# 附录

## 睡眠命令

	Rundll32.exe powrprof.dll,SetSuspendState Sleep


## 休眠命令


	Rundll32.exe Powrprof.dll,SetSuspendState


`参考：http://unlockforus.blogspot.com/2008/03/shutdown-restart-lock-sleep-or.html`



本文首发于微信公众号： **`BI实验室`** ，微信搜索 **`BI实验室`** 或 **`magicof01`** ，也可以扫描下方二维码快速关注哦！

![求关注forIMX3](http://www.imx3.com/img/weixin_bi_common/sdr_code_tree.png)

![求关注forWeChat](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yGH30FHU6SYaJPqvibh7Wib9Pg2V6rc7zjaPJ7aKk9NcpQb9IIhZLCIG8CB4b0QV2vKWopevlhvafw/0?wx_fmt=png)


