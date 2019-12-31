FROM centos:7

# LANG
ENV LC_ALL=en_US.UTF-8 \
    TZ=Asia/Shanghai \
    GOPROXY=https://goproxy.cn
    #GOPROXY=https://goproxy.io
    
COPY ./go /usr/local/go
COPY ./docker /usr/bin/docker
COPY ./proxy.txt /proxy.txt

RUN cp /usr/local/go/bin/go /usr/local/bin/go && \
    yum install -y wget git vim make openssh-clients gcc g++ mysql-client bind-utils net-tools && \
    rpm -ivh https://repo.mysql.com/mysql80-community-release-el7.rpm && \
    yum install -y mysql-community-client && \
    yum clean all && \
    rm -rf /var/cache/yum/*
