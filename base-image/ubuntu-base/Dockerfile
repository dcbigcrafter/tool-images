FROM ubuntu:18.04

# LANG
ENV LANG C.UTF-8

# TIME Zone
#ENV TZ Asia/Shanghai
COPY ./Shanghai /usr/share/zoneinfo/Asia/Shanghai
COPY ./Shanghai /etc/localtime

RUN apt update &&\
	apt install -y curl inetutils-ping &&\
	apt update &&\
	apt upgrade -y &&\
	apt autoclean &&\
	apt autoremove