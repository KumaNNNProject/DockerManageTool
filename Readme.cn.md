---
title: Docker 管理工具
date: 2020-04-10 22:00:49
updated: 2020-04-10 22:00:49
mathjax: false
categories: 
tags:
  - Readme
typora-root-url: Readme
typora-copy-images-to: Readme
top: 1
comments: false
---


# Docker 管理工具



本地 Docker 管理工具，Linux下命令行工具。

采用bash编写的源码，无需其它外部依赖。



## 运行原理

将状态数据保存到脚本文件，以变量赋值的形式，并加载，使环境中有这些变量。(设置保存时的时间戳)

**写**操作(更新，删除等)时，重新将状态数据保存到脚本文件，并加载。(更新时间戳)

**读**操作时，根据超时设置，从环境中读取变量或加载脚本文件，以获取数据。



## 功能

管理本地Docker主机的：

* 镜像
* 容器
* 网络
* 数据卷

其它功能：

* 搜索镜像
* 拉取镜像

 

## 语言

具有多语言切换的能力，当前只提供了 **简体中文**和**英文** 两种语言



## 使用

在Docker主机中，运行命令：

```shell
./dm
```

> SSH登录Docker主机：
>
> ```shell
>  docker-machine ssh <Name>
>  #示例
>  docker-machine ssh default
> ```



## 示例

**菜单界面** 

```
=============================================================
XXXXXXXXXXXXXXXXXXXXX Docker Management XXXXXXXXXXXXXXXXXXXXX
-------------------------------------------------------------
主机名: MyDocker(default)   主机IP(Hip): 192.168.99.104
=============================================================
主菜单
      1.仪表盘
      2.镜像管理
      3.容器管理
      4.网络管理
      5.卷管理
      6.搜索管理
      7.其它
-------------------------------------------------------------
      Exit: 退出
=============================================================
请输入:
```



```
========================================================================
XXXXXXXXXXXXXXXXXXXXXXXXXX Docker Management XXXXXXXXXXXXXXXXXXXXXXXXXX
------------------------------------------------------------------------
Host name: MyDocker(default)   Host IP(Hip): 192.168.99.104
========================================================================
Main menu
      1.Dashboard
      2.Images Manage
      3.Containers Manage
      4.Networks Manage
      5.Volumes Manage
      6.Searchs Manage
      7.Other
------------------------------------------------------------------------
      Exit: Exit
========================================================================
Please input:
```






## 参考阅读

 
