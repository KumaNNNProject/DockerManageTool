---
title: ��ȡϵͳ��Ϣ
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

# ��ȡϵͳ��Ϣ

 ԭ��



���ô˽ű��ɻ�ȡϵͳ����Ӳ����Ϣ�����ú��ڽű�������������ر�����������Щ������ɵõ���ص�ֵ�������б������������½ڡ�

**ע��**�������ڽű��е��ò���������Щ����������������Ч��

ͨ��ֻ������ļ�`sysinfo.sh` ���ɣ�`*.funlist`Ϊ�����⣬����Ϊ����������ļ���

`sysinfo.sh` �����ĵ����£�

```
��ȡϵͳ ��Ӳ�� ��Ϣ
                ���ú��ڵ�ǰ������������Ӧ����
                ֻ�ʺ��ڽű��е���

sysinfo.sh  [Type] [Item]  [CacheDir] [arg1]  [arg2]  [arg3]  [arg4]  [arg5]  [arg6]
���÷�ʽ: ./  source  sh
    Type : ����(Hardware|Software)
           Ĭ��: ����
    Item : ��
           ��ǰ֧�ֵ���:
                        CPU
                        HardDisk
                        System
                        Storage
                        Memory
                        Loadavg
                        Network
CacheDir : ����Ŀ¼(�� /tmp/cache/)
           /��β

ʾ��:
./sysinfo.sh  Hardware  CPU  /tmp/cache/
sh sysinfo.sh Software
source sysinfo.sh
```



## �����ʼ�

**��ע**��

����ǰ׺��`SYSINFO_VAR_`

Ӳ������ǰ׺��`SYSINFO_VAR_Hardware_`

�������ǰ׺��`SYSINFO_VAR_Software_`

����ǰ׺��`SYSINFO_FUN_`

Ӳ������ǰ׺��`SYSINFO_FUN_Hardware_`

�������ǰ׺��`SYSINFO_FUN_Software_`

**ʾ��** 

```shell
ǰ׺Item
#��
SYSINFO_FUN_Hardware_CPU
SYSINFO_VAR_Hardware_CPU_<VarName>
```

��ߵĲ����շ巨



## Ӳ��������Ϣ 

Ӳ�������Ϣ�����ͺţ������ȡ�

�ļ�����`Hardware.info.funlist`

### CPU

����ʵ�֣� `lscpu`

�������ƣ� `SYSINFO_FUN_Hardware_CPU`

�����б�

* `��������` : ��������(ֵ���) : ��ע
* `SYSINFO_VAR_Hardware_CPU_ModelName` : �ͺ����� 
* `SYSINFO_VAR_Hardware_CPU_MHz` : CPU��Ƶ
* `SYSINFO_VAR_Hardware_CPU_Sockets` : CPU����� 
* `SYSINFO_VAR_Hardware_CPU_CoresPerSocket` : ÿ�����CPU����/ÿ������CPU����
* `SYSINFO_VAR_Hardware_CPU_ThreadsPerCore` : ÿ�������߳�����
* `SYSINFO_VAR_Hardware_CPU_CPUs` : �߼�CPU����/���߳���
* `SYSINFO_VAR_Hardware_CPU_Architecture` : �ܹ� 
* `SYSINFO_VAR_Hardware_CPU_CPUOpModes[0]` : CPU����ģʽ
  * `[0]` �� ����ȫ�ġ������±��ֵΪ�����ŷָ���ַ�����
* `SYSINFO_VAR_Hardware_CPU_L1dCache` : һ�����ݻ���
* `SYSINFO_VAR_Hardware_CPU_L1iCache` : һ��ָ���
* `SYSINFO_VAR_Hardware_CPU_L2Cache` : ��������
* `SYSINFO_VAR_Hardware_CPU_L3Cache` : ��������
* `SYSINFO_VAR_Hardware_CPU_VirtualizationType[0]` : CPU֧�ֵ����⻯����
  * `[0]` �� ����ȫ�ġ������±��ֵΪ�����ŷָ���ַ�����
* `SYSINFO_VAR_Hardware_CPU_NUMANodes` : NUMA�ڵ�����
* `SYSINFO_VAR_Hardware_CPU_BogoMIPS` : Ԥ��MIPSֵ
* `SYSINFO_VAR_Hardware_CPU_is64bit` : �Ƿ�֧��64bit(`1`:��|`0`:��)



**�鿴cpu�Ƿ�֧��64bit**

