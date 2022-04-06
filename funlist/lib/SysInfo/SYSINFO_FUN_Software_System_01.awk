#========================================================================#
# 名称: SYSINFO_FUN_Software_System 01
# 版本: 
# 时间: 
# 备注: uname -osmrn
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
	# 输出
	print "SYSINFO_VAR_Software_System_OSName=\""trim($5)"\"";  #操作系统名称
	print "SYSINFO_VAR_Software_System_OSType=\""trim($1)"\"";  #操作系统类型
	print "SYSINFO_VAR_Software_System_Architecture=\""trim($4)"\"";  #架构
	print "SYSINFO_VAR_Software_System_CoreName=\""trim($1)"\"";  #内核名称
	print "SYSINFO_VAR_Software_System_CoreVersion=\""trim($3)"\"";  #内核版本
	print "SYSINFO_VAR_Software_System_HostName=\""trim($2)"\"";  #主机名
	# =>输出到文件
	if(OutFile != "") {
		print "SYSINFO_VAR_Software_System_OSName=\""trim($5)"\"" > OutFile
		print "SYSINFO_VAR_Software_System_OSType=\""trim($1)"\"" > OutFile
		print "SYSINFO_VAR_Software_System_Architecture=\""trim($4)"\"" > OutFile
		print "SYSINFO_VAR_Software_System_CoreName=\""trim($1)"\"" > OutFile
		print "SYSINFO_VAR_Software_System_CoreVersion=\""trim($3)"\"" > OutFile
		print "SYSINFO_VAR_Software_System_HostName=\""trim($2)"\"" > OutFile
	}	
}

END {
    
}
#----------主体----------------------------------------------------------#

