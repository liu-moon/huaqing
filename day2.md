文件内容查找命令
		ctrl + shift + c 复制选择的内容	
		ctrl + shift + v 粘贴选择的内容
	1.find 路径 -name filename	(从当前目录开始，在所有的子目录寻找指定的文件)
		例如
			find ./ -name file.c
			find ./ -name *file*
	2.grep 搜索文件中的内容(字符串)
		(1)grep "string" 文件	---> 在指定文件中搜索
		(2)grep "string" * 	---> 在当前目录下所有的文件中搜索，不包括子目录
		(3)grep "string" * -nR	---> 在当前目录下所有的文件中搜索(包括子目录)
		grep "python" * -nR 1.c
		
		*	当前目录下所有的文件
		-R 	递归子目录
		-n	显示行号
		"^string"	以string开头的行
		"string$"	以string结尾的行
		"^string$"	只包含string行，不包括其他字符
		"string"	所有包含string的行
		
		常用用法
			grep "string" * -nR
			grep "^linux$" -n

文件内容查看命令
	----------------------------------------------------------
	grep find cut cat head tail nl more less
	----------------------------------------------------------
	1.grep 搜索一个字符串
	2.find 寻找一个文件
	管道 |
		将前一个命令的输出作为下一个命令的输入
	3.cat
		cat file --->将文件的内容显示到终端上
	4.nl
		nl 按行号显示文件内容，如果一行没有内容，则不会显示行号
		nl -b a 1.c
		nl -b a -n rz 1.c	默认行号为6位
		nl -b a -n rz -w 3 1.c	指定行号位数
	5.head
		head file --->从文件头开始显示10行
		head -n file --->从文件头开始显示n行
	6.tail
		tail file --->显示文件的倒数10行
		tail -n file --->显示文件的倒数n行
		问题 如何显示文件中指定行
			head -line file | tail -1
	7.more, less
		more 分页显示内容
			空格 翻译 **** 回车 换行 **** q 退出
		less
			同上
			输入"/词语" 搜索词语
			高亮显示，按n查找下一个
	8.wc
		wc 对文件内容进行统计
			-c 字符数
			-w 单词数	只要空格隔开就算一个单词
			-l 行书
		想统计/etc目录下有多少单词？
			ls /etc | wc -w
	9.cut	
		对子字符串进行分割
		-d 指定分割符
		-f 指定需要的区域
		
		问题1 如何将/etc/passwd文件内的用户名截取出来？
			cat /etc/passwd | cut -d ":" -f 1
		/etc/passwd
		linux	:x	:1000	:	1000	linux	:/home/linux	:/bin/bash
		用户名	密码	UID(用户ID)	GID组ID	描述信息 家目录用户目录	命令解释器
		
		问题2 如何截取出来 linux:1000:1000
			grep "^linux" /etc/passwd | cut -d ":" -f 1,3,4
			cat /etc/passwd | head -34 | tail -1 | cut -d ":" -f 1,3,4
		
		问题3 如何将linux这用户名对应的行号打出来
			cat /etc/passwd | grep "^linux" -n | cut -d ":" -f 1
	
		获取用户信息：	head -35 /etc/passwd | tail -1 | cut -d ":" -f 1,3,4
		获取行号    ：	cat /etc/passwd | cut -d ":" -f 1 (提取用户名)| grep "^linux$" -n | cut -d ":" -f 1	
		

shell基本概念
	英文单词Shell可直译为“贝壳”。“贝壳”是动物作为外在保护的一种工具。
	可以这样认为，Linux中的Shell就是Linux内核的一个外层保护工具，并负责完成用户与内核之间的交互。 
	用户      |    我想做点什么---听歌
	----------|------------------------
	shell     |    提供作案工具---耳机
	----------|------------------------
	linux内核 |    向下操作硬件---歌：走四方
	----------|------------------------
	硬件      |    手机音频设备---编解码
	----------|------------------------
	命令是用户向系统内核发出控制请求，与之交互的文本流。
	Shell是一个命令行解释器，将用户命令解析为操作系统所能理解的指令，实现用户与操作系统的交互。
	Shell为操作系统提供了内核之上的功能，直接用来管理和运行系统。
	当需要重复执行若干命令，可以将这些命令集合起来，加入一定的控制语句，编辑成为Shell脚本文件，交给Shell批量执行
	
