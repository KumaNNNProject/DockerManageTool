#!/bin/bash

##########################################################
#
# 获取系统信息
# 
# 执行环境: 宿主机
# 调用方式: ./  source  sh 
# 调用参数: 			 		 	  				  
#     	   [$1]:   --help 查看帮助文档		      	  
##########################################################
# 备注
# exit 1  : 报错退出
# exit 0  : 无错误退出
# return int  : 函数内部，只能返回整数(0-255)
#               推荐使用return来中止后续执行
##########################################################

# ----预处理--------------------------------------------#

# 加载模式(1:主动|0:被动<默认>)
Sys_LoadMode="${Sys_LoadMode:-0}"
# 调试开关
Sys_Debug="${Sys_Debug:-0}"
App_Debug="${App_Debug:-0}"
# 默认分隔符
oldIFS=$IFS
# 测试:开关(true|false)
App_testON=false
# 测试:文件名和目录名
App_testFileName=.env
App_testDirName=lib
# 测试:多条件关系(and|or)
App_testMult=and
# 是否跳转到当前脚本目录(1:是|0:否)
App_toScriptDir="0"

# ================================================== 
# 函数名称: MAP_SET_FileList
# 函数功能: 映射表:文件列表	 
# 函数参数:  
#     	 [$1]:   文件路径(${BASH_SOURCE[0]}<默认>)
#     	         ./funlist/a/bc.sh 
#     	          /funlist/a/bc.sh 
#
# 变量列表:
#               ${MAP_Index} : MAP全局索引
#               ${MAP_ID[0]} : ID(md5sum(文件路径))
#      ${MAPSET_FileList[0]} : 文件列表(数组)
#
# 返回值:  
# 		$?: 获取调用结果(调用后立即使用)
# 		    0: 执行成功 
# 		    1: 执行失败 
# 
# ================================================== 
function MAP_SET_FileList(){
	# ${BASH_SOURCE[0]}: ./funlist/a/bc.sh
	#                      funlist/a/bc.sh
	# dirname ${BASH_SOURCE[0]}: ./funlist/a
	#                              funlist/a
	# 删除行首空格: sed 's/^[ \t]*//g'
	# 删除行尾空格: sed 's/[ \t]*$//g'	
	
	# ./funlist/a/bc.sh  =>  funlist/a/bc.sh
	#  /funlist/a/bc.sh
	# 文件
	local File="${1:-${BASH_SOURCE[0]}}"
	[ "${File:0:1}" == "." ]  &&  File="`echo "${File}" | sed 's/^\.//g' | sed 's/^\///g'`"
	# ID(md5sum(文件路径))
	local TMP_ID="`echo -n "${File}" | md5sum | cut -d ' ' -f 1`"
		
	# 存在记录时，使用已存记录的索引	
	for key in ${!MAP_ID[@]}
	do
		if [ "${TMP_ID}" == "${MAP_ID[$key]}" ];then
			#echo "ID hit..."
			local MAP_NextIndex="${MAP_Index}"
			MAP_Index="${key}"
		fi
	done
	
	# MAP全局索引
	MAP_Index="${MAP_Index:-0}"
	# ID(md5sum(文件路径))
	MAP_ID[${MAP_Index}]="${TMP_ID}"
	# 文件列表
	MAPSET_FileList[${MAP_Index}]="${File}"
	let MAP_Index++	
	# 恢复索引
	[ "${MAP_NextIndex}" != "" ] &&  MAP_Index="${MAP_NextIndex}"
}
##### 函数测试 #####
# MAP_SET_FileList
# 执行时间: 00:08
# MAP_SET_FileList  "/funlist/a/bc1.sh"
# 执行时间: 00:04
# MAP_SET_FileList  "/funlist/a/bc2.sh"
# MAP_SET_FileList  "/funlist/a/bc3.sh"
# MAP_SET_FileList  "/funlist/a/bc4.sh"
# MAP_SET_FileList  "/funlist/a/bc5.sh"
# MAP_SET_FileList  "/funlist/a/bc6.sh"
# MAP_SET_FileList  "/funlist/a/bc7.sh"
# MAP_SET_FileList  "/funlist/a/bc8.sh"
# MAP_SET_FileList  "/funlist/a/bc9.sh"
# MAP_SET_FileList  "/funlist/a/bc10.sh"
# MAP_SET_FileList
# 执行时间: 00:43 

