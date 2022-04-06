#========================================================================#
# 名称: SYSINFO_FUN_Hardware_HardDisk
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
	FS=" ";
	if(OutFile != "") print "#!/bin/bash" > OutFile  #=>输出到文件
}
{	
	#print $1	
	#print "行:" NR
		
	# 分割字符串到数组
	# 内置函数: 9.1.3字符串操作函数
	# split(string, array [, fieldsep [, seps ] ])
	#   fieldsep: 分隔符，默认使用FS
	#   seps: gawk特有的扩展
	split(trim($1), a, "=");
	split(trim($2), b, "=");
	split(trim($3), c, "=");
	split(trim($4), d, "=");
	split(trim($5), e, "=");
	split(trim($6), f, "=");
	split(trim($7), g, "=");
	split(trim($8), h, "=");
	split(trim($9), i, "=");
	split(trim($10), j, "=");
	split(trim($11), k, "=");
	split(trim($12), l, "=");
	split(trim($13), m, "=");
	split(trim($14), n, "=");
	split(n[2], nn, ":");
	split(trim($15), o, "=");	
		
	# 搜索字符串
	# 内置函数: 9.1.3字符串操作函数
	# match(string, regexp [, array])
	# 找到，返回子字符串开始的字符位置(索引)
	# 找不到，则返回零
	where = match(o[2], /\"$/)
    if (where == 0) o[2]=o[2]"\""  #结尾无 "，添加 " 
	where2 = match(nn[1], /\"$/)
    if (where2 == 0) nn[1]=nn[1]"\""  #结尾无 "，添加 " 
	where3 = match(nn[2], /^\"/)
    if (where3 == 0) nn[2]="\""nn[2]  #首部无 "，添加 " 
	
	# 输出(arr[2]已包含双引号)
	print "SYSINFO_VAR_Hardware_HardDisk_Name["NR-1"]="a[2]; #设备名称
	print "SYSINFO_VAR_Hardware_HardDisk_RM["NR-1"]="b[2]; #可移动设备
	print "SYSINFO_VAR_Hardware_HardDisk_RO["NR-1"]="c[2]; #只读设备
	print "SYSINFO_VAR_Hardware_HardDisk_Type["NR-1"]="d[2]; #设备类型
	print "SYSINFO_VAR_Hardware_HardDisk_Size["NR-1"]="e[2]; #设备大小
	print "SYSINFO_VAR_Hardware_HardDisk_MountPoint["NR-1"]="f[2]; #设备挂载点
	print "SYSINFO_VAR_Hardware_HardDisk_Label["NR-1"]="g[2]; #文件系统标签
	print "SYSINFO_VAR_Hardware_HardDisk_FSType["NR-1"]="h[2]; #文件系统类型
	print "SYSINFO_VAR_Hardware_HardDisk_Owner["NR-1"]="i[2]; #用户名
	print "SYSINFO_VAR_Hardware_HardDisk_Group["NR-1"]="j[2]; #组名
	print "SYSINFO_VAR_Hardware_HardDisk_Mode["NR-1"]="k[2]; #设备节点权限
	print "SYSINFO_VAR_Hardware_HardDisk_Rota["NR-1"]="l[2]; #旋转设备(`0`:不可旋转\<ssd>|`1`:可旋转\<hdd>)
	print "SYSINFO_VAR_Hardware_HardDisk_Tran["NR-1"]="m[2]; #设备传输类型
	print "SYSINFO_VAR_Hardware_HardDisk_MajMin["NR-1"]="n[2]; #主要:次要设备编号
	print "SYSINFO_VAR_Hardware_HardDisk_Maj["NR-1"]="nn[1]; #主要设备编号
	print "SYSINFO_VAR_Hardware_HardDisk_Min["NR-1"]="nn[2]; #次要设备编号
	print "SYSINFO_VAR_Hardware_HardDisk_Vendor["NR-1"]="o[2]; #设备供应商
		
	# =>输出到文件(arr[2]已包含双引号)
	if(OutFile != "") {
		print "SYSINFO_VAR_Hardware_HardDisk_Name["NR-1"]="a[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_RM["NR-1"]="b[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_RO["NR-1"]="c[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_Type["NR-1"]="d[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_Size["NR-1"]="e[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_MountPoint["NR-1"]="f[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_Label["NR-1"]="g[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_FSType["NR-1"]="h[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_Owner["NR-1"]="i[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_Group["NR-1"]="j[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_Mode["NR-1"]="k[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_Rota["NR-1"]="l[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_Tran["NR-1"]="m[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_MajMin["NR-1"]="n[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_Maj["NR-1"]="nn[1] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_Min["NR-1"]="nn[2] > OutFile
		print "SYSINFO_VAR_Hardware_HardDisk_Vendor["NR-1"]="o[2] > OutFile
	}
}
END {
    
}
#----------主体----------------------------------------------------------#

