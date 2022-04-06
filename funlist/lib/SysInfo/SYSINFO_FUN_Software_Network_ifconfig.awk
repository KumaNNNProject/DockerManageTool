#========================================================================#
# 名称: SYSINFO_FUN_Software_Network_ifconfig
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
	#if(OutFile != "") print "#!/bin/bash" > OutFile  #=>输出到文件
}
/Link encap/{			
	# 内置函数
	# split(string, array [, fieldsep [, seps ] ]) : 分割字符串到数组
	#                                                fieldsep: 分隔符，默认使用FS
	#                                                seps: gawk特有的扩展
	#                                                参阅：[9.1.3字符串操作函数](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions)
	split($1, arr, " ");
	split($1, crr, ":");     #接口名称:lo
	split(arr[3], brr, ":");
	
	# 输出
	print "SYSINFO_VAR_Software_Network_InterfaceName["idx"]=\""trim(arr[1])"\""; #接口名称
	if(iName == "lo") {
		print "SYSINFO_VAR_Software_Network_Mac["idx"]=\"\"";      #硬件地址
		print "SYSINFO_VAR_Software_Network_Mac_"iName"=\"\"";      #硬件地址
		print "SYSINFO_VAR_Software_Network_LinkType["idx"]=\""trim(crr[2])"\""; #链接类型
		print "SYSINFO_VAR_Software_Network_LinkType_"iName"=\""trim(crr[2])"\""; #链接类型
	} else {		
		print "SYSINFO_VAR_Software_Network_Mac["idx"]=\""trim(arr[5])"\"";      #硬件地址
		print "SYSINFO_VAR_Software_Network_Mac_"iName"=\""trim(arr[5])"\"";      #硬件地址
		print "SYSINFO_VAR_Software_Network_LinkType["idx"]=\""trim(brr[2])"\""; #链接类型
		print "SYSINFO_VAR_Software_Network_LinkType_"iName"=\""trim(brr[2])"\""; #链接类型
	}
	# =>输出到文件
	if(OutFile != "") {
		print "SYSINFO_VAR_Software_Network_InterfaceName["idx"]=\""trim(arr[1])"\"" >> OutFile
		if(iName == "lo") {
			print "SYSINFO_VAR_Software_Network_Mac["idx"]=\"\"" >> OutFile
			print "SYSINFO_VAR_Software_Network_Mac_"iName"=\"\"" >> OutFile
			print "SYSINFO_VAR_Software_Network_LinkType["idx"]=\""trim(crr[2])"\"" >> OutFile
			print "SYSINFO_VAR_Software_Network_LinkType_"iName"=\""trim(crr[2])"\"" >> OutFile
		} else {
			print "SYSINFO_VAR_Software_Network_Mac["idx"]=\""trim(arr[5])"\"" >> OutFile
			print "SYSINFO_VAR_Software_Network_Mac_"iName"=\""trim(arr[5])"\"" >> OutFile
			print "SYSINFO_VAR_Software_Network_LinkType["idx"]=\""trim(brr[2])"\"" >> OutFile
			print "SYSINFO_VAR_Software_Network_LinkType_"iName"=\""trim(brr[2])"\"" >> OutFile
		}
	}
}
/Mask/{			
	# 内置函数
	# split(string, array [, fieldsep [, seps ] ]) : 分割字符串到数组
	#                                                fieldsep: 分隔符，默认使用FS
	#                                                seps: gawk特有的扩展
	#                                                参阅：[9.1.3字符串操作函数](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions)
	split($1, arr, " ");
	split(arr[2], addr, ":");
	if(iName == "lo") {
		split(arr[3], Mask, ":");
	} else {		
		split(arr[3], Bcast, ":");
		split(arr[4], Mask, ":");
	}
	
	# 输出	
	print "SYSINFO_VAR_Software_Network_IPv4["idx"]=\""trim(addr[2])"\""; #IPv4
	print "SYSINFO_VAR_Software_Network_IPv4_"iName"=\""trim(addr[2])"\""; #IPv4
	print "SYSINFO_VAR_Software_Network_Bcast["idx"]=\""trim(Bcast[2])"\""; #广播地址
	print "SYSINFO_VAR_Software_Network_Bcast_"iName"=\""trim(Bcast[2])"\""; #广播地址
	print "SYSINFO_VAR_Software_Network_Mask["idx"]=\""trim(Mask[2])"\""; #子网掩码 
	print "SYSINFO_VAR_Software_Network_Mask_"iName"=\""trim(Mask[2])"\""; #子网掩码 
	# =>输出到文件
	if(OutFile != "") {
		print "SYSINFO_VAR_Software_Network_IPv4["idx"]=\""trim(addr[2])"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_IPv4_"iName"=\""trim(addr[2])"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Bcast["idx"]=\""trim(Bcast[2])"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Bcast_"iName"=\""trim(Bcast[2])"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Mask["idx"]=\""trim(Mask[2])"\"" >> OutFile		
		print "SYSINFO_VAR_Software_Network_Mask_"iName"=\""trim(Mask[2])"\"" >> OutFile		
	}
}
/Scope/{			
	# 内置函数
	# split(string, array [, fieldsep [, seps ] ]) : 分割字符串到数组
	#                                                fieldsep: 分隔符，默认使用FS
	#                                                seps: gawk特有的扩展
	#                                                参阅：[9.1.3字符串操作函数](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions)
	split($1, arr, " ");	
	split(arr[4], Scope, ":");
	
	# 输出
	print "SYSINFO_VAR_Software_Network_IPv6["idx"]=\""trim(arr[3])"\""; #IPv6
	print "SYSINFO_VAR_Software_Network_IPv6_"iName"=\""trim(arr[3])"\""; #IPv6
	print "SYSINFO_VAR_Software_Network_IPv6Scope["idx"]=\""trim(Scope[2])"\""; #IPv6范围 
	print "SYSINFO_VAR_Software_Network_IPv6Scope_"iName"=\""trim(Scope[2])"\""; #IPv6范围 
	print "SYSINFO_VAR_Software_Network_IPv4Scope["idx"]=\"\""; #IPv4范围 
	print "SYSINFO_VAR_Software_Network_IPv4Scope_"iName"=\"\""; #IPv4范围
	
	# =>输出到文件
	if(OutFile != "") {
		print "SYSINFO_VAR_Software_Network_IPv6["idx"]=\""trim(arr[3])"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_IPv6_"iName"=\""trim(arr[3])"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_IPv6Scope["idx"]=\""trim(Scope[2])"\"" >> OutFile	
		print "SYSINFO_VAR_Software_Network_IPv6Scope_"iName"=\""trim(Scope[2])"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_IPv4Scope["idx"]=\"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_IPv4Scope_"iName"=\"\"" >> OutFile
	}
}
/MTU/{			
	# 内置函数
	# split(string, array [, fieldsep [, seps ] ]) : 分割字符串到数组
	#                                                fieldsep: 分隔符，默认使用FS
	#                                                seps: gawk特有的扩展
	#                                                参阅：[9.1.3字符串操作函数](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions)
	split($1, arr, ":");	
	split(arr[2], MTU, " ");
	
	# 内置函数
	# match(string, regexp [, array]) : 搜索字符串
	#                                   找到，返回子字符串开始的字符位置(索引)
	#                                   找不到，则返回零。
	#                                   参阅：[9.1.3字符串操作函数](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions)
	if(match($1, /UP /) != 0) { isUP=1 } else { isUP=0 }
	if(match($1, / BROADCAST /) != 0) { isBROADCAST=1 } else { isBROADCAST=0 }
	if(match($1, / LOOPBACK /) != 0) { isLOOPBACK=1 } else { isLOOPBACK=0 }
	if(match($1, / RUNNING /) != 0) { isRUNNING=1 } else { isRUNNING=0 }
	if(match($1, / MULTICAST /) != 0) { isMULTICAST=1 } else { isMULTICAST=0 }
		
	# 输出
	print "SYSINFO_VAR_Software_Network_Up["idx"]=\""isUP"\""; #网卡已开启
	print "SYSINFO_VAR_Software_Network_Up_"iName"=\""isUP"\""; #网卡已开启
	print "SYSINFO_VAR_Software_Network_Broadcast["idx"]=\""isBROADCAST"\""; #支持广播 
	print "SYSINFO_VAR_Software_Network_Broadcast_"iName"=\""isBROADCAST"\""; #支持广播 
	print "SYSINFO_VAR_Software_Network_Connected["idx"]=\""isRUNNING"\""; #网线已连接 
	print "SYSINFO_VAR_Software_Network_Connected_"iName"=\""isRUNNING"\""; #网线已连接 
	print "SYSINFO_VAR_Software_Network_Multicast["idx"]=\""isMULTICAST"\""; #支持多播 
	print "SYSINFO_VAR_Software_Network_Multicast_"iName"=\""isMULTICAST"\""; #支持多播 
	print "SYSINFO_VAR_Software_Network_Loopback["idx"]=\""isLOOPBACK"\""; #回环接口 
	print "SYSINFO_VAR_Software_Network_Loopback_"iName"=\""isLOOPBACK"\""; #回环接口 
	print "SYSINFO_VAR_Software_Network_MTU["idx"]=\""trim(MTU[1])"\""; #MTU 
	print "SYSINFO_VAR_Software_Network_MTU_"iName"=\""trim(MTU[1])"\""; #MTU 
	
	# =>输出到文件
	if(OutFile != "") {
		print "SYSINFO_VAR_Software_Network_Up["idx"]=\""isUP"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Up_"iName"=\""isUP"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Broadcast["idx"]=\""isBROADCAST"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Broadcast_"iName"=\""isBROADCAST"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Connected["idx"]=\""isRUNNING"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Connected_"iName"=\""isRUNNING"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Multicast["idx"]=\""isMULTICAST"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Multicast_"iName"=\""isMULTICAST"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Loopback["idx"]=\""isLOOPBACK"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Loopback_"iName"=\""isLOOPBACK"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_MTU["idx"]=\""trim(MTU[1])"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_MTU_"iName"=\""trim(MTU[1])"\"" >> OutFile
	}	
}

END {
    
}
#----------主体----------------------------------------------------------#