```shell
lscpu | grep 'Flags' | grep ' lm ' | wc -l
cat /proc/cpuinfo | grep 'flags' | grep ' lm ' | wc -l
```

�������0, ˵��֧��64bit���㡣 lmָlong mode, ֧��lm����64bit    
`wc -l ` : ͳ�ƻ��з�

`' lm '` : ������Ҫ�пո�

### �ڴ� 

����ʵ�֣� 

�������ƣ� 

�����б�



### Ӳ��

����ʵ�֣� `lsblk`

�������ƣ� `SYSINFO_FUN_Hardware_HardDisk`

�����б�

* `��������` : ��������(ֵ���) : ��ע
* `SYSINFO_VAR_Hardware_HardDisk_Name[0]` : �豸���� : NAME
* `SYSINFO_VAR_Hardware_HardDisk_RM[0]` : ���ƶ��豸 : RM
* `SYSINFO_VAR_Hardware_HardDisk_RO[0]` : ֻ���豸 : RO
* `SYSINFO_VAR_Hardware_HardDisk_Type[0]` : �豸���� : TYPE
* `SYSINFO_VAR_Hardware_HardDisk_Size[0]` : �豸��С : SIZE
* `SYSINFO_VAR_Hardware_HardDisk_MountPoint[0]` : �豸���ص� : MOUNTPOINT
* `SYSINFO_VAR_Hardware_HardDisk_Label[0]` : �ļ�ϵͳ��ǩ : LABEL
* `SYSINFO_VAR_Hardware_HardDisk_FSType[0]` : �ļ�ϵͳ���� : FSTYPE
* `SYSINFO_VAR_Hardware_HardDisk_Owner[0]` : �û��� : OWNER
* `SYSINFO_VAR_Hardware_HardDisk_Group[0]` : ���� : GROUP
* `SYSINFO_VAR_Hardware_HardDisk_Mode[0]` : �豸�ڵ�Ȩ�� : MODE
* `SYSINFO_VAR_Hardware_HardDisk_Rota[0]` : ��ת�豸(`0`:������ת\<ssd>|`1`:����ת\<hdd>) : ROTA
* `SYSINFO_VAR_Hardware_HardDisk_Tran[0]` : �豸�������� : TRAN
* `SYSINFO_VAR_Hardware_HardDisk_Vendor[0]` : �豸��Ӧ�� : VENDOR
* `SYSINFO_VAR_Hardware_HardDisk_MajMin[0]` : ��Ҫ:��Ҫ�豸��� : MAJ:MIN
* `SYSINFO_VAR_Hardware_HardDisk_Maj[0]` : ��Ҫ�豸���
* `SYSINFO_VAR_Hardware_HardDisk_Min[0]` : ��Ҫ�豸���  



�����豸�Ķ���ģ�����ȫ��ʹ�����飬ͨ���±������������

`��Ҫ:��Ҫ�豸���` : �������������������ĸ����̵ġ�ͨ��`��Ҫ`ָ���Ǵ��̣�`��Ҫ`ָ����

```
lsblk -P -o NAME,RM,RO,TYPE,SIZE,MOUNTPOINT,LABEL,FSTYPE,OWNER,GROUP,MODE,ROTA,TRAN,VENDOR,MAJ:MIN
```



### ����

����ʵ�֣� 

�������ƣ� 

�����б�



## ���������Ϣ

��������Ϣ����ϵͳ��������Դʹ�����ȡ�

�ļ�����`Software.info.funlist`

### ϵͳ

����ʵ�֣� ��������`��ע`��

�������ƣ� `SYSINFO_FUN_Software_System`

�����б�

* `��������` : ��������(ֵ���) : ��ע
* `SYSINFO_VAR_Software_System_OSName` : ����ϵͳ���� : `uname -o`
* `SYSINFO_VAR_Software_System_OSType` : ����ϵͳ���� : `uname -s`
* `SYSINFO_VAR_Software_System_Architecture` : �ܹ� : `uname -m`
* `SYSINFO_VAR_Software_System_CoreName` : �ں����� : `uname -s`
* `SYSINFO_VAR_Software_System_CoreVersion` : �ں˰汾 : `uname -r`
* `SYSINFO_VAR_Software_System_HostName` : ������ : `hostname �� uname -n`
* `SYSINFO_VAR_Software_System_Users` : �û����� : `ͳ�� cut -d: -f1 /etc/passwd | wc -l`
* `SYSINFO_VAR_Software_System_UserList[0]` : �û��б� : `cut -d: -f1 /etc/passwd` 
  * `[0]` : ���ŷָ��洢���б������±�Ϊ����ֵ