命令执行的流程
	用户在命令行提示符下键入命令文本，开始与Shell进行交互。
	接着，Shell将用户的命令或按键转化成内核所能够理解的指令
	控制操作系统做出响应，直到控制相关硬件设备。
	然后，Shell将输出结果通过Shell提交给用户。
 
shell的种类
	Bourne Shell（简称sh）
		Bourne Shell由AT&T贝尔实验室的S.R.Bourne开发，也因开发者的姓名而得名。
		它是Unix的第一个Shell程序，早已成为工业标准。目前几乎所有的Linux系统都
		支持它。不过Bourne Shell的作业控制功能薄弱，且不支持别名与历史记录等功
		能。目前大多操作系统是将其作为应急Shell使用。
		
	C Shell（简称csh）
		C Shell由加利福尼亚大学伯克利分校开发。最初开发的目的是改进Bourne Shell
		的一些缺点，并使Shell脚本的编程风格类似于C语言，因而受到广大C程序员的拥
		护。不过C Shell的健壮性不如Bourne Shell
		
	Korn Shell（简称ksh）
		Korn Shell由David Korn开发，解决了Bourne Shell的用户交互问题，并克服
		了C Shell的脚本编程怪癖的缺点。Korn Shell的缺点是需要许可证，这导致它应用
		范围不如Bourne Shell广泛	
		
	Bourne Again Shell（简称bash）
		Bourne Again Shell由AT&T贝尔实验室开发，是Bourne Shell的增强版。随着几年的
		不断完善，已经成为最流行的Shell。它包括了早期的Bourne Shell和Korn Shell的
		原始功能，以及某些C Shell脚本语言的特性。此外，它还具有以下特点：能够提供
		环境变量以配置用户Shell环境，支持历史记录，内置算术功能，支持通配符表达式，
		将常用命令内置简化。
		
	sh===>csh==>ksh===>bash
 
 
 
 
shell命令的格式
	Command   [-Options]  Argument1  Argument2 …
	指令      选项        参数1      参数2…
	
	ls -la  filename 
	
	一条命令的三要素之间用空格隔开；
	若将多个命令在一行书写，用分号（;）将各命令隔开；
	如果一条命令不能在一行写完，在行尾使用反斜杠（\）标明该条命令未结束
	
查询命令历史
	history   将历史命令打印到终端
	history n 只打印后n个命令
	可以在家目录下的.bash_history下查看历史命令记录

	修改历史记录容量
		临时修改
			HISTSIZE=500
		永久修改
			在家目录下的.bashrc目录里面修改HISTSIZE的值，
			终端输入source  .bashrc使得立即生效（或者新开一个命令窗口）	
	
	source /.bashrc 
	
alias
	alias 列出当前系统中已经定义好的别名 
	临时定义别名
		定义命令别名listsoft 
		终端输入 alias listsoft='ls /var/cache/apt/archives'
		取消别名的定义  unalias listsoft   
	永久使用别名
			
		配置文件修改
			.bashrc
			.profile 
			
			注： 每次修改配置文件记得进行source操作	
			
			环境变量是否生效的问题
	  ---------------------------
	过去         现在           未来
			.bashrc 

关机重启命令
	关机命令
	sudo	shutdown -h now 立即关机
	sudo	shutdown -h +n  n分钟后关机
	重启命令
	sudo	shutdown  -r  now 立即重启
	sudo	shutdown  -r  +n n分钟后重启
	
	sudo	shutdown  -r  10
	
	取消重启或关机的命令：
	sudo shutdown -c
	
	直接重启
	sudo reboot


