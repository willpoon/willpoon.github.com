Title: 如何在vim中使用快捷键插入时间戳
Date: 2015-11-08 11:15
Modified: 2015-11-08 11:15
Category: Tech
Tags: vim,hotkeys,edit
Slug: a-shortcut-to-insert-timestamp-in-vim-editor
Authors: Poon
Summary: 使用pelican+markdown写博客，总是要手动输入日期时间，很是麻烦，作为一个geek，怎能忍受每次都手工修改日期这种事情发生呢？所以，必须找到一种能够一键插入时间戳的方法！
 11 对于这种雕虫小技，stackoverflow早已经说烂了，于是...

使用pelican+markdown写博客，总是要手动输入日期时间，很是麻烦，作为一个geek，怎能忍受每次都手工修改日期这种事情发生呢？所以，必须找到一种能够一键插入时间戳的方法！
对于这种雕虫小技，stackoverflow早已经说烂了，于是，随便找了[一篇](http://stackoverflow.com/questions/56052/best-way-to-insert-timestamp-in-vim)

~/.vimrc命令:

    nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
    imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

按f3的输出效果输出效果

     2015-11-08 Sun 11:06 AM

.vimrc 命令：

    nmap <F4> a<C-R>=strftime("%Y-%m-%d %H:%M")<CR><Esc>
    imap <F4> <C-R>=strftime("%Y-%m-%d %I:%M")<CR>

按f4的输出效果输出效果：

      2015-11-08 11:06


注意：f3的时间戳格式是不适合放在pelican的Date: 和 Modified 里的。f4才是。


现在，展示f3的用法：

                                                        本文于 2015-11-08 Sun 11:23 AM 首次编辑！


That's it !

Enjoy!