# ================================================== 
# 函数名称: FUN_Source
# 函数功能: 文件加载
# 函数参数:  
#     	 [$1]:   文件路径 
# 
# ================================================== 
function FUN_Source(){
	#需要加载的文件
	local SourceFile="${1:-}"
	
	#设置 映射表.文件列表
	[ -e "${SourceFile}" ] &&  MAP_SET_FileList "${SourceFile}"
	#加载文件
	if [ "${SourceFile}" != "" ];then
		# 加载模式(1:主动|0:被动<默认>)
		Sys_LoadMode="1"
		if [ -e "${SourceFile}" ];then 
			echo "[FUN_Source] ${SourceFile}"
			source "${SourceFile}"  
		else 
			echo "[FUN_Source:File not exist] ${SourceFile}"
		fi
	fi
}
##### 函数测试 #####
# FUN_Source  "/funlist/a/bc1.sh"
# FUN_Source  "/funlist/a/bc2.sh"
# FUN_Source  "/funlist/a/bc3.sh"
# FUN_Source  "/funlist/a/bc4.sh"
# FUN_Source  "/funlist/a/bc5.sh"
# FUN_Source  "/funlist/a/bc6.sh"
# FUN_Source  "/funlist/a/bc7.sh"
# FUN_Source  "/funlist/a/bc8.sh"
# FUN_Source  "/funlist/a/bc9.sh"
# FUN_Source  "/funlist/a/bc10.sh"

# ================================================== 
# 函数名称: MAP_SET 
# 函数功能: 映射表:设置 
# 函数参数: 
#     	 [$1]:   更多数据(1:是|0:否<默认>) 
#
# 变量列表:
#         ${MAP_FileName[0]} : 文件名称(bc.sh)
#     ${MAP_AbsolutePath[0]} : 绝对路径(/mnt/.../funlist/a)
#     ${MAP_RelativePath[0]} : 相对路径(funlist/a)
#          ${MAP_FunList[0]} : 函数列表(,号分隔)
#      ${MAP_FunList_Raw[0]} : 函数列表(原生,包含换行符)
#     ${MAP_FunList_Array_0} : 函数列表(数组)
#                              #eval echo "\${MAP_FunList_Array_${MAP_Index}[0]}"  
# 返回值: 
# 		$?: 获取调用结果(调用后立即使用) 
# 		    0: 执行成功 
# 		    1: 执行失败 
# 
# ================================================== 
function MAP_SET(){ 
	#更多数据(1:是|0:否<默认>)
	local isMore="${1:-0}"
	
	# 设置数据	
	for key in ${!MAPSET_FileList[@]}
	do
		# 文件名称(bc.sh)
		[ "${MAP_FileName[${key}]}" == "" ] && MAP_FileName[${key}]="${MAPSET_FileList[$key]##*/}"
		# 绝对路径(/mnt/.../funlist/a)
		[ "${MAP_AbsolutePath[${key}]}" == "" ] && MAP_AbsolutePath[${key}]="$(cd $(dirname ${MAPSET_FileList[$key]}); pwd)"
		# 相对路径(funlist/a) 
		[ "${MAP_RelativePath[${key}]}" == "" ] && MAP_RelativePath[${key}]="`dirname ${MAPSET_FileList[$key]}`"
		if [ "${isMore}" == "1" ]; then
			# 函数列表(原生,包含换行符)
			MAP_FunList_Raw[${key}]="`cat ${MAPSET_FileList[$key]} | grep "^function.*" | sed 's/function//g' | sed 's/()//g' | sed 's/{//g' | sed 's/^[ \t]*//g' | sed 's/[ \t]*$//g'`"
			# 函数列表(数组)
			eval MAP_FunList_Array_${key}=\(`echo "${MAP_FunList_Raw[${key}]}"`\)
			# 函数列表(,号分隔)	
			for i in `eval echo '${MAP_FunList_Array_'"${key}"'[@]}'`
			do
				[ "${FunList}" != "" ] &&  FunList="${FunList},${i}" || FunList="${i}"
			done
			MAP_FunList[${key}]="${FunList}"
			unset FunList
		else 
			# 函数列表(原生,包含换行符)
			MAP_FunList_Raw[${key}]=""
			# 函数列表(数组)
			eval MAP_FunList_Array_${key}=""
			# 函数列表(,号分隔)
			MAP_FunList[${key}]=""
		fi
		
	done

	# 清除变量
	unset FunList	
}
##### 函数测试 #####
# FUN_Source
# FUN_Source  "tmp/a/ta.sh"
# FUN_Source  "tmp/b/tb.sh"
# MAP_SET 
#
# echo "ID: ${MAP_ID[0]}"
# echo "FileName: ${MAP_FileName[0]}"
# echo "AbsolutePath: ${MAP_AbsolutePath[0]}"
# echo "MAP_RelativePath: ${MAP_RelativePath[0]}"
# echo "MAP_FunList: ${MAP_FunList[0]}"
# echo 
# echo "ID: ${MAP_ID[1]}"
# echo "FileName: ${MAP_FileName[1]}"
# echo "AbsolutePath: ${MAP_AbsolutePath[1]}"
# echo "MAP_RelativePath: ${MAP_RelativePath[1]}"
# echo "MAP_FunList: ${MAP_FunList[1]}"
# echo 
# echo "ID: ${MAP_ID[2]}"
# echo "FileName: ${MAP_FileName[2]}"
# echo "AbsolutePath: ${MAP_AbsolutePath[2]}"
# echo "MAP_RelativePath: ${MAP_RelativePath[2]}"
# echo "MAP_FunList: ${MAP_FunList[2]}"

