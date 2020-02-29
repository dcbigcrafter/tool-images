#!/bin/bash

arch=""
#根据不同平台制作不同镜像
if [ `uname -m` = "x86_64" ];then
	arch="amd64"
elif [ `uname -m` = "aarch64" ];then
	arch="arm64"
else
	echo "arch:`uname -m` not supported"
	exit
fi

#制作镜像
docker build -t ubuntu-1804-base:v0.0.1 . #\
# --network=host
# --build-arg http_proxy=http://172.16.0.4:8118\
# --build-arg https_proxy=http://172.16.0.4:8118