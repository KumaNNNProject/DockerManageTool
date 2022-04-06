---
title: 获取Docker信息
date: 2020-03-24 17:28:31
updated: 2020-03-24 17:28:31
mathjax: false
categories: 
tags:
typora-root-url: Readme
typora-copy-images-to: Readme
top: 1
comments: false
---

# 获取Docker信息

 原文



调用此脚本可获取获取Docker信息。调用后将在脚本环境中设置相关变量，引用这些变量便可得到相关的值。变量列表参阅下文相关章节。

**注意**：必须在脚本中调用才能引用这些变量，命令行中无效。

引入函数库文件`Docker.info.funlist` ，并调用相关函数即可。其它为函数库相关文件。

```bash
source Docker.info.funlist

DOCKERINFO_FUN_Docker
# DOCKERINFO_FUN_Docker  "/tmp/"
# echo '架构:' ${DOCKERINFO_VAR_System_Architecture}
```



## 开发笔记

**备注**：

变量前缀：`DOCKERINFO_VAR_`

函数前缀：`DOCKERINFO_FUN_`

**示例** 

```shell
前缀Item
#如
DOCKERINFO_FUN_Docker
DOCKERINFO_VAR_System_<VarName>
```

后边的采用驼峰法



## 系统基本信息 

docker相关信息，如版本，根目录等。

文件名：`Docker.info.funlist`



技术实现： `docker info`

函数名称： `DOCKERINFO_FUN_Docker`

变量列表：

* `变量名称` : 变量含义(值相关) : 备注
* `DOCKERINFO_VAR_System_Containers` : 容器数量 
* `DOCKERINFO_VAR_System_Running` : 运行中的容器数量
* `DOCKERINFO_VAR_System_Paused` : 暂停中的容器数量
* `DOCKERINFO_VAR_System_Stopped` : 停止的容器数量
* `DOCKERINFO_VAR_System_Images` : 镜像数量
* `DOCKERINFO_VAR_System_ServerVersion` : Docker版本
* `DOCKERINFO_VAR_System_StorageDriver` : 存储驱动
* `DOCKERINFO_VAR_System_LoggingDriver` : 日志驱动
* `DOCKERINFO_VAR_System_CgroupDriver` : Cgroup驱动
* `DOCKERINFO_VAR_System_KernelVersion` : 内核版本
* `DOCKERINFO_VAR_System_OperatingSystem` : 操作系统
* `DOCKERINFO_VAR_System_OSType` : 操作系统类型
* `DOCKERINFO_VAR_System_Architecture` : 架构 
* `DOCKERINFO_VAR_System_CPUs` : CPU数量 : 拥有的CPU资源
* `DOCKERINFO_VAR_System_TotalMemory` : 内存数量 : 拥有的内存资源
* `DOCKERINFO_VAR_System_HostName` : 主机名
* `DOCKERINFO_VAR_System_ID` : ID
* `DOCKERINFO_VAR_System_DockerRootDir` : Docker根目录
* `DOCKERINFO_VAR_System_Registry` : 注册表
* `DOCKERINFO_VAR_System_Provider` : 提供商
* `DOCKERINFO_VAR_System_RegistryMirrors[0]` : 注册表镜像
* `DOCKERINFO_VAR_System_ProductLicense` : 产品协议



## 参考阅读

 
