---
title: 获取系统信息
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

# 获取系统信息

 原文



调用此脚本可获取系统的软硬件信息。调用后将在脚本环境中设置相关变量，引用这些变量便可得到相关的值。变量列表参阅下文相关章节。

**注意**：必须在脚本中调用才能引用这些变量，命令行中无效。

通常只需调用文件`sysinfo.sh` 即可，`*.funlist`为函数库，其它为函数库相关文件。

`sysinfo.sh` 帮助文档如下：

```
获取系统 软硬件 信息
                调用后将在当前环境中设置相应变量
                只适合在脚本中调用

sysinfo.sh  [Type] [Item]  [CacheDir] [arg1]  [arg2]  [arg3]  [arg4]  [arg5]  [arg6]
调用方式: ./  source  sh
    Type : 类型(Hardware|Software)
           默认: 所有
    Item : 项
           当前支持的项:
                        CPU
                        HardDisk
                        System
                        Storage
                        Memory
                        Loadavg
                        Network
CacheDir : 缓存目录(如 /tmp/cache/)
           /结尾

示例:
./sysinfo.sh  Hardware  CPU  /tmp/cache/
sh sysinfo.sh Software
source sysinfo.sh
```



## 开发笔记

**备注**：

变量前缀：`SYSINFO_VAR_`

硬件变量前缀：`SYSINFO_VAR_Hardware_`

软件变量前缀：`SYSINFO_VAR_Software_`

函数前缀：`SYSINFO_FUN_`

硬件函数前缀：`SYSINFO_FUN_Hardware_`

软件函数前缀：`SYSINFO_FUN_Software_`

**示例** 

```shell
前缀Item
#如
SYSINFO_FUN_Hardware_CPU
SYSINFO_VAR_Hardware_CPU_<VarName>
```

后边的采用驼峰法



## 硬件基本信息 

硬件相关信息，如型号，参数等。

文件名：`Hardware.info.funlist`

### CPU

技术实现： `lscpu`

函数名称： `SYSINFO_FUN_Hardware_CPU`

变量列表：

* `变量名称` : 变量含义(值相关) : 备注
* `SYSINFO_VAR_Hardware_CPU_ModelName` : 型号名称 
* `SYSINFO_VAR_Hardware_CPU_MHz` : CPU主频
* `SYSINFO_VAR_Hardware_CPU_Sockets` : CPU插槽数 
* `SYSINFO_VAR_Hardware_CPU_CoresPerSocket` : 每个插槽CPU核数/每颗物理CPU核数
* `SYSINFO_VAR_Hardware_CPU_ThreadsPerCore` : 每个核心线程数量
* `SYSINFO_VAR_Hardware_CPU_CPUs` : 逻辑CPU数量/总线程数
* `SYSINFO_VAR_Hardware_CPU_Architecture` : 架构 
* `SYSINFO_VAR_Hardware_CPU_CPUOpModes[0]` : CPU操作模式
  * `[0]` ： 完整全文。其它下标的值为按逗号分割的字符串。
* `SYSINFO_VAR_Hardware_CPU_L1dCache` : 一级数据缓存
* `SYSINFO_VAR_Hardware_CPU_L1iCache` : 一级指令缓存
* `SYSINFO_VAR_Hardware_CPU_L2Cache` : 二级缓存
* `SYSINFO_VAR_Hardware_CPU_L3Cache` : 三级缓存
* `SYSINFO_VAR_Hardware_CPU_VirtualizationType[0]` : CPU支持的虚拟化技术
  * `[0]` ： 完整全文。其它下标的值为按逗号分割的字符串。
* `SYSINFO_VAR_Hardware_CPU_NUMANodes` : NUMA节点数量
* `SYSINFO_VAR_Hardware_CPU_BogoMIPS` : 预估MIPS值
* `SYSINFO_VAR_Hardware_CPU_is64bit` : 是否支持64bit(`1`:是|`0`:否)



**查看cpu是否支持64bit**

```shell
lscpu | grep 'Flags' | grep ' lm ' | wc -l
cat /proc/cpuinfo | grep 'flags' | grep ' lm ' | wc -l
```

