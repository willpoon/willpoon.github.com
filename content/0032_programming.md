Title: Code Code Code!
Slug: programming
Authors: Poon

[TOC]


# python 

## __ 双下划线开头的
 __ 两根下划线开头的，表示类私有的，不能直接调用。只能在类的内部访问。

## self 关键字

1. self 是一个指针 

2. self 和 this 可以替换着用。但是用了self就要一直用self，用了this就一直用this，不能混用。

3. self代表的是这个类的实例。 

4. self 不是关键字，作为参数，不能省略。即，如果函数里有对self的调用，就要先列在函数参数里头。

## __class__ 

is a built-in attribute of every class instance (of every class). It is a reference to the class that self is an instance of (in this case, the counter class).

__class__ 是一个内建属性。每一个类实例都有。它是self实例所对应的类的引用。 也就是说，通过__class__ ， 我们可以知道我们现在是在哪个类里面捣鼓。

http://www.diveintopython.net/object_oriented_framework/class_attributes.html


