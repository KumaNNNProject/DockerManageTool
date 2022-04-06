---
title: Docker Management Tool
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


# Docker Management Tool



Local docker management tool, command line tool under Linux.

The source code written by bash does not need other external dependence.



## Operation principle

Save the state data in the form of variable assignment to the script file. Then load them so that the variables are in the environment. (set time stamp when saving)

When **writing** (update, delete, etc.), save the status data to the script file again and load it. (update timestamp)

When **reading** operation,Depending on the timeout setting, read variables from the environment or load a script file to get data.



## Function

Managing local Docker hosts：

* Image
* Container
* Network
* Volume

Other functions：

* Search Image
* Pull Image

 


## Language

Multi language switching capability. Only **simplified Chinese** and **English** are currently available



## Use

In the Docker host, run the command：

```shell
./dm
```

> SSH login to docker host：
>
> ```shell
>  docker-machine ssh <Name>
>  #Examples
>  docker-machine ssh default
> ```



## Example

**Menu interface** 

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






## Reference reading

 