* `SYSINFO_VAR_Software_System_Groups` : ������ : `ͳ�� cut -d: -f1 /etc/group | wc -l`
* `SYSINFO_VAR_Software_System_GroupList[0]` : ���б� : `cut -d: -f1 /etc/group` 
  * `[0]` : ���ŷָ��洢���б������±�Ϊ����ֵ



### ��Դ

#### �洢

����ʵ�֣� `df`  `df -Tk | grep -v "Use%"`

�������ƣ� `SYSINFO_FUN_Software_Storage`

�����б�

* `��������` : ��������(ֵ���) : ��ע
* `SYSINFO_VAR_Software_Storage_Name[0]` : �豸���� : Filesystem
* `SYSINFO_VAR_Software_Storage_Type[0]` : �ļ�ϵͳ���� : Type
* `SYSINFO_VAR_Software_Storage_Size[0]` : ��С : 1K-blocks
* `SYSINFO_VAR_Software_Storage_Used[0]` : ��ʹ�� : Used
* `SYSINFO_VAR_Software_Storage_Available[0]` : ����: Available
* `SYSINFO_VAR_Software_Storage_UsePercent[0]` : ʹ����: Use%
* `SYSINFO_VAR_Software_Storage_MountedOn[0]` : ���ص� : Mounted on



��ֵ��λΪk��ȫΪ���飬ͨ�������±����



#### �ڴ�

����ʵ�֣� `free `  `free -k | grep "Mem"`

�������ƣ�  `SYSINFO_FUN_Software_Memory`

�����б�

* `��������` : ��������(ֵ���) : ��ע
* `SYSINFO_VAR_Software_Memory_Total`  : �ڴ����� : total
* `SYSINFO_VAR_Software_Memory_Used`  : �����ڴ� : used
* `SYSINFO_VAR_Software_Memory_Free`  : �����ڴ� : free
* `SYSINFO_VAR_Software_Memory_Available`  : �����ڴ� : available
* `SYSINFO_VAR_Software_Memory_UsePercent`  : ʹ����



ֻ�ɼ������ڴ�

��ֵ��λΪk��



#### ϵͳ����

����ʵ�֣� `cat /proc/loadavg �� uptime`

�������ƣ�  `SYSINFO_FUN_Software_Loadavg`

�����б�

* `��������` : ��������(ֵ���) : ��ע
* `SYSINFO_VAR_Software_Loadavg_UpTime`  : ϵͳ����ʱ�� : `uptime -s`  
* `SYSINFO_VAR_Software_Loadavg_RunTime[0]`  : ϵͳ����ʱ�� : `uptime `   
  * `[0]` : ϵͳ����ʱ��(��)
  * `[1]` : ��ʽ��12�� 5ʱ 38�� 4��
  * `[2]` : ��ʽ��12Days 5Hours 38Minutes 4Seconds
  * `[3]` : ��ʽ��12d.5:38:4
  * `[4]` : ��ʽ��12.5:38:4 
* `SYSINFO_VAR_Software_Loadavg_OnlineUsers`  : �����û����� : `uptime `   
* `SYSINFO_VAR_Software_Loadavg_1Minutes`  : ���1���ӵ�CPU��IO������ : `cat /proc/loadavg`   
* `SYSINFO_VAR_Software_Loadavg_5Minutes`  : ���5���ӵ�CPU��IO������ : `cat /proc/loadavg`   
* `SYSINFO_VAR_Software_Loadavg_15Minutes`  : ���15���ӵ�CPU��IO������ : `cat /proc/loadavg`   
* `SYSINFO_VAR_Software_Loadavg_ProcessRunning`  : �������еĽ����� : `cat /proc/loadavg`   
* `SYSINFO_VAR_Software_Loadavg_ProcessTotal`  : �������� : `cat /proc/loadavg`   



#### ����

����ʵ�֣�  `ifconfig �� ip`   `route  �� ip `

�������ƣ�  `SYSINFO_FUN_Software_Network`

�����б�

