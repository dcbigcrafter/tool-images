#!/bin/bash

#关闭SELINUX
setenforce 0
sed -i 's/SELINUX=*/SELINUX=disabled/' /etc/selinux/config

#关闭防火墙
systemctl disable firewalld && systemctl stop firewalld

#关闭swap
swapoff -a && echo "vm.swappiness=0" >> /etc/sysctl.conf && sysctl -p && free –h


iptables -P FORWARD ACCEPT


#配置ip转发（每台机器均执行）
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
sysctl -w net.ipv4.ip_forward=1

#写入hosts

#-------------------
#仅安装集群的机器需要
#-------------------

#在ansible-client机器上配置免密登录
ssh-keygen -t rsa
ssh-copy-id root@192.168.5.161 && ssh-copy-id root@192.168.5.162

#安装python和pip
yum install -y epel-release ansible gcc
yum install -y python36 python36-devel python36-pip
pip3 install --upgrade pip

#安装依赖 在kubespray文件夹下
pip install -r requirements.txt
