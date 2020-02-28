#!/bin/bash

#---------------
#软件包路径
softPath="./softs"
confPath="./confs"
goPackage="go1.13.5.linux-amd64.tar.gz"
#---------------

#挂代理
export http_proxy=http://172.16.0.4:8118
export https_proxy=http://172.16.0.4:8118

#安装工具软件
yum -y install wget vim git

#配置golang环境
mkdir -p /opt/programs /opt/workspace/bin /opt/workspace/pkg /opt/workspace/src
tar zxvf $softPath/$goPackage -C /opt/programs/
echo -e "\n#set Golang environment\nexport GOROOT=/opt/programs/go\nexport GOPATH=/opt/workspace\nexport PATH=\$GOROOT/bin:\$GOPATH/bin:\$PATH" >> /etc/profile
source /etc/profile

#安装docker-ce
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
#配置docker代理
mkdir -p /etc/systemd/system/docker.service.d
cp $confPath/https-proxy.conf /etc/systemd/system/docker.service.d
#启动docker
systemctl enable docker && systemctl start docker

#安装kubectl
#curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
#chmod +x ./kubectl
#mv ./kubectl /usr/local/bin
cp $softPath/kubectl /usr/local/bin/

#安装helm
cp $softPath/helm /usr/local/bin/

#安装kind
cp $softPath/kind /usr/local/bin/

#kubectl命令补全
yum install -y bash-completion
echo "source /usr/share/bash-completion/bash_completion" >>  ~/.bashrc
echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'source <(helm completion bash)' >>~/.bashrc
echo 'source <(kind completion bash)' >>~/.bashrc
echo 'export GOPROXY=https://goproxy.io' >>~/.bashrc

yum clean all -y
