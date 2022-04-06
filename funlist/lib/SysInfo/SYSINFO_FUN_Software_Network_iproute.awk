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
	FS="\n";
	#FS=RS; #RS默认是一个换行符
	#if(OutFile != "") print "#!/bin/bash" > OutFile  #=>输出到文件
}
{
	# 内置函数
	# split(string, array [, fieldsep [, seps ] ]) : 分割字符串到数组
	#                                                fieldsep: 分隔符，默认使用FS
	#                                                seps: gawk特有的扩展
	#                                                参阅：[9.1.3字符串操作函数](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions)
	split($1, arr, " ");
	
	if(arr[1] == "default" || arr[1] == "127.0.0.1"){
		if(arr[1] == "default"){
			Destination="0.0.0.0";
			Gateway=arr[3];
			Iface=arr[5];			
		}
		if(arr[1] == "127.0.0.1"){
			Destination=arr[1];
			Gateway="0.0.0.0";
			Iface=arr[3];
		}
		src=""
	} else {
		split(arr[1], brr, "/");
		Destination=brr[1];
		Gateway="0.0.0.0";
		Iface=arr[3];
		src=arr[9];
	}
	# getline : 显示输入，即将前面的重定向内容保存到变量
	# ipcalc  : 计算IP相关信息
	"ipcalc -m "Destination | getline a;	
	split(a, Mask, "=");  #a: NETMASK=255.255.255.0
	
	Genmask=Mask[2];
	Links=trim(Iface)"("trim(src)")""<==>"trim(Gateway)"<==>"trim(Destination)"("trim(Genmask)")"
	
	# 输出 
	print "SYSINFO_VAR_Software_Network_Route_Destination["NR-1"]=\""trim(Destination)"\""; #目标网络或主机
	print "SYSINFO_VAR_Software_Network_Route_Gateway["NR-1"]=\""trim(Gateway)"\""; #网关
	print "SYSINFO_VAR_Software_Network_Route_Genmask["NR-1"]=\""trim(Genmask)"\""; #目标掩码
	print "SYSINFO_VAR_Software_Network_Route_Iface["NR-1"]=\""trim(Iface)"\""; #接口名称
	print "SYSINFO_VAR_Software_Network_Route_Links["NR-1"]=\""trim(Links)"\""; #路由链	
	# 特定于ip route 的变量
	print "SYSINFO_VAR_Software_Network_Route_Src["NR-1"]=\""trim(src)"\""; #本地源IP
	
	# =>输出到文件 
	if(OutFile != "") {
		print "SYSINFO_VAR_Software_Network_Route_Destination["NR-1"]=\""trim(Destination)"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Route_Gateway["NR-1"]=\""trim(Gateway)"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Route_Genmask["NR-1"]=\""trim(Genmask)"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Route_Iface["NR-1"]=\""trim(Iface)"\"" >> OutFile
		print "SYSINFO_VAR_Software_Network_Route_Links["NR-1"]=\""trim(Links)"\"" >> OutFile
		# 特定于ip route 的变量
		print "SYSINFO_VAR_Software_Network_Route_Src["NR-1"]=\""trim(src)"\"" >> OutFile
	}
}
END {
    
}
#----------主体----------------------------------------------------------#

