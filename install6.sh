#!/bin/bash
yum install -y tcl-devel
yum install -y expect
  selinux_ep=`grep SELINUX=disabled /etc/selinux/config | wc -l`
  iptables_stop=`service iptables status | wc -l`
  mysql_libs=`rpm -qa |grep mysql`
  unzip_up=`rpm -qa |grep unzip | wc -l`
  kernel_replace=`rpm -qa |grep kernel-2.6.32-358 | wc -l`

  function selinux_ep(){
      if  [[ $selinux_ep -lt 1 ]];then
           sed -i 's#SELINUX=enforcing#SELINUX=disabled#g' /etc/selinux/config
           echo -e "\033[33mselinux\033[0m                                  [\033[32m  OK  \033[0m]"
      else
           echo -e "\033[33mselinux\033[0m                                  [\033[32m  OK  \033[0m]"
      fi
  }
  function iptables_stop(){
      if  [[ $iptables_stop -gt 5  ]];then
           service iptables stop && chkconfig iptables off
           echo -e "\033[33miptables\033[0m                                 [\033[32m  OK  \033[0m]"
      else
           echo -e "\033[33miptables\033[0m                                 [\033[32m  OK  \033[0m]"
      fi
  }
  function mysql_libs(){
      echo -e "\033[33m$mysql_libs\033[0m"
      if  [[ $? == 0 ]];then
           yum remove -y $mysql_libs > /dev/null 2>&1
           echo -e "\033[33mmysql-libs\033[0m                               [\033[32m  OK  \033[0m]"
      else
           echo -e "\033[33mmysql-libs\033[0m                               [\033[32m  OK  \033[0m]"
      fi
  }
  function unzip_up(){
      if  [[ $unzip_up -lt 1  ]];then
           yum install -y unzip > /dev/null 2>&1
           echo -e "\033[33munzip\033[0m                                    [\033[32m  OK  \033[0m]"
      else
           echo -e "\033[33munzip\033[0m                                    [\033[32m  OK  \033[0m]"
      fi
  }
  selinux_ep
  iptables_stop
  mysql_libs
  unzip_up
rpm -ivh --nodeps --force kernel-2.6.32-358.0.1.el6.x86_64.rpm
reboot
