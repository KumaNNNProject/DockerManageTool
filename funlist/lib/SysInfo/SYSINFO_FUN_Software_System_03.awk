#========================================================================#
# 名称: SYSINFO_FUN_Software_System 03
# 版本: 
# 时间: 
# 备注: cut -d: -f1 /etc/group
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
	#FS=" ";
	#if(OutFile != "") print "#!/bin/bash" >> OutFile  #=>输出到文件
	str=""
}
{			
	if (str != "") str=str","$1
	if (str == "") str=$1
	
	# 输出
	print "SYSINFO_VAR_Software_System_GroupList["NR"]=\""$1"\"";  # 组
	if(OutFile != "") print "SYSINFO_VAR_Software_System_GroupList["NR"]=\""$1"\"" >> OutFile #=>输出到文件	
}

END {    
	# 输出
	print "SYSINFO_VAR_Software_System_Groups=\""NR"\"";  # 组数量	
	if(OutFile != "") print "SYSINFO_VAR_Software_System_Groups=\""NR"\"" >> OutFile #=>输出到文件
	print "SYSINFO_VAR_Software_System_GroupList[0]=\""str"\"";  # 组列表
	if(OutFile != "") print "SYSINFO_VAR_Software_System_GroupList[0]=\""str"\"" >> OutFile #=>输出到文件
}
#----------主体----------------------------------------------------------#