结果大于0, 说明支持64bit计算。 lm指long mode, 支持lm则是64bit    
`wc -l ` : 统计换行符

`' lm '` : 两边需要有空格

### 内存 

技术实现： 

函数名称： 

变量列表：



### 硬盘

技术实现： `lsblk`

函数名称： `SYSINFO_FUN_Hardware_HardDisk`

变量列表：

* `变量名称` : 变量含义(值相关) : 备注
* `SYSINFO_VAR_Hardware_HardDisk_Name[0]` : 设备名称 : NAME
* `SYSINFO_VAR_Hardware_HardDisk_RM[0]` : 可移动设备 : RM
* `SYSINFO_VAR_Hardware_HardDisk_RO[0]` : 只读设备 : RO
* `SYSINFO_VAR_Hardware_HardDisk_Type[0]` : 设备类型 : TYPE
* `SYSINFO_VAR_Hardware_HardDisk_Size[0]` : 设备大小 : SIZE
* `SYSINFO_VAR_Hardware_HardDisk_MountPoint[0]` : 设备挂载点 : MOUNTPOINT
* `SYSINFO_VAR_Hardware_HardDisk_Label[0]` : 文件系统标签 : LABEL
* `SYSINFO_VAR_Hardware_HardDisk_FSType[0]` : 文件系统类型 : FSTYPE
* `SYSINFO_VAR_Hardware_HardDisk_Owner[0]` : 用户名 : OWNER
* `SYSINFO_VAR_Hardware_HardDisk_Group[0]` : 组名 : GROUP
* `SYSINFO_VAR_Hardware_HardDisk_Mode[0]` : 设备节点权限 : MODE
* `SYSINFO_VAR_Hardware_HardDisk_Rota[0]` : 旋转设备(`0`:不可旋转\<ssd>|`1`:可旋转\<hdd>) : ROTA
* `SYSINFO_VAR_Hardware_HardDisk_Tran[0]` : 设备传输类型 : TRAN
* `SYSINFO_VAR_Hardware_HardDisk_Vendor[0]` : 设备供应商 : VENDOR
* `SYSINFO_VAR_Hardware_HardDisk_MajMin[0]` : 主要:次要设备编号 : MAJ:MIN
* `SYSINFO_VAR_Hardware_HardDisk_Maj[0]` : 主要设备编号
* `SYSINFO_VAR_Hardware_HardDisk_Min[0]` : 次要设备编号  



由于设备的多个的，所以全部使用数组，通过下标关联各变量。

`主要:次要设备编号` : 是用来关联分区属于哪个磁盘的。通常`主要`指的是磁盘，`次要`指分区

```
lsblk -P -o NAME,RM,RO,TYPE,SIZE,MOUNTPOINT,LABEL,FSTYPE,OWNER,GROUP,MODE,ROTA,TRAN,VENDOR,MAJ:MIN
```



### 网络

技术实现： 

函数名称： 

变量列表：



## 软件基本信息

软件相关信息，如系统参数，资源使用量等。

文件名：`Software.info.funlist`

### 系统

技术实现： 参阅下文`备注`列

函数名称： `SYSINFO_FUN_Software_System`

变量列表：

* `变量名称` : 变量含义(值相关) : 备注
* `SYSINFO_VAR_Software_System_OSName` : 操作系统名称 : `uname -o`
* `SYSINFO_VAR_Software_System_OSType` : 操作系统类型 : `uname -s`
* `SYSINFO_VAR_Software_System_Architecture` : 架构 : `uname -m`
* `SYSINFO_VAR_Software_System_CoreName` : 内核名称 : `uname -s`
* `SYSINFO_VAR_Software_System_CoreVersion` : 内核版本 : `uname -r`
* `SYSINFO_VAR_Software_System_HostName` : 主机名 : `hostname 或 uname -n`
* `SYSINFO_VAR_Software_System_Users` : 用户数量 : `统计 cut -d: -f1 /etc/passwd | wc -l`
* `SYSINFO_VAR_Software_System_UserList[0]` : 用户列表 : `cut -d: -f1 /etc/passwd` 
  * `[0]` : 逗号分隔存储的列表。其它下标为单个值