通配符
	file1.txt	file2.txt	file3.txt	file123.txt filea.txt fileb.txt
	星号（*）		匹配任意长度的字符串	
		用file*.txt，匹配所有
		
	问号（?）		匹配一个长度的字符	
		用file?.txt，匹配file1.txt、file2.txt、file3.txt、filea.txt、fileb.txt
		
	方括号（[…]）	匹配其中指定的一个字符
		用file_[otr].txt，匹配file_o.txt、file_r.txt和file_t.txt
		
	方括号（[ - ]）	匹配指定的一个字符范围
		用file_[a-z].txt，匹配file_a.txt、file_b.txt，直到file_z.txt
		
	方括号（[^…]）	除了其中指定的字符，均可匹配
		用file[^123].txt，匹配filea.txt、fileb.txt	
	ls file*.txt
	
	
	任务：
		1.c 2.c 3.c 4.c 5.c 12.c 13.c  
		如何匹配出12.c 13.c 
		ls [1][23].c	

		
管道符 |
	管道可以把一系列命令连接起来，意味着第一个命令的输出将作为第二个命令的输入
		例子：
			ls /etc | wc -w 统计一个目录下的文件的个数

	注意：管道符连接的第一个命令，必须有输出才可以，如果没有输出，则没有任何意义		


输入/输出重定向
	输出重定向 将输出的内容写到文件里面
		> file	清空  -----将输出的数据写入文件file，如果文件不存在则创建，如果存在则清空文件
			ls > file.c  将ls打印到终端的内容写入文件
		>> file 追加 -----将输出的数据写入文件file，如果文件不存在则创建，如果存在则追加


		0 ：标准输入  stdin
		1 ：标准输出  stdout
		2 ：标准出错  ---- 立即显示错误信息  stderr
		
		3 ：自己打开的文件

		fd1 = fopen ("1.c")    3
		fd2 = fopen ("2.c")    4 
		
	
命令置换 	`` 或者 $()	
		注：`` 是tab键上面的那个哟！
	命令替换是将一个命令的输出作为另一个命令的参数
	命令置换符的本质是将一个有输出结果的命令的输出内容保存在一个变量里面
	例如：
		A=`ls` 或者 A=$(ls)
		echo $A

扩展：
	--> whereis 搜索命令所在目录及帮助文档
			例子：whereis ls
			只能查找命令，还可以查找到命令所在文档	
	--> which 搜索命令所在目录及别名信息
			例子：which ls
			注意：只能查找一些命令
	--> diff：	比较两个文件,支持路径(只能比较文件)
			示例： diff  hello.c  main.c 
	--> file：	查看文件类型
			示例：file filename

		
	x86平台：
	gcc test.c 
	$ file a.out 
	a.out: ELF 32-bit LSB  executable, Intel 80386, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.24, BuildID[sha1]=a139f173ce59592a2b5cb2b0541eec0d4ddae3ae, not stripped
	
	交叉编译： 
	$ arm-none-linux-gnueabi-gcc test.c -o test
	6$ file test
	test: ELF 32-bit LSB  executable, ARM, EABI5 version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.38, not stripped
	
	查看未裁剪的大小：
	$ ls -la test
	-rwxrwxr-x 1 fengjunhui fengjunhui 5428  6月 17 11:37 test
	裁剪的是可执行文件：
	$ arm-none-linux-gnueabi-strip test
	查看状态:$ file test
	test: ELF 32-bit LSB  executable, ARM, EABI5 version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.38, stripped
	查看裁剪后的大小
	$ ls -la test
	-rwxrwxr-x 1 fengjunhui fengjunhui 2764  6月 17 11:36 test
