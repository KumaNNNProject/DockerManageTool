#========================================================================#
# 名称: SYSINFO_FUN_Software_Memory
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
	
	# 内置函数
	# atan2(y, x) : 返回y/x的值。
	#               参阅：[9.1.2数值函数](https://www.gnu.org/software/gawk/manual/html_node/Numeric-Functions.html#Numeric-Functions)
	# sprintf(format, expression1, …) : 返回(不打印)printf用相同参数打印出来的字符串。
	#                                   参阅：[9.1.3字符串操作函数](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions)
	# 保留2个小数位
	UsePercent=sprintf("%.2f",atan2(trim($3),trim($2))*100)
	
	# 输出
	print "SYSINFO_VAR_Software_Memory_Total=\""trim($2)"\""; #内存总数
	print "SYSINFO_VAR_Software_Memory_Used=\""trim($3)"\""; #已用内存
	print "SYSINFO_VAR_Software_Memory_Free=\""trim($4)"\""; #空闲内存
	print "SYSINFO_VAR_Software_Memory_Available=\""trim($7)"\""; #可用内存	
	print "SYSINFO_VAR_Software_Memory_UsePercent=\""UsePercent"%\""; #使用率
		
	# =>输出到文件
	if(OutFile != "") {
		print "SYSINFO_VAR_Software_Memory_Total=\""trim($2)"\"" > OutFile
		print "SYSINFO_VAR_Software_Memory_Used=\""trim($3)"\"" > OutFile
		print "SYSINFO_VAR_Software_Memory_Free=\""trim($4)"\"" > OutFile
		print "SYSINFO_VAR_Software_Memory_Available=\""trim($7)"\"" > OutFile
		print "SYSINFO_VAR_Software_Memory_UsePercent=\""UsePercent"%\"" > OutFile
	}
}
END {
    
}
#----------主体----------------------------------------------------------#