* `SYSINFO_VAR_Software_System_Groups` : 组数量 : `统计 cut -d: -f1 /etc/group | wc -l`
* `SYSINFO_VAR_Software_System_GroupList[0]` : 组列表 : `cut -d: -f1 /etc/group` 
  * `[0]` : 逗号分隔存储的列表。其它下标为单个值



### 资源

#### 存储

技术实现： `df`  `df -Tk | grep -v "Use%"`

函数名称： `SYSINFO_FUN_Software_Storage`

变量列表：

* `变量名称` : 变量含义(值相关) : 备注
* `SYSINFO_VAR_Software_Storage_Name[0]` : 设备名称 : Filesystem
* `SYSINFO_VAR_Software_Storage_Type[0]` : 文件系统类型 : Type
* `SYSINFO_VAR_Software_Storage_Size[0]` : 大小 : 1K-blocks
* `SYSINFO_VAR_Software_Storage_Used[0]` : 已使用 : Used
* `SYSINFO_VAR_Software_Storage_Available[0]` : 可用: Available
* `SYSINFO_VAR_Software_Storage_UsePercent[0]` : 使用率: Use%
* `SYSINFO_VAR_Software_Storage_MountedOn[0]` : 挂载点 : Mounted on



储值单位为k。全为数组，通过索引下标关联



#### 内存

技术实现： `free `  `free -k | grep "Mem"`

函数名称：  `SYSINFO_FUN_Software_Memory`

变量列表：

* `变量名称` : 变量含义(值相关) : 备注
* `SYSINFO_VAR_Software_Memory_Total`  : 内存总数 : total
* `SYSINFO_VAR_Software_Memory_Used`  : 已用内存 : used
* `SYSINFO_VAR_Software_Memory_Free`  : 空闲内存 : free
* `SYSINFO_VAR_Software_Memory_Available`  : 可用内存 : available
* `SYSINFO_VAR_Software_Memory_UsePercent`  : 使用率



只采集物理内存

储值单位为k。



#### 系统负载

技术实现： `cat /proc/loadavg 或 uptime`

函数名称：  `SYSINFO_FUN_Software_Loadavg`

变量列表：

* `变量名称` : 变量含义(值相关) : 备注
* `SYSINFO_VAR_Software_Loadavg_UpTime`  : 系统启动时间 : `uptime -s`  
* `SYSINFO_VAR_Software_Loadavg_RunTime[0]`  : 系统运行时间 : `uptime `   
  * `[0]` : 系统运行时间(秒)
  * `[1]` : 格式：12天 5时 38分 4秒
  * `[2]` : 格式：12Days 5Hours 38Minutes 4Seconds
  * `[3]` : 格式：12d.5:38:4
  * `[4]` : 格式：12.5:38:4 
* `SYSINFO_VAR_Software_Loadavg_OnlineUsers`  : 在线用户数量 : `uptime `   
* `SYSINFO_VAR_Software_Loadavg_1Minutes`  : 最后1分钟的CPU和IO利用率 : `cat /proc/loadavg`   
* `SYSINFO_VAR_Software_Loadavg_5Minutes`  : 最后5分钟的CPU和IO利用率 : `cat /proc/loadavg`   
* `SYSINFO_VAR_Software_Loadavg_15Minutes`  : 最后15分钟的CPU和IO利用率 : `cat /proc/loadavg`   
* `SYSINFO_VAR_Software_Loadavg_ProcessRunning`  : 正在运行的进程数 : `cat /proc/loadavg`   
* `SYSINFO_VAR_Software_Loadavg_ProcessTotal`  : 进程总数 : `cat /proc/loadavg`   



#### 网络

技术实现：  `ifconfig 或 ip`   `route  或 ip `

函数名称：  `SYSINFO_FUN_Software_Network`

变量列表：

