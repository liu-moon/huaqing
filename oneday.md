linux基础及C高级

	查看ubuntu版本:	cat /etc/issue
	查看当前linux内核版本:	uname -r
打开终端
	ctrl + alt + t
	ctrl + shift + n  在相同的路径下，再开启一个终端(必须得有终端)
	ctrl + shift + t  左右分屏打开一个同路径的终端(必须得有终端)
关闭终端
	exit
	ctrl + d
	点x
终端提示符
	liuiu@liuiu-Lenovo-Erazer-Y50-70:~$
	liuiu	用户名
	liuiu-Lenovo-Erazer-Y50-70	主机名
	~:路径
		如果是~表示家目录，使用cd ~进入家目录
		如果是/表示根目录(根目录是所有目录的起始位置)
	$是用户的权限
		$ 表示普通用户权限
		# 表示管理员权限(超级用户root权限)
			切换到管理员	sudo su root
			切换到上一个用户	exit
						su linux 切换用户
	快速切换回上次访问的目录	cd -
	关机	sudo shutdown -h now


****************************************************************************
	ls cd tab mkdir cp mv touch rm dpkg apt-get vi tar find grep
****************************************************************************
	创建	touch vi mkdir
	复制	cp
	移动或重命名	mv
	删除	rm 目录 -rf
	路径切换	cd
	查看	cat ls pwd
	查找	find grep
	压缩	tar
	自动补全	tab
	软件包管理	dpkg apt-get

基本命令
	1--ls
	功能	查看目录
	用法	ls
			列出当前目录下的文件名
		ls	路径
			查看你路径目录下的内容
		ls -a	
			列出当前目录下的所有文件名，包括隐藏文件
			.当前目录
			..上一级目录
		ls -l	
			显示当前目录下文件的详细信息
			drwxr-xr-x 11 linux linux 4096
			linux下一切皆文件	bcd-lsp
			字符设备驱动
			块设备驱动
			网络设备驱动
			
			cat /proc/devices
			<1>文件类型 bcd-lsp
				b(block块设备文件)
				c(char字符设备文件)
				d(directory目录文件)
				-(普通文件)
				l(link链接文件)
				s(socket套接字文件)
				p(pipe管道文件)
			<2>权限(文件所有者 + 文件所属组 + 其他用户权限)	八进制-权限
				a	     u		  g		o
				r读	w写	x执行	-没有权限
				rwx(文件所有者的权限)	rwx(文件属于组的权限)	r-x(其他人权限)
				111			111			101
				八进制表示:775
				
				chmod a-x a.out
				chmod a+x a.out
				chmod 675 a.out
			<3>硬链接数
			<4>文件所有者名
			<5>文件属于组名
			<6>大小
			<7>最后一次修改的时间 时间戳
			<8>文件名
		ls -lh	带单位的显示文件大小
		ls -i	查看文件的inode节点号(操作系统通过inode来区分文件)
	拓展	清屏
			clear
			ctrl + l

	2--cd
	功能	切换目录
		cd 目录名	--->进入当前目录的下个目录
		cd ~		--->进入家目录
		cd 回车		--->进入家目录
		cd / 		--->进入根目录
		cd -		--->进入上一次的目录
		cd .		--->进入当前目录
		cd ..		--->返回上一级目录
		
		路径	
			绝对路径 从根目录开始，当前文件所在的位置
				cd /home/linux/bj2019
			相对路径 从当前目录到想要到的位置(.和..)
				cd ../..
			查看当前目录绝对路径	pwd
	3--tab	补全命令
		使用tab键可以补全命令
		可以使用上键找到之前的命令的历史纪录
			history	命令查看历史命令
	4--mkdir 目录名 创建一个目录
		mkdir ~/gaga/farsight -p --->递归创建多个目录文件
	5--cp
		拷贝文件或目录
		[1]拷贝文件
			cp srcfile destfile
		[2]拷贝目录 === 拷贝库 强制拷贝(-arf)
			cp srcpath destpath -arf
	6--mv	
		移动文件或重命名
		[1]移动文件
			mv srcpath destpath
		[2]移动目录
			mv srcpath destpath
		注意:如果源文件/文件夹的目的文件/文件夹都没有加路径，则表示重命名
		     如果不在同一个路径下，必须添加路径
		
		不允许在同一个目录下有重复的名字(文件或文件夹都不行)
		linux@ubuntu:~/1906$ mv feng test
		mv: cannot overwrite non-directory ‘test’ with directory ‘feng’
	7--touch 文件名
		如果文件不存在，创建一个文件
		如果文件存在，则更新时间戳(基本不使用)
	8--rm 删除
		rm 文件名
			删除一个文件
		rm -rf 目录名
			删除一个文件目录(非空也可以删除)
	9--添加共享文件夹
	共享文件夹基本原理： 
		 ...
	共享文件夹设置：
		虚拟机 --> 设置 --> 选项 --> 共享文件夹 --> 选择总是启用 --> 添加windows下的目录文件 --> 确定
	
	在ubuntu里面，共享文件夹的路径为 /mnt/hgfs/下，例如共享文件名为share，则
		如果复制一个文件test.c，则
		cp test.c /mnt/hgfs/share
	如果想从Windows复制到ubuntu的当前路径，则执行
		cp /mnt/hgfs/share/hello.c .	
		
	建立软连接：
		ln -s /mnt/hgfs/share/ share

	共享文件夹失效的问题： 
	$ cd vmware-tools-distrib/
	~/vmware-tools-distrib$ sudo ./vmware-install.pl 

