#!/bin/bash
yum install -y tcl-devel
yum install -y expect
sed -i 's#enforcing#disabled#g' /etc/sysconfig/selinux
setenforce 0
sh create_user_kunshi.sh
sh create_user_kunshiweb.sh
rpm -ivh --nodeps --force MySQL-server-community-5.0.96-1.rhel5.x86_64.rpm
rpm -ivh --nodeps --force MySQL-client-community-5.0.96-1.rhel5.x86_64.rpm
cat >>/etc/my.cnf<< EOF
[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
user=mysql
# Default to using old password format for compatibility with mysql 3.x
# clients (those using the mysqlclient10 compatibility package).
old_passwords=1

# Disabling symbolic-links is recommended to prevent assorted security risks;
# to do so, uncomment this line:
# symbolic-links=0

[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
EOF
service mysql restart
rpm -ivh jdk-6u45-linux-amd64.rpm
tar zxvf apache-tomcat-7.0.23.tar.gz
mv apache-tomcat-7.0.23 /home/kunshiweb/base/apache-tomcat
chmod 777 jrockit-jdk1.6.0_45-R28.2.7-4.1.0-linux-x64.bin
./jrockit-jdk1.6.0_45-R28.2.7-4.1.0-linux-x64.bin
cp -r /root/jrockit-jdk1.6.0_45-R28.2.7-4.1.0 /home/kunshi/base/jdk_default
mv /root/jrockit-jdk1.6.0_45-R28.2.7-4.1.0 /home/kunshiweb/base/jdk_default
./vos3000.exp
rpm -ivh --nodeps --force emp-2.1.4-0.noarch.rpm
rpm -ivh --nodeps --force callservice-2.1.4-0.i586.rpm
./mgc.exp
./web.exp
rpm -ivh --nodeps --force vos3000-webthirdparty-2.1.4-0.i586.rpm
rpm -ivh --nodeps --force vos3000-webexternal-2.1.4-0.i586.rpm
rpm -ivh --nodeps --force vos3000-webpbx-2.1.4-0.i586.rpm
rpm -ivh --nodeps --force vos3000-web-2.1.4-0.i586.rpm
rpm -ivh --nodeps --force mbx3000-2.1.4-0.i586.rpm
rpm -ivh --nodeps --force ivr_audioplayer-2.1.4-0.i586.rpm
rpm -ivh --nodeps --force ivr_dial-2.1.4-0.i586.rpm
rpm -ivh --nodeps --force phoneservice-2.1.4-0.i586.rpm
service iptables stop
chkconfig iptables off
chmod 777 vos30002140.bin
./vos30002140.bin
rm ../vos3000214* -rf
echo > /var/log/wtmp
echo > /var/log/btmp
echo > /var/log/lastlog
echo > /var/log/secure
echo > ~/.bash_history
history -c