# ================================================== 
# 函数名称: MAP_GET					  	 
# 函数功能: 映射表:获取	 
# 函数参数: 			 		 	  				 
#     	 $1: 查询字段
#     	 $2: 条件字段01(key)
#     	 $3: 条件内容01(value)
#      [$4]: 条件字段02(key)(and)     		      	 
#      [$5]: 条件内容02(value)
#  
# 可用查询字段:
#               MAP_ID : ID
#         MAP_FileName : 文件名称
#     MAP_AbsolutePath : 绝对路径(/mnt/.../funlist/a)
#     MAP_RelativePath : 相对路径(funlist/a)
#          MAP_FunList : 函数列表(,号分隔)
#      MAP_FunList_Raw : 函数列表(原生,包含换行符)
#
# 可用条件字段:
#         MAP_FileName : 文件名称
#     MAP_AbsolutePath : 绝对路径(/mnt/.../funlist/a)
#     MAP_RelativePath : 相对路径(funlist/a)
#          MAP_FunList : 函数名称
#
# 返回值:  									 	  
# 		$?: 获取调用结果(调用后立即使用)							  
# 		    0: 执行成功							 	
# 		    1: 执行失败								 	
# 			 		  		 	  
# 	                       Str : 结果(取值为最后一个匹配的结果) 
# 	                 ${Result} : 结果(取值为最后一个匹配的结果) 
# 	       ${MAP_Result_Index} : 结果 索引
# 	          ${MAP_Result_ID} : 结果 ID
# 	    ${MAP_Result_FileName} : 结果 文件名称
# 	${MAP_Result_AbsolutePath} : 结果 绝对路径
# 	${MAP_Result_RelativePath} : 结果 相对路径
# 	     ${MAP_Result_FunList} : 结果 函数列表(,号分隔)
# 	  ${MAP_Result_FunListRaw} : 结果 函数列表(原生,包含换行符)			 									 	  
# ================================================== 
function MAP_GET(){
	#查询字段
	local QueryField="${1}"
	#条件字段01
	local ConditionKey_01="${2}"	
	#条件内容01
	local ConditionValue_01="${3}"
	#条件字段02
	local ConditionKey_02="${4:-}"	
	#条件内容02
	local ConditionValue_02="${5:-}"
	
	if [ "${ConditionKey_02}" != "" ];then
		# 多条件查询
		for key in ${!MAP_FileName[@]}
		do
			local c1="`eval echo "\\${${ConditionKey_01}[${key}]}" | grep -w "${ConditionValue_01}"`"						
			local c2="`eval echo "\\${${ConditionKey_02}[${key}]}" | grep -w "${ConditionValue_02}"`"						
			#c1="`echo "${c1}" | grep -w "${ConditionValue_01}"`"		
			#c2="`echo "${c2}" | grep -w "${ConditionValue_02}"`"		
			if [ "${c1}" != "" ] && [ "${c2}" != "" ];then
				eval MAP_Result="\${${QueryField}[${key}]}"
				MAP_Result_Index="${key}"
				MAP_Result_ID="${MAP_ID[${key}]}"
				MAP_Result_FileName="${MAP_FileName[${key}]}"
				MAP_Result_AbsolutePath="${MAP_AbsolutePath[${key}]}"
				MAP_Result_RelativePath="${MAP_RelativePath[${key}]}"
				MAP_Result_FunList="${MAP_FunList[${key}]}"
				MAP_Result_FunListRaw="${MAP_FunListRaw[${key}]}"
			fi 
		done 
	else
		# 单条件查询
		for key in ${!MAP_FileName[@]}
		do			
			local c1="`eval echo "\\${${ConditionKey_01}[${key}]}" | grep -w "${ConditionValue_01}"`"			
			#c1="`echo "${c1}" | grep -w "${ConditionValue_01}"`"		
			if [ "${c1}" != "" ];then
				eval MAP_Result="\${${QueryField}[${key}]}"
				MAP_Result_Index="${key}"
				MAP_Result_ID="${MAP_ID[${key}]}"
				MAP_Result_FileName="${MAP_FileName[${key}]}"
				MAP_Result_AbsolutePath="${MAP_AbsolutePath[${key}]}"
				MAP_Result_RelativePath="${MAP_RelativePath[${key}]}"
				MAP_Result_FunList="${MAP_FunList[${key}]}"
				MAP_Result_FunListRaw="${MAP_FunListRaw[${key}]}"
			fi
		done
	fi
	# 返回结果
	echo ${MAP_Result}	

	# 清除变量
	#unset MAP_Result
}
##### 函数测试 #####
# MAP_GET "MAP_RelativePath"  "MAP_FileName" "ta.sh"
# MAP_GET "MAP_RelativePath" "MAP_FunList" "MAP_SETs" "MAP_FileName" "ta.sh"
# echo MAP_RelativePath: ${MAP_Result}
##### 使用示例 ##### 
#脚本所在目录
# SPath="`MAP_GET "MAP_AbsolutePath" "MAP_FileName" "ta.sh"`"
# echo MAP_AbsolutePath: ${SPath}