----------------------------------------------------------------------
命令参数含义查看:
	man 命令
	命令 --help
	ls --help
	info ls //xxx
----------------------------------------------------------------------
练习 
		<1>在你的用户主目录下以你的名字新建文件夹(目录)
		<2>将/etc/passwd 和 /etc/group 文件拷贝你的目录下
		<3>查看这两个文件的属性信息 ( ls  -l )
		<4>将你的目录备份成 yourname-bak 
		<5>将你的目录拷贝到共享目录(Linux 和 windows设定的共享目录)
		<6>在你的备份目录下创建test.c,test.c内printf("hello linux.\n"); 
		<7>删除你名字命名的目录
		<8>将你的备份目录yourname-bak 重命名为yourname

			mkdir fengjunhui
			cp /etc/passwd /etc/group fengjunhui/
			cd fengjunhui/
			ls -la
			cd ..
			cp fengjunhui/ fengjunhui-bak -arf
			ls
			diff fengjunhui fengjunhui-bak/
			cp fengjunhui /mnt/hgfs/share/ -arf
			cd fengjunhui-bak/
			ls
			vi test.c
			cd ..
			rm fengjunhui -rf
			mv fengjunhui-bak/ fengjunhui
软件包管理机制
	window下文件如何放到ubuntu下面
	1. 使用共享文件夹
		2. 直接拖拽方式
			如果不能直接拖拽的话，需要更新vmware-tools 
			点击 ”虚拟机“ -> 更新vmware-tools 
				将VM.....tar.gz 压缩包拷贝到你所熟知的路径，
				然后解压
					tar -xvf VM..tar.gz 
				进入到解压后的文件夹
				然后执行： sudo ./vmware-install.pl
				最后执行完脚本回到命令行，重启虚拟机，搞定。


	背景：
		Debian Linux首先提出“软件包”的管理机制——Deb软件包
		Redhat Linux基于这个理念推出了自己的软件包管理机制——Rpm软件包
		
		centos 
		
		软件包的命名 
		rxvt_1%3a2.6.4-14_i386.deb
		Filename_Version-Reversion_Architecture.deb
		软件名   软件版本 修订版本 体系架构
	dpkg(离线安装)--->需要权限
		sudo dpkg -i 软件包	--->安装
		sudo dpkg -r 软件包名	--->删除
		特点
			先下载好，然后进行安装
		注意
			多个软件包一起安装
			sudo dpkg -i *.deb
		显示所有已安装的deb包，显示版本号及说明
		dpkg -l
		查看软件包安装到系统内的文件目录信息
		dpkg -L rxvt
		查看包的具体信息
		dpkg -p rxvf
	apt-get 在线安装
		确保有网
			ping www.baidu.com
		dns服务器
			免费 8.8.8.8
				114.114.114.114
		查看ip
			linux ifconfig
			windows	ipconfig
		安装	sudo apt-get install 软件包名
			测试	sudo apt-get install sl
			执行	sl
		移除	sudo apt-get remove 软件包名
				sudo apt-get --purge remove <package>	删除包，包配置文件等
				sudo apt-get --reinstall install <package>
		特点
			在线安装，自动检查依赖关系
		apt安装完的软件deb包存放在:
			/var/cache/apt/archives$
		文档一般在	/usr/share
		可执行文件	/usr/bin
		配置文件	/etc
		lib文件		/usr/lib
		===========================================
		如果软件包安装不上
		1、网络通不通
		2、更新软件源

		如果在安装软件的时候出现depends....
		1、sudo apt-get update	更新索引
		2、sudo apt-get -f install	更新依赖
		3、sudo apt-get clean	清除下载的软件包
		4、重新安装软件
		===========================================
		-- 常用的底层目录以及文件
		软件源存放文件	/etc/apt/source/list
		软件包的索引路径	/var/lib/apt/lists
		下载软件deb包路径	/var/cache/apt/archives