基本系统命令
	1--man
		使用man命令可以找到特定的联机帮助页，并提供简短的命令说明
		man 命令/函数/特殊的文件	查找信息
		
		shell的区段: man man
			1	命令
			2	系统调用函数
			3	库函数
			4	特殊的文件
			5	文件的格式
		q	退出
		n	查找下一个
		N	查找上一个
		
		-k	查询指定功能的函数或者命令
			例如 man -k "send a signal"
		想实现一个功能
			发送一个信号   但是你不知道对应的函数接口
		
		不推荐使用：
			安装中文man手册：http://blog.chinaunix.net/uid-24830506-id-3266493.html

	2--info
		有些程序员在自己开发的软件包或程序中包含一组额外的帮助文档，称为信息帮助
		页（info page）。可以使用info命令来访问这些帮助页。
		info  commandname
	3--echo	输出数据
		echo 内容 在终端输出数据
			字符串使用引号，echo命令将原样输出；如果没有使用引号，echo命令将字符
			串中的由空格隔开的每个单词认作是字符串，字符串之间用一个空格隔开。
		-n 不换行
		-e  支持反斜控制的字符转换
			示例： echo -e "\n"
		$ A="hellolinux"
		$ echo $A
		hellolinux
		
		$ B="helloworld\n"
		$ echo $B
		helloworld\n    \n的表示
		$ echo -e $B
		helloworld
	4--date打印日期  --- 格式化输出
		date  获取当前时间
		
		+加号不能丢，和后面连着
		date +%a  星期简写   例如：五
		date +%A  星期全称   例如：星期五
		date +%D  按照月/日/年输出 例如：06/07/19
		date +%Y%m%d   年月日	   例如：20170807
		date +%s  从 1970年1月1日0点0分0秒到现在历经的秒数
		date --date=“20170815” +%s  从1970年1月1日到2019年x月x日的秒数

文件权限，文件所有者，所在组修改
	fengjunhui@ubuntu:~$ ls -la test.c
	-		rw-r--r--   1    fengjunhui fengjunhui 390     6月 17 14:23 test.c
	文件类型  权限  硬连接数  用户名    用户组名  文件大小    时间戳     文件名 
			
			rw-        r--      r--
	    文件所有者  文件所属组  其他用户  
	/a		u/          g/        o          
		
		4 2 1 
		r w x  
		
		chmod u+x 文件名 
		chmod g+x 文件名 
		chmod u-w 文件名  
		chmod a+x 文件名
	1.chmod	修改指定文件的权限
		chmod u/g/o/a	+/-	r/w/x	file
		文件所有者/组/其他用户	增加/取消权限	读/写/执行	文件名
		chmod u/g/o/a +/-  r/w/x  file 
		chmod  666  file
			 u :user当前用户
			 g :group当前组
			 o :other 其他用户
			 a :all所有的
2.chown  修改文件所有者(当前用户的用户名)或所在组
		chown  用户名  file 
		chown  用户名:组名  file 
	
	3.chgrp  修改文件所在的组 
		chgrp  组名  file 

	问题:如何修改所有文件的权限或所有者或所在组，包括子目录?
		回答:chown  root * -R (将所有文件的所有者名都修改成root,包括子目录)
		
		
	
练习:
	chmod  chown chgrp 
	<1>新建一个文件,并查看当前的用户分组信息
		touch 1.c 
		ls -l 
	<2>将这个文件 组的权限修改成读写执行(不影响文件所有者/其他用户 的权限)
		chmod g+wx 1.c  
	<3>将这个文件 所有者名修改成root
		sudo chown root 1.c
	<4>将这个文件 其他用户 组 权限修改成只读权限r	
		chmod o-wx 1.c 
	<5>将这个文件 的组名修改成root	
		chgrp root 1.c
	<6>查看当前用户对这个文件的访问权限
		ll   ls -l   ls -la  
	<7>将文件所有者和所在组修改为原来的
		chmod 	
