FROM centos:7

# Set LANG
ENV LC_ALL en_US.UTF-8

# set TIME Zone
ENV TZ Asia/Shanghai

RUN yum upgrade -y &&\
	yum install -y openssh-clients &&\
	yum upgrade -y &&\
	yum clean all && rm -rf /var/cache/yum/* 