问 如果别人发布了新版本的软件包，我如何获取最新版本
	答 更新索引，然后再安装
问 如何在一个没有网络的环境中安装软件包？
	答 先清理自己电脑已经下载的软件包，然后再下载自己需要的软件包,接着将这些软件包拷贝没有网络的环境下进行离线安装
	
	测试
		俄罗斯方块
			sudo apt-get install bastet
		启动	bastet
		Bubble	
			sudo apt-get install frozen-bubble
		启动	frozen-bubble
		cmatrix
			sudo apt-get install cmatrix  oneko 
			oneko & 	
			cmatrix

vi编辑器
	基本上vi/vim共分为三种模式
	命令模式(Command mode) 输入模式(Insert mode) 底线命令模式(Last line mode)
	进入vi编辑器 vi file.c
	命令模式 进入编辑器就为命令模式，使用ESC进入命令模式
		主要用于复制、粘贴、剪切等功能
		从命令模式进入插入模式
		i 从光标所在位置的前一个位置进入插入模式
		a 从光标所在位置的后一个位置进入插入模式
		o 从光标所在行的下一行，另起一行进入插入模式
		
		I 从光标所在行的起始位置进入插入模式
		A 从光标所在行的末尾位置进入插入模式
		O 从光标所在行的上一行，另起一行进入插入模式
		
		yy 复制光标所在的这一行
			先按下esc， shift+v 上下键选择 y复制 p拷贝--->一气呵成
		nyy 复制光标所在行开始的n行
		p 粘贴
		dd 剪切光标所在的这一行
			先按下esc，shift+v 上下键选择 d删除--->二气呵成
		ndd 剪切光标所在行开始的n行
		gg=G	代码自动对齐
		gg	将光标移动到第一行
		G	将光标移动到最后一行
	vi里面的后悔药
		u	撤销
		ctrl r	反撤销---恢复
		/xxx	在当前文件里面查找xxx，将查找到的内容高亮显示
		
		分屏打开
		底行模式	:sp	上下分屏
				:vsp	左右分屏
					分屏打开的时候还可以指定文件
					:vsp filename
		插入模式 主要用于写代码
		底行模式 在命令模式下 输入 :进入底行模式，主要用于保存、退出
			:w	保存
			:q	退出一个已经保存的文件
			:q!	强制退出
			:wq	保存并退出
			:x	保存并退出
			:vsp	文件名 左右分屏的打开一个文件(这个文件也可以是当前文件)	--垂直 vertical
			:sp	文件名 上下分屏显示文件
			:n	将光标移动到第n行	直接访问第n行
			:noh	关闭高亮显示
			:set nonu	取消显示行号
			:set nu		显示行号
			:%s/str1/str2/g 将文件里面的str1改为str2
			:m,ns/a/b/g	将m行到n行的a改为b

打包和压缩
	gzip / gunzip + file
	bzip2 / bunzip2 + file
	xz / unxz + file(大文件明显)
	
	gzip 1.c
	gunzip bunzip2 unxz 对文件解压
	注意 只针对文件操作 不能操作目录
	
	tar 对目录打包--->linux格式：gz bz2 xz
		c 创建 (压缩)
		x 释放 (解压)
		
		z gz格式
		j bz2格式
		J xz格式
		v 显示过程
		f 显示文件名
	注意 这些参数都可以组合在一起使用，f必须在最后面
	-----------------------------------------------
	tar -cvf dir.tar.? dir 对任意格式进行打包
		--->tar -cvf filename.tar.xz filename
	tar -czvf dir.tar.gz dir
	tar -cjvf dir.tar.bz2 dir
	tar -cJvf dir.tar.xz dir
	-----------------------------------------------
	tar -xvf dir.tar.*	(对所有格式都可以解压)
		--->tar -xvf filename.tar.xz
	tar -xvf dir.tar
	tar -xzvf dir.tar.gz
	tar -xjvf dir.tar.bz2
	tar -xJvf dir.tar.xz
	-----------------------------------------------
