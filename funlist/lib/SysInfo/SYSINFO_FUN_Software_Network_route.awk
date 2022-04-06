#========================================================================#
# 名称: SYSINFO_FUN_Software_Network_route
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
	#FS=RS; #RS默认是一个换行符
	#if(OutFile != "") print "#!/bin/bash" > OutFile  #=>输出到文件
}
{
	Links=trim($8)"<==>"trim($2)"<==>"trim($1)"("trim($3)"):"trim($4)
	# 输出 
	print "SYSINFO_VAR_Software_Network_Route_Destination["NR-1"]=\""trim($1)"\""; #目标网络或主机
	print "SYSINFO_VAR_Software_Network_Route_Gateway["NR-1"]=\""trim($2)"\""; #网关
	print "SYSINFO_VAR_Software_Network_Route_Genmask["NR-1"]=\""trim($3)"\""; #目标掩码
	print "SYSINFO_VAR_Software_Network_Route_Iface["NR-1"]=\""trim($8)"\""; #接口名称
	print "SYSINFO_VAR_Software_Network_Route_Links["NR-1"]=\""trim(Links)"\""; #路由链
	# 特定于 route 的变量
	print "SYSINFO_VAR_Software_Network_Route_Flags["NR-1"]=\""trim($4)"\""; #标志
	# =>输出到文件 
	if(OutFile != "") {
		print "SYSINFO_VAR_Software_Network_Route_Destination["NR-1"]=\""trim($1)"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Route_Gateway["NR-1"]=\""trim($2)"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Route_Genmask["NR-1"]=\""trim($3)"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Route_Iface["NR-1"]=\""trim($8)"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Route_Links["NR-1"]=\""trim(Links)"\"" >> OutFile
		# 特定于 route 的变量
		print "SYSINFO_VAR_Software_Network_Route_Flags["NR-1"]=\""trim($4)"\"" >> OutFile
	}
}
END {
    
}
#----------主体----------------------------------------------------------#