文件的链接
	(1)软链接  ---掌握
		它是一种文件类型，类似windows快捷方式，用来记录目标文件的路径
		ln -s  目标文件(普通文件或目录文件)   软连接文件 

		ln -s /mnt/hgfs/linux-share/ linux-share
		cd linux-share  直接进入共享目录

	(2)硬链接  ---了解
		本质:给文件取一个别名,并没有创建一个新文件，不占用磁盘空间 
		本质： 一个人，两个名字

		ln   目标文件    硬连接文件
		fengjunhui@ubuntu:~$ ln test.sh hard-feng.sh
		fengjunhui@ubuntu:~$ ls -i   查看文件ID信息
		1325823 hard-feng.sh    1325823 test.sh
		=====================================
			fengjunhui@ubuntu:~/1906$ ls -li
			1487184 -rw-r--r-- 2 fengjunhui fengjunhui  390  6月 17 14:24 hard-test.c
			1487184 -rw-r--r-- 2 fengjunhui fengjunhui  390  6月 17 14:24 test.c
		   硬链接用来做文件备份很不错： 硬链接ID相同 har-feng.sh test.sh
		=====================================
		
		系统通过硬链接数来判断文件是否存在，当硬链接数为0的时候，系统认为文件不存在
	注意:
	
		(1) 硬链接不能对目录操作				 ----> 软连接可以
		(2) 硬链接在共享文件夹下不支持创建硬链接 ----> 软连接不可以 
		(3) 在系统任意路径下拷贝链接文件到共享目录下都可以，但是软连接有可能失效
				软连接从linux文件系统向Windows文件系统拷贝的时候会失效。（内核）
用户管理
	35 fengjunhui:x:1000:1000:fengjunhui,,,:/home/fengjunhui:/bin/bash   
	     用户名  密码  UID GID  描述性内容    家目录            shell
	用户名
	口令-密码
	用户ID（UID）	
	组ID （GID）
	用户主目录（HOME）
	用户shell

	(1)adduser  用户名 
		$ sudo adduser bj1907
		切换用户：
		linux@ubuntu:~$ su bj1907
		Password: 
		
		问题：关键文件
		/etc/passwd  存放系统用户的信息    
			用户登陆时，系统查询这个文件，确定用户的UID并验证用户口令
		/etc/shadow  用户密码
		/etc/group   存放系统组的信息
			 74 bj1906:x:1005:linux        
				 组名  密码 GID  所属的组
		/etc/skel    创建新用户的时候，拷贝这个目录下的配置文件到用户主目录

	创建一个新用户 
		命令 adduser
			sudo adduser 用户名字 
			
		删除一个用户 
			sudo userdel 用户名字
		修改用户名
			sudo usermod -l 新名字 旧名字
		删除用户的同时也将用户主目录删除掉
			sudo userdel -r 用户名 
			或
			sudo deluser --remvoe-home farsight	
	创建一个组 
		sudo groupadd 组名 
	删除一个组
		sudo groupdel 组名
			
	(2)临时切换用户
		su 用户名 

	(3)退出临时的用户 
		exit 

	(4)将用户添加到指定的组
		usermod -a -G 组名 用户名 
		sudo usermod -a -G 组名 用户名 
		将bj1906用户添加到某个组内，获得某个组内的权限

	(5)删除一个用户 
		deluser  用户名 --remove-home(删除用户的时候，删除这个用户的用户主目录)
		
		删除指定组内的用户： 
		sudo gpasswd -d    linux      hqyj
		
		查看：tail -5 /etc/group
	
	(6)修改用户密码 
		sudo passwd  用户名 

	ctrl + alt + F1   进入到纯命令行  
	ctrl + alt + F7   回到图形界面