# ================================================== 
# 函数名称: testENV 
# 函数功能: 测试环境是否符合脚本要求 
# 函数参数: 
# 
# 上下文变量: 
# 		 App_testON : 开关(true|false) 
#  App_testFileName : 文件名 
# 	App_testDirName : 目录名 
# 	   App_testMult : 多条件关系(and|or) 
# 返回值: 
# 		         Str : 项目实际路径(/.../funlist 或 /)
# ${RealProjectPath} : 项目实际路径(/.../funlist 或 /)
# ================================================== 
function testENV(){
	# 原理：检测当前路径下是否有指定的文件或目录
	#
	# ${FUNCNAME[0]} : 当前函数名
	# 获取符合条件的路径( /mnt/f_DockerData )
	# -d : 判断是否为目录，存在为true
	# -e : 判断是否为文件，存在为true
	# 由于！取反，实际结果: 
	# && :  任一个true，则执行循环体 (or)
	# || :  都为true，则执行循环体 (and)
	
	local ScriptDir="`MAP_GET "MAP_AbsolutePath" "MAP_FunList" "${FUNCNAME[0]}"`"
	cd ${ScriptDir}
	if [ "${App_testMult}" == "and" ];then
		# 条件关系: 和(and)
		while ( [ ! -d $App_testDirName ] || [ ! -e $App_testFileName ]  )
		do				
			# 根目录，退出循环，避免死循环
			if [ `pwd` == '/' ]; then					
				break
			else
				cd ..					
			fi
		done
		RealProjectPath=`pwd`
	elif [ "${App_testMult}" == "or" ];then
		# 条件关系: 或(or)
		while ( [ ! -d $App_testDirName ] && [ ! -e $App_testFileName ]  )
		do
			# 根目录，退出循环，避免死循环
			if [ `pwd` == '/' ]; then					
				break
			else
				cd ..					
			fi
		done
		RealProjectPath=`pwd`
	fi		
	cd ${ScriptDir}
	echo ${RealProjectPath}
}
#testENV

