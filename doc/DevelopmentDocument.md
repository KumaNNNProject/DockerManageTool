---
title: Docker 管理工具 - 开发文档
date: 2020-04-10 22:04:50
updated: 2020-04-10 22:04:50
mathjax: false
categories: 
tags:
typora-root-url: DevelopmentDocument
typora-copy-images-to: DevelopmentDocument
top: 1
comments: false
---

# Docker 管理工具 - 开发文档

本地 Docker 管理工具，Linux下命令行工具。

shell本身是面向过程的开发，但本工具开发中，将使用大量的自定义函数，来处理复杂的任务。

## 开发环境

开发语言： `bash`

运行环境： `Linux`  (Docker主机中，非Windows或MacOS)



## 运行原理

将状态数据保存到脚本文件，以变量赋值的形式，并加载，使环境中有这些变量。(设置保存时的时间戳)

**写**操作(更新，删除等)时，重新将状态数据保存到脚本文件，并加载。(更新时间戳)

**读**操作时，根据超时设置，从环境中读取变量或加载脚本文件，以获取数据。



## 开发规范

### 函数前缀

* `Infos_*`  :  采集数据
* `Show_*`  :  显示数据
* `Action_*`  :  动作
* `Menu_*`  : 菜单

部分函数无前缀。



### 变量前缀

**普通变量**

`*`  单体变量， `*[@]`  数组变量，`<id>_*`  子数据单体变量， `<id>_*[@]` 子数据数组变量。

后边的采用驼峰法。

 * `INFO_Images_*` :  
 * `INFO_Images_*[@]` :  
 * `INFO_Images_<id>_*` :  
 * `INFO_Images_<id>_*[@]` :  
 * `INFO_Containers_*` :  
 * `INFO_Containers_*[@]` :  
 * `INFO_Containers_<id>_*` :  
 * `INFO_Containers_<id>_*[@]` :  
 * `INFO_Networks_*` :  
 * `INFO_Networks_*[@]` :  
 * `INFO_Networks_<id>_*` :  
 * `INFO_Networks_<id>_*[@]` :  
 * `INFO_Volumes_*` :  
 * `INFO_Volumes_*[@]` :  
 * `INFO_Volumes_<id>_*` :  
 * `INFO_Volumes_<id>_*[@]` :  

其它，参考源码。



**系统级变量**

后边的采用驼峰法。

* `SYS_*`



### 目录结构

#### 基本目录

* `conf/` : 配置目录
  * `dm.conf` ：系统默认配置，请勿修改。
  * `user.conf` : 用户自定义配置。此配置会覆盖`dm.conf`中的配置。
* `doc/` : 文档
* `funlist/` : 函数库(**核心**)
  * `lib/` : 第三方库
  * `Menu/` : 菜单函数库
  * `dm.*.funlist` : 核心函数文件
    * `Action` : 动作函数
    * `Infos` : 采集数据函数
    * `Show` : 显示数据函数
    * `Helpers` : 辅助函数
* `lang/` : 语言目录
  * `about/` : 关于
    * 存放关于菜单中的内容。
  * 包含相关的语言文件，以后缀区分不同语言。
  * 注意，此后缀和配置文件中的要一样，区分大小写。
  * 目前只提供**简体中文**和**英文**。
* `dm` : 启动文件

#### 缓存目录

`缓存根目录`  : 在配置文件中设置

* `Log/`
  * `Containers/Containers.log` : 容器日志
  * `Images/Images.log` : 镜像日志
  * `Networks/Networks.log` : 网络日志
  * `Volumes/Volumes.log` : 卷日志
* `Images/`
  * `Data_Images.sh`
  * `Sub/`
    * `DATA_Images_${ID}.sh`
* `Containers/`
  * `Data_Containers.sh`
  * `Sub/`
    * `DATA_Containers_${ID}.sh`
* `Networks/`
  * `Data_Networks.sh`
  * `Sub/`
    * `DATA_Networks_${ID}.sh`
