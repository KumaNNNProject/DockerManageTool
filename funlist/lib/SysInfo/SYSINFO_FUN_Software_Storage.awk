#========================================================================#
# 名称: SYSINFO_FUN_Software_Storage
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
	
	# 输出
	print "SYSINFO_VAR_Software_Storage_Name["NR-1"]=\""trim($1)"\""; #设备名称
	print "SYSINFO_VAR_Software_Storage_Type["NR-1"]=\""trim($2)"\""; #文件系统类型
	print "SYSINFO_VAR_Software_Storage_Size["NR-1"]=\""trim($3)"\""; #大小
	print "SYSINFO_VAR_Software_Storage_Used["NR-1"]=\""trim($4)"\""; #已使用
	print "SYSINFO_VAR_Software_Storage_Available["NR-1"]=\""trim($5)"\""; #可用
	print "SYSINFO_VAR_Software_Storage_UsePercent["NR-1"]=\""trim($6)"\""; #使用率
	print "SYSINFO_VAR_Software_Storage_MountedOn["NR-1"]=\""trim($7)"\""; #挂载点
		
	# =>输出到文件
	if(OutFile != "") {
		print "SYSINFO_VAR_Software_Storage_Name["NR-1"]=\""trim($1)"\"" > OutFile
		print "SYSINFO_VAR_Software_Storage_Type["NR-1"]=\""trim($2)"\"" > OutFile
		print "SYSINFO_VAR_Software_Storage_Size["NR-1"]=\""trim($3)"\"" > OutFile
		print "SYSINFO_VAR_Software_Storage_Used["NR-1"]=\""trim($4)"\"" > OutFile
		print "SYSINFO_VAR_Software_Storage_Available["NR-1"]=\""trim($5)"\"" > OutFile
		print "SYSINFO_VAR_Software_Storage_UsePercent["NR-1"]=\""trim($6)"\"" > OutFile
		print "SYSINFO_VAR_Software_Storage_MountedOn["NR-1"]=\""trim($7)"\"" > OutFile
	}
}
END {
    
}
#----------主体----------------------------------------------------------#