# 使用环境测试
[ $App_testON == 'true' ] && testENV
#默认处理: 设置此脚本的相关信息
[ "${Sys_LoadMode}" == "0" ] &&  FUN_Source
# FUN_Source  "tmp/a/ta.sh"
# FUN_Source  "tmp/b/tb.sh"
#推荐在加载完所有文件后使用
[ "${Sys_LoadMode}" == "0" ] &&  MAP_SET 


# 脚本名称
SCRIPT_NAME=${BASH_SOURCE[0]##*/}
# 脚本所在目录
# BASH_SOURCE[0]: 存储脚本的名称，如 funlist/a/bc.sh
# 注: 只适用于bash shell，不会改变cd目录
#     SCRIPT_DIR=$(cd $(dirname $0); pwd)  #不准确# $0不同方式调用结果不同
## OK # ./XXX.sh 	  :  /mnt/f_DockerData/scripts
## OK # source XXX.sh :  /mnt/f_DockerData/scripts
## OK # bash XXX.sh	  :  /mnt/f_DockerData/scripts
## NO # sh XXX.sh	  :  Error
#SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd) #改用如下方式# 
#SCRIPT_DIR="`MAP_GET "MAP_AbsolutePath" "MAP_FileName" "${SCRIPT_NAME}"`"
# 跳转到脚本目录
[ "${App_toScriptDir}" == "1" ] && cd ${SCRIPT_DIR}

# Debug
[ "${Sys_Debug}" == 1 ] && echo RealProjectPath: $RealProjectPath
[ "${Sys_Debug}" == 1 ] && echo PWD: $(pwd)
# ----预处理--------------------------------------------#

# ----参数处理------------------------------------------------------------------------------------------#

# ----参数处理------------------------------------------------------------------------------------------#


# ----函数定义------------------------------------------------------------------------------------------#

# ================================================== 
# 函数名称: outhelp		 					  	 
# 函数功能: 帮助文档	  	  							 
# 函数参数: 			 		 	  				 
# 			 									 	 
# 返回值:  									 	  
# 		 Document	 									 	  
# ================================================== 
function outhelp()
{		
	# [设置变量]
	Var="$1"
	
	echo
	echo "获取系统 软硬件 信息"
	echo " 		调用后将在当前环境中设置相应变量"
	echo " 		只适合在脚本中调用"
	echo
	echo "${SCRIPT_NAME}  [Type] [Item]  [CacheDir] [arg1]  [arg2]  [arg3]  [arg4]  [arg5]  [arg6]"
	echo "调用方式: ./  source  sh "
	echo "    Type : 类型(Hardware|Software)"
	echo "           默认: 所有"
	echo "    Item : 项"
	echo "           当前支持的项:"
	echo "                        CPU"
	echo "                        HardDisk"
	echo "                        System"
	echo "                        Storage"
	echo "                        Memory"
	echo "                        Loadavg"
	echo "                        Network"
	echo "CacheDir : 缓存目录(如 /tmp/cache/)"
	echo "           /结尾"
	echo  	 
	echo "示例: "
	echo "./${SCRIPT_NAME}  Hardware  CPU  /tmp/cache/"  
	echo "sh ${SCRIPT_NAME} Software"
	echo "source ${SCRIPT_NAME}"
	
	# 清除变量
	unset Var
	return 0 2>/dev/nul
	exit 0
}

# ================================================== 
# 函数名称: FunName			 					  	 
# 函数功能: xxxxxxx	  	  							 
# 函数参数: 			 		 	  				 
#     		 $1:   执行的命令				      	 
#     	   [$2]:   执行成功时回调			      	 
#     	   [$3]:   执行失败时回调			     	 
#     	   [$4]:   是否显示命令输出		      	  
# 			 									 	 
# 返回值:  									 	  
# 		$?: 获取调用结果(调用后立即使用)							  
# 		    0: 执行成功							 	
# 		    1: 执行失败								 	
# 			 									 	  
# 		${Var}: 其它							  
# ================================================== 
function FunName()
{		
	# 参数检查
	if [ ! $1 ]; then
	   echo "FunName: 参数不能为空"
	   return 1	
	fi
		
	# [设置变量]
	Var="$1"
	
	# Sys_Debug
	[ "${Sys_Debug}" == 1 ] && echo fun
	
	# 目录处理
	if [ ! -d $dir ]; then
	   echo "目录不存在"
	   (
		   # -p : 如果存在错误，根据需要生成父目录
		   sudo mkdir -p  "$dir"
	   ) && (
			echo "[创建目录成功]"
	   ) || (
			echo "[创建目录失败]"
			return 1
	   )
	else
	   echo "目录存在"
	fi
	
	# 文件处理
	if [ -e $file ]; then
	   echo "文件存在"
	else
	   echo "文件不存在"
	fi
	
	# 字符串比较
	var1=TesT
	var2=tEst
	echo 小写:  ${var1,,} ${var2,,}
	echo 大写:  ${var1^^} ${var2^^}
	# 将字符串转换为小写并比较
	[ "${var1,,}" == "tesT" ] &&  echo "var1=var2: 相等" || echo 'var1=var2: 不相等'
	if [ "${var1,,}" == "${var2,,}" ]; then
		echo "var1=var2: 相等"
	else 
		echo 'var1=var2: 不相等'
	fi
	
	# 清除变量
	unset Var
	
	return 0
}
##### 函数测试 #####
#  FunName



# ================================================== 
# 函数名称: SYSINFO_Main			 					  	 
# 函数功能: 获取系统 软硬件 信息	  	  							 
# 函数参数: 			 		 	  				 
#     	   [$1]:   类型(Hardware|Software)
#     		       默认: 所有				      	 
#     	   [$2]:   项			     	 
#     	   [$3]:   缓存目录(如 /tmp/cache/)		      	  
#     	   [$n]:   附加参数
# 			 									 	 
# 当前支持的项:  	
# 			CPU					 	  
# 			HardDisk					 	  
# 			System					 	  
# 			Storage					 	  
# 			Memory					 	  
# 			Loadavg					 	  
# 			Network					 	  
# 返回值:  									 	  
# 		$?: 获取调用结果(调用后立即使用)							  
# 		    0: 执行成功							 	
# 		    1: 执行失败								 	
#						  
# ================================================== 
function SYSINFO_Main()
{		
	# 类型
	SYSINFO_Type="${1-}"
	if [ "${SYSINFO_Type,,}" != "hardware" ] && [ "${SYSINFO_Type,,}" != "software" ];then
		SYSINFO_Type=""
	fi
	# 项
	SYSINFO_Item="${2-}"
	# 缓存目录(/tmp/cache/)
	SYSINFO_CacheDir="${3-}"
	# 附加参数
	arg1="${4-}"
	arg2="${5-}"
	arg3="${6-}"
	arg4="${7-}"
	arg5="${8-}"
	arg6="${9-}"
	
	# 引入文件	
	MAP_SET 1
	local ScriptDir="`MAP_GET "MAP_AbsolutePath" "MAP_FunList" "${FUNCNAME[0]}"`"
	FUN_Source "${ScriptDir}/Hardware.info.funlist"
	FUN_Source "${ScriptDir}/Software.info.funlist"
	
	if [ "${SYSINFO_Type}" != "" ];then
		if [ "${SYSINFO_Item}" != "" ];then
			choose="${SYSINFO_Type}_${SYSINFO_Item}"
			# ${Var,,} : 将字符串转换为小写
			case "${choose,,}" in
			"hardware_cpu")
				SYSINFO_FUN_Hardware_CPU  "${SYSINFO_CacheDir}"					
				;;
			"hardware_harddisk")
				SYSINFO_FUN_Hardware_HardDisk  "${SYSINFO_CacheDir}"					
				;;
			"software_system")
				SYSINFO_FUN_Software_System  "${SYSINFO_CacheDir}"					
				;;
			"software_storage")
				SYSINFO_FUN_Software_Storage  "${SYSINFO_CacheDir}"					
				;;
			"software_memory")
				SYSINFO_FUN_Software_Memory  "${SYSINFO_CacheDir}"					
				;;
			"software_loadavg")
				SYSINFO_FUN_Software_Loadavg  "${SYSINFO_CacheDir}"					
				;;
			"software_network")
				SYSINFO_FUN_Software_Network  "${SYSINFO_CacheDir}"	"${arg1}"			
				;;
			*)
				echo '无效参数.'
				return 1
				;;    
			esac
		else
			# ${SYSINFO_Type}  all	
			case "${SYSINFO_Type,,}" in
			"hardware")
				SYSINFO_FUN_Hardware_CPU  "${SYSINFO_CacheDir}"
				SYSINFO_FUN_Hardware_HardDisk  "${SYSINFO_CacheDir}"					
				;;
			"software")
				SYSINFO_FUN_Software_System  "${SYSINFO_CacheDir}"	
				SYSINFO_FUN_Software_Storage  "${SYSINFO_CacheDir}"	
				SYSINFO_FUN_Software_Memory  "${SYSINFO_CacheDir}"	
				SYSINFO_FUN_Software_Loadavg  "${SYSINFO_CacheDir}"
				SYSINFO_FUN_Software_Network  "${SYSINFO_CacheDir}"	"${arg1}"					
				;;
			*)
				echo '无效参数..'
				return 1
				;;    
			esac	
		fi
	else
		# all all
		SYSINFO_FUN_Hardware_CPU  "${SYSINFO_CacheDir}"
		SYSINFO_FUN_Hardware_HardDisk  "${SYSINFO_CacheDir}"
		SYSINFO_FUN_Software_System  "${SYSINFO_CacheDir}"	
		SYSINFO_FUN_Software_Storage  "${SYSINFO_CacheDir}"	
		SYSINFO_FUN_Software_Memory  "${SYSINFO_CacheDir}"	
		SYSINFO_FUN_Software_Loadavg  "${SYSINFO_CacheDir}"
		SYSINFO_FUN_Software_Network  "${SYSINFO_CacheDir}"	"${arg1}"		
	fi
	
	# 清除变量
	unset SYSINFO_Type
	unset SYSINFO_Item
	unset SYSINFO_CacheDir
	unset arg1
	unset arg2
	unset arg3
	unset arg4
	unset arg5
	unset arg6
	unset choose
	
	return 0
}
##### 函数测试 #####
#SYSINFO_Main 
#SYSINFO_Main "" "" "/tmp/cache/"
#SYSINFO_Main "Hardware"
#SYSINFO_Main "Software"
# #
# echo '架构:' $SYSINFO_VAR_Hardware_CPU_Architecture
# echo '型号名称:' $SYSINFO_VAR_Hardware_CPU_ModelName
# #
# echo '设备名称:' ${SYSINFO_VAR_Hardware_HardDisk_Name[0]}
# echo '设备挂载点:' ${SYSINFO_VAR_Hardware_HardDisk_MountPoint[0]}
# echo '设备类型:' ${SYSINFO_VAR_Hardware_HardDisk_Type[0]}
# echo '设备传输类型:' ${SYSINFO_VAR_Hardware_HardDisk_Tran[0]}
# echo '主要设备编号:' ${SYSINFO_VAR_Hardware_HardDisk_Maj[0]}
# #
# echo '操作系统名称:' ${SYSINFO_VAR_Software_System_OSName}
# echo '用户列表:' ${SYSINFO_VAR_Software_System_UserList[0]}
# #
# echo '接口名称:' ${SYSINFO_VAR_Software_Network_InterfaceName[3]}
# echo '硬件地址:' ${SYSINFO_VAR_Software_Network_Mac[0]}
# echo 'MTU:' ${SYSINFO_VAR_Software_Network_MTU[0]}
# echo '动态接口:' ${SYSINFO_VAR_Software_Network_Dynamic[0]}
# echo '目标网络或主机:' ${SYSINFO_VAR_Software_Network_Route_Destination[0]}
# echo '路由链:' ${SYSINFO_VAR_Software_Network_Route_Links[0]}

# ----函数定义------------------------------------------------------------------------------------------#

# ----函数调用------------------------------------------------------------------------------------------#
# ${1,,} : 将字符串转换为小写
if [ "${1,,}" == '--help' ]; then
   # 输出帮助文档
   outhelp
   exit 0
else 
   SYSINFO_Main "$1"  "$2"  "$3"  "$4"  "$5"  "$6"  "$7"  "$8"  "$9"   
fi

# ----函数调用------------------------------------------------------------------------------------------#