* `变量名称` : 变量含义(值相关) : 备注
* `SYSINFO_VAR_Software_Network_InterfaceName[0]`  : 接口名称 :
* `SYSINFO_VAR_Software_Network_LinkType[0]`  : 链接类型 :
  * `SYSINFO_VAR_Software_Network_LinkType_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Mac[0]`  : 硬件(mac)地址 :
  * `SYSINFO_VAR_Software_Network_Mac_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_IPv4[0]`  : IPv4 :
  * `SYSINFO_VAR_Software_Network_IPv4_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_IPv6[0]`  : IPv6 :
  * `SYSINFO_VAR_Software_Network_IPv6_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Bcast[0]`  : 广播地址 :
  * `SYSINFO_VAR_Software_Network_Bcast_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Mask[0]`  : 子网掩码 :
  * `SYSINFO_VAR_Software_Network_Mask_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_IPv4Scope[0]`  : IPv4范围 :
  * `SYSINFO_VAR_Software_Network_IPv4Scope_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_IPv6Scope[0]`  : IPv6范围 :
  * `SYSINFO_VAR_Software_Network_IPv6Scope_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Up[0]`  : 网卡已开启(1:是|0:否) :
  * `SYSINFO_VAR_Software_Network_Up_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Connected[0]`  : 网线已连接(1:是|0:否) : `RUNNING`
  * `SYSINFO_VAR_Software_Network_Connected_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Multicast[0]`  : 支持多播(1:是|0:否) :
  * `SYSINFO_VAR_Software_Network_Multicast_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_MTU[0]`  : 最大传输单元 :
  * `SYSINFO_VAR_Software_Network_MTU_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Broadcast[0]`  : 支持广播(1:是|0:否) :
  * `SYSINFO_VAR_Software_Network_Broadcast_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Loopback[0]`  : 回环接口(1:是|0:否) :
  * `SYSINFO_VAR_Software_Network_Loopback_<InterfaceName>`



注意： `<InterfaceName>` 中间的`-`已被替换为空。如 `br-79f6f0e6dc97` =》`br79f6f0e6dc97`



**特定于ip命令的变量**

* `SYSINFO_VAR_Software_Network_Pointopoint[0]`  : 点对点通讯(1:是|0:否) 
  * `SYSINFO_VAR_Software_Network_Pointopoint_<InterfaceName>`  
* `SYSINFO_VAR_Software_Network_Promisc[0]`  : 监听所有流量(1:是|0:否) 
  * `SYSINFO_VAR_Software_Network_Promisc_<InterfaceName>` 
* `SYSINFO_VAR_Software_Network_Allmulti[0]`  : 接收所有多播数据包(1:是|0:否) 
  * `SYSINFO_VAR_Software_Network_Allmulti_<InterfaceName>` 
* `SYSINFO_VAR_Software_Network_Dynamic[0]`  : 动态接口(1:是|0:否) 
  * `SYSINFO_VAR_Software_Network_Dynamic_<InterfaceName>`  



**特定于ip命令的动态变量**

**key**: qdisc,state,group,qlen,master

* `SYSINFO_VAR_Software_Network_<key>[0]`  :  
  * `SYSINFO_VAR_Software_Network_<key>_<InterfaceName>`  




* `SYSINFO_VAR_Software_Network_Route_Destination[0]`  : 目标网络或主机 : 
* `SYSINFO_VAR_Software_Network_Route_Genmask[0]`  : 目标掩码 : 
* `SYSINFO_VAR_Software_Network_Route_Gateway[0]`  : 网关 : 
* `SYSINFO_VAR_Software_Network_Route_Iface[0]`  : 接口名称 : 
* `SYSINFO_VAR_Software_Network_Route_Flags[0]`  : 标志 :  特定于 `route`
* `SYSINFO_VAR_Software_Network_Route_Src[0]`  : 本地源IP :  特定于 `ip route`
* `SYSINFO_VAR_Software_Network_Route_Links[0]`  : 路由链 : 
  * `接口<==>网关<==>目标网络或主机(目标掩码):标志`
  * `eth1<==>0.0.0.0<==>192.168.99.0(255.255.255.0):U`
  * `接口(本地源IP)<==>网关<==>目标网络或主机(目标掩码)`
  * `eth1(192.168.99.104)<==>0.0.0.0<==>192.168.99.0(255.255.255.0)`



IP信息，路由信息

 

## 参考阅读

 