* `Volumes/`
  * `Data_Volumes.sh`
  * `Sub/`
    * `DATA_Volumes_${ID}.sh`
* `Searchs/`
  * `Data_Searchs.sh`
  * `Sub/`
    * `DATA_Searchs_${ID}.sh`



## 模块

### 采集数据

采集并存储状态数据，时效数据(如运行多久)不存储。

将采集的数据以变量赋值的形式(`key=value`)存储到shell脚本，以缓存数据。

变量命名遵循开发规范，具体的变量，参阅源码。

**Docker中的数据主要有如下几大块**：

* 镜像：`Infos_Images`   `Infos_Image`
* 容器：`Infos_Containers`   `Infos_Container`
* 网络：`Infos_Networks`  `Infos_Network`
* 卷： `Infos_Volumes`  `Infos_Volume`

**其它的数据有**：

* 搜索： `Infos_Searchs`   `Infos_Search`
* 关于： `Infos_About`

均为函数名

Docker本身提供了获取相关信息的命令，将命令获取的数据，通过字符分割，来提取所需的数据。

```shell
docker image inspect --format="{{.Id}}#'{{.Created}}'#{{.DockerVersion}}#'{{.Author}}'#{{.Architecture}}#{{.Os}}#{{.Size}}"  ${ID}
```



### 显示数据

将采集的数据以一定的格式或排版显示在命令行界面中。

数据显示，大部分都对小屏幕进行适配。

* `Show_*` : 无后缀为调度中心。根据设置和屏幕宽度，调用相应的函数。
* `Show_*_Small` : 小屏
* `Show_*_Full` : 满屏

**Docker中的需要显示的数据主要有如下几大块**：

* 镜像：`Show_Images`   `Show_Image`
* 容器：`Show_Containers`   `Show_Container`
* 网络：`Show_Networks`  `Show_Network`
* 卷： `Show_Volumes`  `Show_Volume`

**其它的数据有**：

* 搜索： `Show_Searchs`   `Show_Search`
* 关于： `Show_About`
* 日志 `Show_Logs`
* 仪表盘： `Show_Dashboard`

均为函数名



### 菜单

命令行界面的菜单，面向用户的。

根据菜单项，操作docker。菜单脚本位于`funlist/Menu/`。

用户输入可用`read` 命令读取，在显示完菜单项后，用`read`等待用户输入。因此，需要一个菜单处理函数，处理各菜单的输入。

如源码中的`Menu_Handle`函数。显示菜单项的函数在显示完其内容后，末尾调用`Menu_Handle`函数来等待用户输入，并处理用户输入。详细参阅源码中的`Menu_Handle`函数。

> 这将导致函数嵌套函数，但不影响使用。

**有一些通用的菜单：**

* 头部：`Menu_Top`
* 导航条：`Menu_Nav`
* 脚部：`Menu_Footer`

这些函数中的线条长度会根据终端窗口的宽度自动输出相应长度的字符。

可在配置中设置线条最大长度。

**当前的菜单级别如下所示：**

```shell
主菜单
   仪表盘(独立lib:系统硬件基本信息，软件基本信息，docker基本信息等)
   镜像管理
     镜像列表
     导入镜像
     导出镜像
     拉取镜像
     清理镜像	
   容器管理
     容器列表
     运行容器(TODO List)
     导入容器(TODO)
     导出容器
   网络管理
     网络列表
     创建网络
     删除网络
     清理网络
   卷管理
     卷列表
     创建卷
     删除卷
     清理卷
   搜索管理
     搜索镜像
     搜索清理
   其它
     刷新缓存  
     读取日志
     清理日志 
     Docker信息 
     设置
     关于
```

部分菜单未实现。

> 环境变量(不采集存储，直接使用命令env)
>
> 注：未采集使用env



### 动作

**动作**，为控制器，是为菜单界面调用的。

