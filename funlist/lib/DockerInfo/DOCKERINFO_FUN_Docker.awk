#========================================================================#
# 名称: DOCKERINFO_FUN_Docker
# 版本: 
# 时间: 
# 备注: 
#
#========================================================================#

#----------函数----------------------------------------------------------#
# 如下去除空格，TAB，换行符等用户自定义函数。
# 正则中的+或*都可实现
# 此文件使用 awk -f 载入。

# 去掉变量左边的空白符
#function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }
function ltrim(s) { sub(/^[[:blank:]]*/, "", s); return s }
# 去掉变量右边的空白符
#function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s }
function rtrim(s) { sub(/[[:blank:]]*$/, "", s); return s }
# 去除首尾空格(可展开，非单行)
function trim(s) { 
	return rtrim(ltrim(s)); 
}
#----------函数----------------------------------------------------------#

#----------主体----------------------------------------------------------#
BEGIN{
	#FS="\n";
	FS=RS; #RS默认是一个换行符
	if(OutFile != "") print "#!/bin/bash" > OutFile  #=>输出到文件
	i=0
}
/Containers/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_Containers=\""trim(a[2])"\""; #容器数量
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_Containers=\""trim(a[2])"\"" >> OutFile
	}
}
/Running/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_Running=\""trim(a[2])"\""; #运行中的容器数量
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_Running=\""trim(a[2])"\"" >> OutFile
	}
}
/Paused/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_Paused=\""trim(a[2])"\""; #暂停中的容器数量
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_Paused=\""trim(a[2])"\"" >> OutFile
	}
}
/Stopped/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_Stopped=\""trim(a[2])"\""; #停止的容器数量
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_Stopped=\""trim(a[2])"\"" >> OutFile
	}
}
/Images/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_Images=\""trim(a[2])"\""; #镜像数量
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_Images=\""trim(a[2])"\"" >> OutFile
	}
}
/Server Version/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_ServerVersion=\""trim(a[2])"\""; #Docker版本
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_ServerVersion=\""trim(a[2])"\"" >> OutFile
	}
}
/Storage Driver/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_StorageDriver=\""trim(a[2])"\""; #存储驱动
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_StorageDriver=\""trim(a[2])"\"" >> OutFile
	}
}
/Logging Driver/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_LoggingDriver=\""trim(a[2])"\""; #日志驱动
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_LoggingDriver=\""trim(a[2])"\"" >> OutFile
	}
}
/Cgroup Driver/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_CgroupDriver=\""trim(a[2])"\""; #Cgroup驱动
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_CgroupDriver=\""trim(a[2])"\"" >> OutFile
	}
}
/Kernel Version/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_KernelVersion=\""trim(a[2])"\""; #内核版本
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_KernelVersion=\""trim(a[2])"\"" >> OutFile
	}
}
/Operating System/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_OperatingSystem=\""trim(a[2])"\""; #操作系统
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_OperatingSystem=\""trim(a[2])"\"" >> OutFile
	}
}
/OSType/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_OSType=\""trim(a[2])"\""; #操作系统类型
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_OSType=\""trim(a[2])"\"" >> OutFile
	}
}
/Architecture/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_Architecture=\""trim(a[2])"\""; #架构
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_Architecture=\""trim(a[2])"\"" >> OutFile
	}
}
/CPUs/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_CPUs=\""trim(a[2])"\""; #CPU数量(拥有的CPU资源)
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_CPUs=\""trim(a[2])"\"" >> OutFile
	}
}
/Total Memory/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_TotalMemory=\""trim(a[2])"\""; #内存数量(拥有的内存资源)
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_TotalMemory=\""trim(a[2])"\"" >> OutFile
	}
}
/Name/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_HostName=\""trim(a[2])"\""; #主机名
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_HostName=\""trim(a[2])"\"" >> OutFile
	}
}
/ID:/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, " ");
	
	# 输出
	print "DOCKERINFO_VAR_System_ID=\""trim(a[2])"\""; #ID
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_ID=\""trim(a[2])"\"" >> OutFile
	}
}
/Docker Root Dir/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_DockerRootDir=\""trim(a[2])"\""; #Docker根目录
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_DockerRootDir=\""trim(a[2])"\"" >> OutFile
	}
}
/Registry:/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, " ");
	
	# 输出
	print "DOCKERINFO_VAR_System_Registry=\""trim(a[2])"\""; #注册表
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_Registry=\""trim(a[2])"\"" >> OutFile
	}
}
/provider/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, "=");
	
	# 输出
	print "DOCKERINFO_VAR_System_Provider=\""trim(a[2])"\""; #提供商
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_Provider=\""trim(a[2])"\"" >> OutFile
	}
}
/^ http/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_RegistryMirrors["i"]=\""trim($1)"\""; #注册表镜像
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_RegistryMirrors["i"]=\""trim($1)"\"" >> OutFile
	}
	i++
}
/Product License/{
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, ":");
	
	# 输出
	print "DOCKERINFO_VAR_System_ProductLicense=\""trim(a[2])"\""; #产品协议
	# =>输出到文件
	if(OutFile != "") {
		print "DOCKERINFO_VAR_System_ProductLicense=\""trim(a[2])"\"" >> OutFile
	}
}
END {
    
}
#----------主体----------------------------------------------------------#

