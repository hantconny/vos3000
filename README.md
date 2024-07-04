使用centos6.4安装

chkconfig sshd on

service sshd start

chkconfig iptables off

chkconfig ip6tables off

service iptables stop

service ip6tables stop

修改install6.sh

去掉倒数第二行安装内核rpm -ivh --nodeps --force kernel-2.6.32-358.0.1.el6.x86_64.rpm

因为centos6.4就是这个内核

./install6.sh 执行安装

时间同步

ntpdate 10.45.151.174

将系统时间同步到硬件时钟

hwclock -w

把 jrockit-jdk1.6.0_45-R28.2.7-4.1.0-linux-x64.7z 包解压下，因为github不能传超过100M的包，所以分卷分成了三个文件

理论上可以使用jrockit.exp来静默安装，不过脚本里没用这个安装。而是弹出了图形。

修改install.sh

把./vos30002140.bin以下的清理操作注释掉

./install.sh 执行安装

把输出的内容保存下

......

UUID: f4b7f1c5-d4fd-4f57-9141-80e0708313c5

......

VOS30002140 BIN ,Just for Study,Must Delete it before 24Hours

Starting Crack......

10.45.151.212 00-0C-29-D8-EE-68 1366723034 1720056472 1720056449

主要内容有两个，一个UUID，一个是bin文件生成的ip mac rpmtime vostime jdktime

其他还有一些数据库密码之类的。因为2.1.4的数据库root没有密码，所以记不记vos3000用户的密码问题不大

然后生成license.dat

上传到/home/kunshi/license目录

chmod -R 777 /home/kunshi/license

chown -R kunshi:kunshi /home/kunshi/license

reboot重启，否则会出现1202端口占用

执行两遍，确保没有问题

service vos3000d restart && service mbx3000d restart

客户端登录

服务器地址就是安装vos3000的地址

用户名admin

密码admin

标识就是UUID

安装包和注册机都来自https://github.com/richfang/vos30002.4

客户端exe程序来自 http://bltcall.com/nd.jsp?id=54#_jcp=4_8 页面的下载链接 http://22182244.s21d.faiusrd.com/0/ABUIABBLGAAgqYPD8wUoocDVmQI.exe?f=vos3000v2.1.4.0client.exe&v=1584447914