写公众号的朋友，都会遇到在公众平台上发布文章的诸多琐事：填写标题、作者、格式调整、设置评论、赞赏、上传图片、设置封面...等等。本来写文章分享是一件很开心的事情，但是一想到要设置一大堆东西，感觉又没啥动力、分享意愿大减了不是？ 不但浪费时间，各种设置还很雷人。

公众号文章发布绝对是个体力活。一直在寻思如何从中解放。

近日我借助applescript自动化处理脚步，写了一个'发布机器人'，帮我把写好的文章自动上传到微信公众平台。


闲话休提， 看看机器人都有些什么：

# 机器人的功能如下：

1. 自动登录
2. 自动把公众号相关的图片上传
3. 自动填写文章标题、作者、文章正文
4. 自动格式化markdown标签
5. 自动保存

 # 待完善的功能

 1.摘要目前只能默认，后续打算填充指定的摘要内容。
 2.由于推送文章需要手机扫码认证，后续探索定时自动发送。
 3.自动拉取图片库的图片地址。

 # 机器人实现原理

## 简单来说：

 1. 模拟点击
 2. 模拟快捷键

## 业务流程：

1. 登录公众号
2. 素材管理
3. 新建图文消息
4. 填写标题、作者、正文
5. 上传封面和正文图片
6. 保存

##  技术要点

1. 单击操作
2. 剪贴板操作
3. 快捷键操作
4. 延时&等待
5. 过程调用
6. js调用
7. shell命令调用
...


## 实现工具

1. appleScript (主要代码)
2. shell script (命令封装)
3. java script (少量代码)
4. click 工具，命令行版。

BTW.这篇文章就是采用自动发布机器人发布的！

有兴趣的童鞋，可留言讨论哦。
由于代码较长，如果需要代码，也请在评论区给我评论留言。谢谢！