包括  启动 ，停止 ，删除；列表， 搜索， 拉取， 导出，导入等操作。

动作函数(`Action_*`)中根据菜单的输入，调用数据采集(`Infos`)，或显示数据(`Show`)。

具体的操作提取到`ActionHandle` 函数，位于`dm.Helpers.funlist`文件。

动作函数(`Action_*`) 内置了日志记录功能，根据操作的成功与否，来记录相关日志。



**操作的成功与否** ，一开始使用如下结构，但因其是子shell环境，其内的修改不能影响外面。

```shell
(
	#command
) && (
	echo '执行成功'
) || (
	echo '执行失败'
) 
```

所以，全部修改，采用`if`判断状态码，`ActionHandle` 函数能提供状态码。

```shell
if [ "$?" == "0" ];then
	# 成功
else
	# 失败
fi
```

这样，在`if`中的更改，加载的变量，均能在后面继续使用。



## 调用关系

各模块的调用关系如下

```shell
Menu => Action  =>  CacheHandle(Infos) | Show
```

`Menu` 调用 `Action`  调用  `CacheHandle(Infos)` 或 `Show`

其中`CacheHandle`为缓存处理，参阅下文。



## 其它

### 缓存机制

本工具特色之一是，将数据缓存，并加载到当前环境中，以变量的形式存在。

因此，提供了一个处理缓存的函数(`CacheHandle`)，此函数将接管`Infos` ，动作(`Action` )通常需要通过此函数来调用数据(`Infos`) 。

**采集数据**时，会同时生成时间戳在相应的文件内。初始化，刷新缓存，和一些写操作时，都会进行数据采集。

缓存处理函数(`CacheHandle`)，会根据当前的时间戳和文件中的时间戳，计算差值，并根据配置文件中的设置，决定是否要重新采集数据(刷新缓存)。

> 注意： `Search`内建缓存机制在`Infos_Searchs`里。

* 时间戳: `Infos`  中生成
  * `Search`只有`Infos_Search`有时间戳



### 日志系统

内置了日志系统，记录一些写操作。并可在本工具中读取查阅。

**日志字段**

```shell
ID#时间#项#动作#目标(动作对象ID)#结果#原文
```

`ID`: LOG时间戳

`结果`：成功`Success`  ，失败`Fail`

文件后缀： `*.log`



### 辅助函数

包括 `CacheHandle` ，`ActionHandle`，`ImportImage` 在内的一些辅助函数，在文件`dm.Helpers.funlist`中。



## 初始化流程

工具的初始化，在启动文件(`dm`)中，先加载各种函数库文件，再执行相关函数，如加载配置的函数，目录结构的函数，数据采集的函数等。最后跳转到主菜单函数(`Menu_Main`)。



## BUG修复

* [x] 镜像删除，不能用ID，不同标签的镜像同ID
* [x] 镜像删除后详情数据更新不准确
* [x] 日志修复，部分记录中 某些字段显示为空
* [x] 详情菜单修复，未显示的菜单也能操作，需要屏蔽操作



## TODO

* [ ] 运行容器
  * 独立开发一套相关的容器管理工具，基本配置，资源配置，配置管理等。
  * `配置模版=>配置文件=>命令源文|运行容器`
  * 配置模版生成配置文件，按需修改此配置文件。根据此配置文件输出并保存命令源文和各种其它命令所需的文件。根据配置文件运行容器。
* [ ] 导入容器
  * 开发类似镜像导入的函数，独立处理容器的导入
* [ ] 导出容器
  * 开发类似镜像导出的函数，独立处理容器的导出
* [ ] 容器更新
  * 功能未实现，由于知识的缺少。
* [ ] API
  * `Api_*`
  * 跨平台跨语言，提供通用格式数据，如json
* [ ] `docker-compose` 深入开发
* [ ] +内嵌原生shell，直接操作原生文件系统。





## 参考阅读

 
