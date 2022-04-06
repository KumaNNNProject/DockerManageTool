#========================================================================#
# 名称: SYSINFO_FUN_Hardware_CPU
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
	FS=":";
	if(OutFile != "") print "#!/bin/bash" > OutFile  #=>输出到文件
}
/Model name/{
    # $1: "Model name"
    # $2: "            Intel(R) Core(TM) i5-3210M CPU @ 2.50GHz"
	
	# 去除首尾空格	
	b=trim($2)	
	# 输出(包含双引号)
	print "SYSINFO_VAR_Hardware_CPU_ModelName=\""b"\"";  #型号名称 
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_ModelName=\""b"\"" > OutFile  #=>输出到文件
}
/CPU MHz/{
    # $1: "CPU MHz"
    # $2: "               2494.346"
	
	# 去除首尾空格	
	b=trim($2)
		
	# 输出(包含双引号)
	print "SYSINFO_VAR_Hardware_CPU_MHz=\""b"\"";  #CPU主频	
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_MHz=\""b"\"" > OutFile  #=>输出到文件
}
/Socket\(s)/{
    # $1: "Socket(s):"
    # $2: "             1"
	
	# 去除首尾空格	
	b=trim($2)
		
	# 输出(包含双引号)
	print "SYSINFO_VAR_Hardware_CPU_Sockets=\""b"\"";  #CPU插槽数 	
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_Sockets=\""b"\"" > OutFile  #=>输出到文件
}
/Core\(s) per socket/{
    # $1: "Core(s) per socket"
    # $2: "    2"
	
	# 去除首尾空格	
	b=trim($2)
		
	# 输出(包含双引号)
	print "SYSINFO_VAR_Hardware_CPU_CoresPerSocket=\""b"\"";  #每个插槽CPU核数/每颗物理CPU核数
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_CoresPerSocket=\""b"\"" > OutFile  #=>输出到文件
}
/Thread\(s) per core/{
    # $1: "Thread(s) per core"
    # $2: "    1"
	
	# 去除首尾空格	
	b=trim($2)
		
	# 输出(包含双引号)
	print "SYSINFO_VAR_Hardware_CPU_ThreadsPerCore=\""b"\"";  #每个核心线程数量
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_ThreadsPerCore=\""b"\"" > OutFile  #=>输出到文件
}
/^CPU\(s)/{
    # $1: "CPU(s)"
    # $2: "                2"
	
	# 去除首尾空格	
	b=trim($2)
		
	# 输出(包含双引号)
	print "SYSINFO_VAR_Hardware_CPU_CPUs=\""b"\"";  #逻辑CPU数量/总线程数	
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_CPUs=\""b"\"" > OutFile  #=>输出到文件
}
/Architecture/{
    # $1: "Architecture"
    # $2: "          x86_64"
	
	# 去除首尾空格	
	b=trim($2)
		
	# 输出(包含双引号)
	print "SYSINFO_VAR_Hardware_CPU_Architecture=\""b"\"";  #架构	
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_Architecture=\""b"\"" > OutFile  #=>输出到文件
}
/CPU op-mode/{
	# $1: "CPU op-mode(s)"
    # $2: "        32-bit, 64-bit"
	
	# 去除首尾空格	
	b=trim($2);	
	
	# 内置函数
	# split(string, array [, fieldsep [, seps ] ]) : 分割字符串到数组
	#                                                fieldsep: 分隔符，默认使用FS
	#                                                seps: gawk特有的扩展
	#                                                参阅：[9.1.3字符串操作函数](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions)
	split(b, arr, ",");	
	
	# 输出(包含双引号)
	x=1;
	print "SYSINFO_VAR_Hardware_CPU_CPUOpModes[0]=\""b"\""; #CPU操作模式(完整全文)
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_CPUOpModes[0]=\""b"\"" > OutFile  #=>输出到文件
	for (i in arr){
		print "SYSINFO_VAR_Hardware_CPU_CPUOpModes["x"]=\""trim(arr[i])"\""; #CPU操作模式
		if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_CPUOpModes["x"]=\""trim(arr[i])"\"" > OutFile  #=>输出到文件
		x++
	}	
}
/L1d cache/{
    # $1: "L1d cache"
    # $2: "             32K"
	
	# 去除首尾空格	
	b=trim($2)
		
	# 输出(包含双引号)
	print "SYSINFO_VAR_Hardware_CPU_L1dCache=\""b"\"";  #一级数据缓存	
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_L1dCache=\""b"\"" > OutFile  #=>输出到文件
}
/L1i cache/{
    # $1: "L1i cache"
    # $2: "             32K"
	
	# 去除首尾空格	
	b=trim($2)
		
	# 输出(包含双引号)
	print "SYSINFO_VAR_Hardware_CPU_L1iCache=\""b"\"";  #一级指令缓存	
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_L1iCache=\""b"\"" > OutFile  #=>输出到文件
}
/L2 cache/{
    # $1: "L2 cache"
    # $2: "              256K"
	
	# 去除首尾空格	
	b=trim($2)
		
	# 输出(包含双引号)
	print "SYSINFO_VAR_Hardware_CPU_L2Cache=\""b"\"";  #二级缓存
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_L2Cache=\""b"\"" > OutFile  #=>输出到文件
}
/L3 cache/{
    # $1: "L3 cache"
    # $2: "              3072K"
	
	# 去除首尾空格	
	b=trim($2)
		
	# 输出(包含双引号)
	print "SYSINFO_VAR_Hardware_CPU_L3Cache=\""b"\"";  #三级缓存
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_L3Cache=\""b"\"" > OutFile  #=>输出到文件
}
/Virtualization type/{
	# $1: "Virtualization type"
    # $2: "   full"
	
	# 去除首尾空格	
	b=trim($2);		
	
	# 内置函数
	# split(string, array [, fieldsep [, seps ] ]) : 分割字符串到数组
	#                                                fieldsep: 分隔符，默认使用FS
	#                                                seps: gawk特有的扩展
	#                                                参阅：[9.1.3字符串操作函数](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions)
	split(b, arr, ",");	
	
	# 输出(包含双引号)
	x=1;
	print "SYSINFO_VAR_Hardware_CPU_VirtualizationType[0]=\""b"\""; #CPU支持的虚拟化技术(完整全文)
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_VirtualizationType[0]=\""b"\"" > OutFile  #=>输出到文件
	for (i in arr){
		print "SYSINFO_VAR_Hardware_CPU_VirtualizationType["x"]=\""trim(arr[i])"\""; #CPU支持的虚拟化技术
		if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_VirtualizationType["x"]=\""trim(arr[i])"\"" > OutFile  #=>输出到文件
		x++
	}	
}
/NUMA node\(s)/{
    # $1: "NUMA node(s)"
    # $2: "          1"
	
	# 去除首尾空格	
	b=trim($2)
		
	# 输出(包含双引号)
	print "SYSINFO_VAR_Hardware_CPU_NUMANodes=\""b"\"";  #NUMA节点数量
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_NUMANodes=\""b"\"" > OutFile  #=>输出到文件
}
/BogoMIPS/{
    # $1: "BogoMIPS"
    # $2: "              4988.69"
	
	# 去除首尾空格	
	b=trim($2)
		
	# 输出(包含双引号)
	print "SYSINFO_VAR_Hardware_CPU_BogoMIPS=\""b"\"";  #预估MIPS值
	if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_BogoMIPS=\""b"\"" > OutFile  #=>输出到文件
}
/Flags/{
    # $1: "Flags"
    # $2: "                 fpu..."
	
	# 去除首尾空格	
	b=trim($2)
		
	
	# 内置函数
	# match(string, regexp [, array]) : 搜索字符串
	#                                   找到，返回子字符串开始的字符位置(索引)
	#                                   找不到，则返回零。
	#                                   参阅：[9.1.3字符串操作函数](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions)
	where = match(b, / lm /)
    # 输出(包含双引号)	
	if (where != 0){
		print "SYSINFO_VAR_Hardware_CPU_is64bit=\"1\"";  #是否支持64位(1:是|0:否)
		if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_is64bit=\"1\"" > OutFile  #=>输出到文件
	}else{
		print "SYSINFO_VAR_Hardware_CPU_is64bit=\"0\"";  #是否支持64位(1:是|0:否)
		if(OutFile != "") print "SYSINFO_VAR_Hardware_CPU_is64bit=\"0\"" > OutFile  #=>输出到文件
	}
}

END {
    
}
#----------主体----------------------------------------------------------#

