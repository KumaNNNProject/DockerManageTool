---
title: ��ȡDocker��Ϣ
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

# ��ȡDocker��Ϣ

 ԭ��



���ô˽ű��ɻ�ȡ��ȡDocker��Ϣ�����ú��ڽű�������������ر�����������Щ������ɵõ���ص�ֵ�������б������������½ڡ�

**ע��**�������ڽű��е��ò���������Щ����������������Ч��

���뺯�����ļ�`Docker.info.funlist` ����������غ������ɡ�����Ϊ����������ļ���

```bash
source Docker.info.funlist

DOCKERINFO_FUN_Docker
# DOCKERINFO_FUN_Docker  "/tmp/"
# echo '�ܹ�:' ${DOCKERINFO_VAR_System_Architecture}
```



## �����ʼ�

**��ע**��

����ǰ׺��`DOCKERINFO_VAR_`

����ǰ׺��`DOCKERINFO_FUN_`

**ʾ��** 

```shell
ǰ׺Item
#��
DOCKERINFO_FUN_Docker
DOCKERINFO_VAR_System_<VarName>
```

��ߵĲ����շ巨



## ϵͳ������Ϣ 

docker�����Ϣ����汾����Ŀ¼�ȡ�

�ļ�����`Docker.info.funlist`



����ʵ�֣� `docker info`

�������ƣ� `DOCKERINFO_FUN_Docker`

�����б�

* `��������` : ��������(ֵ���) : ��ע
* `DOCKERINFO_VAR_System_Containers` : �������� 
* `DOCKERINFO_VAR_System_Running` : �����е���������
* `DOCKERINFO_VAR_System_Paused` : ��ͣ�е���������
* `DOCKERINFO_VAR_System_Stopped` : ֹͣ����������
* `DOCKERINFO_VAR_System_Images` : ��������
* `DOCKERINFO_VAR_System_ServerVersion` : Docker�汾
* `DOCKERINFO_VAR_System_StorageDriver` : �洢����
* `DOCKERINFO_VAR_System_LoggingDriver` : ��־����
* `DOCKERINFO_VAR_System_CgroupDriver` : Cgroup����
* `DOCKERINFO_VAR_System_KernelVersion` : �ں˰汾
* `DOCKERINFO_VAR_System_OperatingSystem` : ����ϵͳ
* `DOCKERINFO_VAR_System_OSType` : ����ϵͳ����
* `DOCKERINFO_VAR_System_Architecture` : �ܹ� 
* `DOCKERINFO_VAR_System_CPUs` : CPU���� : ӵ�е�CPU��Դ
* `DOCKERINFO_VAR_System_TotalMemory` : �ڴ����� : ӵ�е��ڴ���Դ
* `DOCKERINFO_VAR_System_HostName` : ������
* `DOCKERINFO_VAR_System_ID` : ID
* `DOCKERINFO_VAR_System_DockerRootDir` : Docker��Ŀ¼
* `DOCKERINFO_VAR_System_Registry` : ע���
* `DOCKERINFO_VAR_System_Provider` : �ṩ��
* `DOCKERINFO_VAR_System_RegistryMirrors[0]` : ע�����
* `DOCKERINFO_VAR_System_ProductLicense` : ��ƷЭ��



## �ο��Ķ�

 