磁盘管理
	(1)查看系统中硬盘信息  
		sudo fdisk  -l 
	(2)查看分区的使用情况
		sudo df -hT 
			df  [-a | -T | -h | -k ] 
			-a 显示所有物理文件系统的使用情况，包括虚拟文件系统，如/proc、/sys等
			-T 显示物理文件系统的文件格式类型
			-h 物理文件系统大小按兆字节为单位显示
	(3)手动挂载自己的设备
		挂载:将一个块设备的信息映射到一个指定的目录下
		sudo mount /dev/设备文件名   挂载目录 
		示例： sudo mount /dev/sda1   /mnt  
	(4)取消挂载的目录
			sudo umount  挂载目录
网络管理
	1.网络基础 
		(1)IP   : 在网络中主机的唯一标示   表示 : 点分十进制  示例IP地址： 192.168.2.100
		(2)组成 : 网络号(主机所在的网络) 192.168.2.0 + 主机号(网络中主机编号) + 100
		(3)IPv4(32bit,4byte) unsigned long  ,IPv6(128bit,16byte) ::冒分十六进制   xxx
		(4)分类 
				 1100 0000
				 1101 1111
				 
				 1100 0000 
				 1101 1111
			  网络号 + 主机号 	 最高位规定      第一个字节范围
		   A    1    +  3           0           [0-127]     0000 0000 - 0111 1111
		   B    2    +  2           10          [128-191]   1000 0000 - 1011 1111
		   ----------------------------------------------------------
		   C    3    +  1           110         [192,223]   110 0 0000 - 110 1 1111
					
		   容纳的主机数:1byte [0-255] 
		   192.168.0.0(表示网络)    192.168.0.255(广播地址)
		   ---------------------------------------------------------
		   D       组播（NBA）    1110         [224,239]   1110 0000 - 1110 1111
		   E       未使用(用于测试：)

		   问题:局域网内，主机间通信，遵从什么呢?
			回答:网络号一样，主机号不一样 
		
		
		(5)端口号（vi /etc/services）  unsigned short
		   	为了区分一台主机接收到的数据包应该转交给哪个进程来进行处理，使用端口号来区别
		   	TCP端口号与UDP端口号独立
		  	 端口号一般由IANA (Internet Assigned Numbers Authority) 管理
	       		众所周知端口：1~1023（1~255之间为众所周知端口，256~1023端口通常由UNIX系统占用）
				  已登记端口  ：1024~49151   (5001 --)
				  动态或私有端口：49152~65535
		   一般使用：5001 -- 6666 8888 7777 9999 10000 10001
		   

		(6)子网掩码 	
			255.255.255.0  & 192.168.2.3  = 192.168.2.0（网络号）
			子网掩码      & IP地址  == 网络号   来判定目标主机和当前主机是否在同一个网络 
			（~子网掩码） & IP地址  == 主机号
			
			问：一个网络的子网掩码为255.255.255.192，那么该网络中最多能够连接多少台主机？
			答：256-192=64，为地址块。
			又因为首尾2个IP地址不能用于主机（一个是网络地址，一个是广播地址），所以减去2，等于62个可用主机地址。
			

		(7)网关
			192.168.1.1
		   可以和外网通信的主机ip地址都可以作为网关，习惯用路由器的IP地址作为网关 
		   如果当前的主机判别目标主机不在同一个网络中，向目标主机发送的数据将发送到网关，由网关将数据包转发外网

		(8)DNS
		   域名解析，将域名转换成IP地址 ： 域名不变---获取IP 
		   www.baidu.com  -> ip --->mac 
			
		   免费使用的域名服务器 这两个是公共域名解析服务。
		   8.8.8.8
		   114.114.114.114
		   192.168.1.1
		   
		(9)MAC地址：
			网卡的物理地址：唯一表示一个网卡
		
		(10)ARP:   rarp
		
			地址解析协议，将IP地址转化为MAC地址
			
		问？ 从网页发送数据到对方收到数据都经过哪些协议？						
		域名--->DNS--->IP ---->TCP/UDP --->IP--->ARP--->MAC ===》xxxx
			
			
	2.查看IP地址 
		ipconfig(windows)/ifconfig(linux)
		临时修改ip地址 
			sudo ifconfig eth0  ip地址(192.168.2.200)
			sudo ifconfig eth0 down  关闭
			sudo ifconfig eth0 up    开启
			
			service network restart
		    /etc/init.d/networking restart

		查看当前的网卡：
			ifconfig  -a 

		lo： 本地回环地址  ， 软件层次的网卡，只能在本电脑上进行回环数据传输

		网络适配器
			------------------------------------------------------------------------
			桥接模式 --- 默认使用VMnet0,直接连接到物理网络  单独的IP  实际存在（当前局域网）
			-------------------------------------------------------------------------
			NAT模式  --- 	 a.  默认使用VMnet8，提供DHCP服务(动态IP分配)
					 b.  虚拟机可以和物理主机互相访问，但不可访问主机所在网络的其他计算机，可访问外部网络
					 本质： window是路由器，Ubuntu是主机 --- (对外不可见)
			-------------------------------------------------------------------------
			仅主机模式-- a.  默认使用VMnet1，提供DHCP服务 (对外不可见且不可联网，被隔离)
					 b.  虚拟机可以和物理主机互相访问，虚拟机和当前主机组成的网络下的虚拟机也可以通信，但虚拟机无法访问外部网络,

	3.ping 测试网络是否连接 
		ping 目标主机IP地址 或 域名 
		ping 192.168.0.1 
		ping www.baidu.com 
		ping 192.168.0.42

		
		
	通过ubuntu配置文件来设置网络方式
		1. 修改/etc/network/interfaces
			auto eth0
		    iface eth0 inet static                                                     
		    address 192.168.1.223
		    netmask 255.255.255.0
		    gateway 192.168.1.1
	
		2. 修改/etc/resolv.conf
			nameserver 8.8.8.8   (修改dns服务器)
		3. /etc/rc.local 
			echo "nameserver 8.8.8.8" >> /etc/resolv.conf

			
			重启网络服务：
			sudo /etc/init.d/networking restart
			
			重启网卡
			sudo ifconfig eth0 down 
			sudo ifconfig eth0 up