* `��������` : ��������(ֵ���) : ��ע
* `SYSINFO_VAR_Software_Network_InterfaceName[0]`  : �ӿ����� :
* `SYSINFO_VAR_Software_Network_LinkType[0]`  : �������� :
  * `SYSINFO_VAR_Software_Network_LinkType_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Mac[0]`  : Ӳ��(mac)��ַ :
  * `SYSINFO_VAR_Software_Network_Mac_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_IPv4[0]`  : IPv4 :
  * `SYSINFO_VAR_Software_Network_IPv4_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_IPv6[0]`  : IPv6 :
  * `SYSINFO_VAR_Software_Network_IPv6_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Bcast[0]`  : �㲥��ַ :
  * `SYSINFO_VAR_Software_Network_Bcast_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Mask[0]`  : �������� :
  * `SYSINFO_VAR_Software_Network_Mask_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_IPv4Scope[0]`  : IPv4��Χ :
  * `SYSINFO_VAR_Software_Network_IPv4Scope_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_IPv6Scope[0]`  : IPv6��Χ :
  * `SYSINFO_VAR_Software_Network_IPv6Scope_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Up[0]`  : �����ѿ���(1:��|0:��) :
  * `SYSINFO_VAR_Software_Network_Up_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Connected[0]`  : ����������(1:��|0:��) : `RUNNING`
  * `SYSINFO_VAR_Software_Network_Connected_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Multicast[0]`  : ֧�ֶಥ(1:��|0:��) :
  * `SYSINFO_VAR_Software_Network_Multicast_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_MTU[0]`  : ����䵥Ԫ :
  * `SYSINFO_VAR_Software_Network_MTU_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Broadcast[0]`  : ֧�ֹ㲥(1:��|0:��) :
  * `SYSINFO_VAR_Software_Network_Broadcast_<InterfaceName>`
* `SYSINFO_VAR_Software_Network_Loopback[0]`  : �ػ��ӿ�(1:��|0:��) :
  * `SYSINFO_VAR_Software_Network_Loopback_<InterfaceName>`



ע�⣺ `<InterfaceName>` �м��`-`�ѱ��滻Ϊ�ա��� `br-79f6f0e6dc97` =��`br79f6f0e6dc97`



**�ض���ip����ı���**

* `SYSINFO_VAR_Software_Network_Pointopoint[0]`  : ��Ե�ͨѶ(1:��|0:��) 
  * `SYSINFO_VAR_Software_Network_Pointopoint_<InterfaceName>`  
* `SYSINFO_VAR_Software_Network_Promisc[0]`  : ������������(1:��|0:��) 
  * `SYSINFO_VAR_Software_Network_Promisc_<InterfaceName>` 
* `SYSINFO_VAR_Software_Network_Allmulti[0]`  : �������жಥ���ݰ�(1:��|0:��) 
  * `SYSINFO_VAR_Software_Network_Allmulti_<InterfaceName>` 
* `SYSINFO_VAR_Software_Network_Dynamic[0]`  : ��̬�ӿ�(1:��|0:��) 
  * `SYSINFO_VAR_Software_Network_Dynamic_<InterfaceName>`  



**�ض���ip����Ķ�̬����**

**key**: qdisc,state,group,qlen,master

* `SYSINFO_VAR_Software_Network_<key>[0]`  :  
  * `SYSINFO_VAR_Software_Network_<key>_<InterfaceName>`  




* `SYSINFO_VAR_Software_Network_Route_Destination[0]`  : Ŀ����������� : 
* `SYSINFO_VAR_Software_Network_Route_Genmask[0]`  : Ŀ������ : 
* `SYSINFO_VAR_Software_Network_Route_Gateway[0]`  : ���� : 
* `SYSINFO_VAR_Software_Network_Route_Iface[0]`  : �ӿ����� : 
* `SYSINFO_VAR_Software_Network_Route_Flags[0]`  : ��־ :  �ض��� `route`
* `SYSINFO_VAR_Software_Network_Route_Src[0]`  : ����ԴIP :  �ض��� `ip route`
* `SYSINFO_VAR_Software_Network_Route_Links[0]`  : ·���� : 
  * `�ӿ�<==>����<==>Ŀ�����������(Ŀ������):��־`
  * `eth1<==>0.0.0.0<==>192.168.99.0(255.255.255.0):U`
  * `�ӿ�(����ԴIP)<==>����<==>Ŀ�����������(Ŀ������)`
  * `eth1(192.168.99.104)<==>0.0.0.0<==>192.168.99.0(255.255.255.0)`



IP��Ϣ��·����Ϣ

 

## �ο��Ķ�

 
