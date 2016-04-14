Title: smoke test 是什么鬼
Slug: smokeTest
Authors: Poon

（点击上方**`BI实验室`**↑↑，可快速关注）

#  学术解释

一术语源自硬件行业。对一个硬件或硬件组件进行更改或修复后，直接给设备加电。如果没有冒烟，则该组件就通过了测试。在软件中，“冒烟测试”这一术语描述的是在将代码更改嵌入到产品的源树中之前对这些更改进行验证的过程。在检查了代码后，冒烟测试是确定和修复软件缺陷的最经济有效的方法。冒烟测试设计用于确认代码中的更改会按预期运行，且不会破坏整个版本的稳定性。

  - 百度百科

Smoke testing refers to various classes of tests of systems, usually intended to determine whether they are ready for more robust testing. The expression probably was first used in plumbing in referring to tests for the detection of cracks, leaks or breaks in closed systems of pipes.

  - 微软学术


# 个人理解

也就是说，对于硬件系统，你要测试一个系统，再看它能否满足功能要求之前，至少要让这个系统运行起来，而不是一通电就冒烟烧坏了。

对于软件系统，你要测试一个程序，再看它能否满足功能要求之前，至少要让这个程序运行起来，而不是一执行就报错，或者crash掉。

硬件系统不冒烟，软件能够正常运行，才能进一步测试更加高级的功能。

就像你刚去电脑城装了一台电脑，你要先通电看能不能用，如果一通电就烧掉了，说明没装好。至少把电脑启动之后，能够看到熟悉的windows桌面，你才能进一步测试电脑的性能：玩游戏玩得卡不卡，画面是否逼真...等等。


![bottom求关注](https://mmbiz.qlogo.cn/mmbiz/sfKia69cLy1yGH30FHU6SYaJPqvibh7Wib9Pg2V6rc7zjaPJ7aKk9NcpQb9IIhZLCIG8CB4b0QV2vKWopevlhvafw/0?wx_fmt=png)

