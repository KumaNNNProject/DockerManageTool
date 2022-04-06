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
	FS=" ";
	#FS=RS; #RS默认是一个换行符
	#if(OutFile != "") print "#!/bin/bash" > OutFile  #=>输出到文件	
}
/mtu/{			
	# 内置函数
	# split(string, array [, fieldsep [, seps ] ]) : 分割字符串到数组
	#                                                fieldsep: 分隔符，默认使用FS
	#                                                seps: gawk特有的扩展
	#                                                参阅：[9.1.3字符串操作函数](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions)
	split($2, arr, ":");
	split(arr[1], InterfaceName, "@");
	
	# 内置函数
	# match(string, regexp [, array]) : 搜索字符串
	#                                   找到，返回子字符串开始的字符位置(索引)
	#                                   找不到，则返回零。
	#                                   参阅：[9.1.3字符串操作函数](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions)
	if(match($3, /UP/) != 0) { isUP=1 } else { isUP=0 }
	if(match($3, /BROADCAST/) != 0) { isBROADCAST=1 } else { isBROADCAST=0 }
	if(match($3, /LOOPBACK/) != 0) { isLOOPBACK=1 } else { isLOOPBACK=0 }
	if(match($3, /LOWER_UP/) != 0) { isLOWER_UP=1 } else { isLOWER_UP=0 }
	if(match($3, /MULTICAST/) != 0) { isMULTICAST=1 } else { isMULTICAST=0 }
	if(match($3, /POINTOPOINT/) != 0) { isPOINTOPOINT=1 } else { isPOINTOPOINT=0 }
	if(match($3, /PROMISC/) != 0) { isPROMISC=1 } else { isPROMISC=0 }
	if(match($3, /ALLMULTI/) != 0) { isALLMULTI=1 } else { isALLMULTI=0 }
	if(match($3, /DYNAMIC/) != 0) { isDYNAMIC=1 } else { isDYNAMIC=0 }	
	
	# 输出
	print "SYSINFO_VAR_Software_Network_InterfaceName["idx"]=\""trim(InterfaceName[1])"\""; #接口名称
	print "SYSINFO_VAR_Software_Network_Up["idx"]=\""isUP"\""; #网卡已开启
	print "SYSINFO_VAR_Software_Network_Up_"iName"=\""isUP"\""; #网卡已开启
	print "SYSINFO_VAR_Software_Network_Broadcast["idx"]=\""isBROADCAST"\""; #支持广播 
	print "SYSINFO_VAR_Software_Network_Broadcast_"iName"=\""isBROADCAST"\""; #支持广播 
	print "SYSINFO_VAR_Software_Network_Connected["idx"]=\""isLOWER_UP"\""; #网线已连接 
	print "SYSINFO_VAR_Software_Network_Connected_"iName"=\""isLOWER_UP"\""; #网线已连接 
	print "SYSINFO_VAR_Software_Network_Multicast["idx"]=\""isMULTICAST"\""; #支持多播 
	print "SYSINFO_VAR_Software_Network_Multicast_"iName"=\""isMULTICAST"\""; #支持多播 
	print "SYSINFO_VAR_Software_Network_Loopback["idx"]=\""isLOOPBACK"\""; #回环接口 
	print "SYSINFO_VAR_Software_Network_Loopback_"iName"=\""isLOOPBACK"\""; #回环接口 
	print "SYSINFO_VAR_Software_Network_MTU["idx"]=\""trim($5)"\""; #MTU 
	print "SYSINFO_VAR_Software_Network_MTU_"iName"=\""trim($5)"\""; #MTU 
	# 特定于ip命令的参数
	print "SYSINFO_VAR_Software_Network_Pointopoint["idx"]=\""isPOINTOPOINT"\""; #点对点通讯
	print "SYSINFO_VAR_Software_Network_Pointopoint_"iName"=\""isPOINTOPOINT"\""; #点对点通讯
	print "SYSINFO_VAR_Software_Network_Promisc["idx"]=\""isPROMISC"\""; #监听所有流量
	print "SYSINFO_VAR_Software_Network_Promisc_"iName"=\""isPROMISC"\""; #监听所有流量
	print "SYSINFO_VAR_Software_Network_Allmulti["idx"]=\""isALLMULTI"\""; #接收所有多播数据包
	print "SYSINFO_VAR_Software_Network_Allmulti_"iName"=\""isALLMULTI"\""; #接收所有多播数据包
	print "SYSINFO_VAR_Software_Network_Dynamic["idx"]=\""isDYNAMIC"\""; #动态接口
	print "SYSINFO_VAR_Software_Network_Dynamic_"iName"=\""isDYNAMIC"\""; #动态接口
	# 特定于ip命令的动态参数(qdisc,state,group,qlen,master)
	if(trim($6) != "") print "SYSINFO_VAR_Software_Network_"trim($6)"["idx"]=\""trim($7)"\""; 
	if(trim($6) != "") print "SYSINFO_VAR_Software_Network_"trim($6)"_"iName"=\""trim($7)"\""; 
	if(trim($8) != "") print "SYSINFO_VAR_Software_Network_"trim($8)"["idx"]=\""trim($9)"\""; 
	if(trim($8) != "") print "SYSINFO_VAR_Software_Network_"trim($8)"_"iName"=\""trim($9)"\""; 
	if(trim($10) != "") print "SYSINFO_VAR_Software_Network_"trim($10)"["idx"]=\""trim($11)"\""; 
	if(trim($10) != "") print "SYSINFO_VAR_Software_Network_"trim($10)"_"iName"=\""trim($11)"\"";
	if(trim($12) != "") print "SYSINFO_VAR_Software_Network_"trim($12)"["idx"]=\""trim($13)"\""; 
	if(trim($12) != "") print "SYSINFO_VAR_Software_Network_"trim($12)"_"iName"=\""trim($13)"\""; 
	
	# =>输出到文件
	if(OutFile != "") {
		print "SYSINFO_VAR_Software_Network_InterfaceName["idx"]=\""trim(InterfaceName[1])"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Up["idx"]=\""isUP"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Up_"iName"=\""isUP"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Broadcast["idx"]=\""isBROADCAST"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Broadcast_"iName"=\""isBROADCAST"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Connected["idx"]=\""isLOWER_UP"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Connected_"iName"=\""isLOWER_UP"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Multicast["idx"]=\""isMULTICAST"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Multicast_"iName"=\""isMULTICAST"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Loopback["idx"]=\""isLOOPBACK"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Loopback_"iName"=\""isLOOPBACK"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_MTU["idx"]=\""trim($5)"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_MTU_"iName"=\""trim($5)"\"" >> OutFile
		# 特定于ip命令的参数
		print "SYSINFO_VAR_Software_Network_Pointopoint["idx"]=\""isPOINTOPOINT"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Pointopoint_"iName"=\""isPOINTOPOINT"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Promisc["idx"]=\""isPROMISC"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Promisc_"iName"=\""isPROMISC"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Allmulti["idx"]=\""isALLMULTI"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Allmulti_"iName"=\""isALLMULTI"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Dynamic["idx"]=\""isDYNAMIC"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Dynamic_"iName"=\""isDYNAMIC"\"" >> OutFile
		# 特定于ip命令的动态参数(qdisc,state,group,qlen,master)
		if(trim($6) != "") print "SYSINFO_VAR_Software_Network_"trim($6)"["idx"]=\""trim($7)"\"" >> OutFile
		if(trim($6) != "") print "SYSINFO_VAR_Software_Network_"trim($6)"_"iName"=\""trim($7)"\"" >> OutFile
		if(trim($8) != "") print "SYSINFO_VAR_Software_Network_"trim($8)"["idx"]=\""trim($9)"\"" >> OutFile
		if(trim($8) != "") print "SYSINFO_VAR_Software_Network_"trim($8)"_"iName"=\""trim($9)"\"" >> OutFile
		if(trim($10) != "") print "SYSINFO_VAR_Software_Network_"trim($10)"["idx"]=\""trim($11)"\"" >> OutFile
		if(trim($10) != "") print "SYSINFO_VAR_Software_Network_"trim($10)"_"iName"=\""trim($11)"\"" >> OutFile
		if(trim($12) != "") print "SYSINFO_VAR_Software_Network_"trim($12)"["idx"]=\""trim($13)"\"" >> OutFile
		if(trim($12) != "") print "SYSINFO_VAR_Software_Network_"trim($12)"_"iName"=\""trim($13)"\"" >> OutFile
	}	
}
/link\//{
	# 内置函数
	# split(string, array [, fieldsep [, seps ] ]) : 分割字符串到数组
	#                                                fieldsep: 分隔符，默认使用FS
	#                                                seps: gawk特有的扩展
	#                                                参阅：[9.1.3字符串操作函数](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions)
	split($1, LinkType, "/");	
		
	# 输出
	print "SYSINFO_VAR_Software_Network_Mac["idx"]=\""trim($2)"\"";      #硬件地址
	print "SYSINFO_VAR_Software_Network_Mac_"iName"=\""trim($2)"\"";      #硬件地址
	print "SYSINFO_VAR_Software_Network_LinkType["idx"]=\""trim(LinkType[2])"\""; #链接类型
	print "SYSINFO_VAR_Software_Network_LinkType_"iName"=\""trim(LinkType[2])"\""; #链接类型
	if(OutFile != "") {
		print "SYSINFO_VAR_Software_Network_Mac["idx"]=\""trim($2)"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Mac_"iName"=\""trim($2)"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_LinkType["idx"]=\""trim(LinkType[2])"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_LinkType_"iName"=\""trim(LinkType[2])"\"" >> OutFile
	}
	
}
/inet /{
	# 内置函数
	# split(string, array [, fieldsep [, seps ] ]) : 分割字符串到数组
	#                                                fieldsep: 分隔符，默认使用FS
	#                                                seps: gawk特有的扩展
	#                                                参阅：[9.1.3字符串操作函数](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions)
	split($2, IPv4, "/");	
	# getline : 显示输入，即将前面的重定向内容保存到变量
	# ipcalc  : 计算IP相关信息
	"ipcalc -m "$2 | getline a;	
	split(a, Mask, "=");  #a: NETMASK=255.255.255.0
	if(iName == "lo") {
		Bcast="";
		Scope=trim($4);
	} else { 
		Bcast=trim($4);
		Scope=trim($6);
	}
		
	# 输出
	print "SYSINFO_VAR_Software_Network_IPv4["idx"]=\""trim(IPv4[1])"\""; #IPv4
	print "SYSINFO_VAR_Software_Network_IPv4_"iName"=\""trim(IPv4[1])"\""; #IPv4
	print "SYSINFO_VAR_Software_Network_Bcast["idx"]=\""Bcast"\""; #广播地址
	print "SYSINFO_VAR_Software_Network_Bcast_"iName"=\""Bcast"\""; #广播地址
	print "SYSINFO_VAR_Software_Network_Mask["idx"]=\""trim(Mask[2])"\""; #子网掩码 
	print "SYSINFO_VAR_Software_Network_Mask_"iName"=\""trim(Mask[2])"\""; #子网掩码 
	print "SYSINFO_VAR_Software_Network_IPv4Scope["idx"]=\""trim(Scope)"\""; #IPv4范围 
	print "SYSINFO_VAR_Software_Network_IPv4Scope_"iName"=\""trim(Scope)"\""; #IPv4范围 
	# =>输出到文件
	if(OutFile != "") {
		print "SYSINFO_VAR_Software_Network_IPv4["idx"]=\""trim(IPv4[1])"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_IPv4_"iName"=\""trim(IPv4[1])"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Bcast["idx"]=\""Bcast"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Bcast_"iName"=\""Bcast"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Mask["idx"]=\""trim(Mask[2])"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Mask_"iName"=\""trim(Mask[2])"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_IPv4Scope["idx"]=\""trim(Scope)"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_IPv4Scope_"iName"=\""trim(Scope)"\"" >> OutFile
	}	
}
/inet6/{
	# 输出
	print "SYSINFO_VAR_Software_Network_IPv6["idx"]=\""trim($2)"\""; #IPv6
	print "SYSINFO_VAR_Software_Network_IPv6_"iName"=\""trim($2)"\""; #IPv6
	#print "SYSINFO_VAR_Software_Network_IPv6Scope["idx"]=\""trim($4)"\""; #范围 
	#print "SYSINFO_VAR_Software_Network_IPv6Scope_"iName"=\""trim($4)"\""; #范围 
	
	# =>输出到文件
	if(OutFile != "") {
		print "SYSINFO_VAR_Software_Network_IPv6["idx"]=\""trim($2)"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_IPv6_"iName"=\""trim($2)"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_IPv6Scope["idx"]=\""trim($4)"\"" >> OutFile	
		print "SYSINFO_VAR_Software_Network_IPv6Scope_"iName"=\""trim($4)"\"" >> OutFile	
	}
}
END {
    
}
#----------主体----------------------------------------------------------#