环境变量
	1.查看系统中的环境变量 
	  env 

	2.永久添加环境变量 
	1. 
		a. 打开/etc/environment配置文件
			将对应的可执行文件的路径添加到environment文件中，每个路径要用 “:” 间隔开
		b. source /etc/environment   
			使配置文件生效，让系统知道对该文件已修改
		c. 测试：
			可以在ubuntu任意路径下，执行添加到environment文件中路径下的可执行程序；
	2. 
		添加配置文件：
			sudo vi /etc/bash.bashrc
			或者 
			~/.bashrc 
			PATH=$PATH:/home/linux/1907/day2
			export PATH 
			
	3. 临时 
		临时设置一个环节变量设置
			$ export PATH="/home/linux/1906":$PATH
			$ a.out
			helloworld.
		在当前终端的任意目录都有效：
			
		查看环境变量：
			echo $PATH

		我们只需要将环境变量的修改，添加到这些配置文件中的任何一个中就可以了

	4. 将它拷贝到PATH环境变量保存的路径下     ===> 不推荐(见：3.永久添加环境变量  )
			sudo cp a.out /bin
	作业：
		1、配置一个静态IP，让你的电脑主机可以ping通外网，简单说就是用Ubuntu下的火狐浏览器可以看视频《硅谷传奇》	
		2、写一个程序，编译生成可执行文件，然后添加让这个可执行文件在任意的目录下都可以运行，运行的结果如下；
			linux@ubuntu:~/test$ mycmd
			|-------------------------------------------|-			
			|*******************************************|
			|*********@@@@@@@@@@@@@@@@@@@@@@@@@@********|
			|************www.bj1906.com.cn**************|
			|************Welcome to beijing*************|
			|************your name: linux***************|
			|*********@@@@@@@@@@@@@@@@@@@@@@@@@@********|
			|*******************************************| 
			|-------------------------------------------|-  
