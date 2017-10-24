# quickpkgshell
1.项目说明(Project Description)
    快速为新程序生成一系列打包RPM包的相关脚本,包括编译程序生成RPM包、程序启动停止状态查询脚本、程序监控脚本。
This project aim to quickly generating RPM package shell in Linux .


2.文件说明(File Description)
.
├── generate_new_templete.sh        #生成新程序相关的脚本，主要执行脚本
└── src_shell                       #模板目录
    ├── make_new_rpm.sh             #编译打包
    ├── monitor_new.sh              #监控程序模块脚本
    ├── new.bin                     #新程序bin文件
    ├── new.service                 #监控程序模块脚本
    └── new.spec                    #生成RPM包spec文件
	
	
3.使用说明(Instructions)
  1)执行generate_new_templete.sh并传入一个参数，参数为程序名称，如下：
    ./generate_new_templete.sh test
    说明：默认情况下，执行后会生成如下文件：
		.
		├── output
		│   ├── make_test_rpm.sh                   #编译test程序脚本
		│   ├── monitor_test.sh                    #监控test程序脚本
		│   ├── RPMS
		│   │   └── test.1.0.0.0.0.i686.elf6.rpm   #打包生成的RPM包
		│   ├── test.bin                           #测试用bin文件
		│   ├── test.service                       #测试启动、停止、状态查询等脚本
		│   └── test.spec                          #生成RPM包spec文件
 
  2)根据自身需要修改相应脚本