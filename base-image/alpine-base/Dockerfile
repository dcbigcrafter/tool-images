FROM alpine:3.11.2

RUN alias ll='ls -alF' && \
 echo "http://mirrors.aliyun.com/alpine/v3.11/main" > /etc/apk/repositories && \
 apk update && apk upgrade && \
 apk add --no-cache bash openssh git vim tzdata curl && \
 cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
 apk del tzdata && \
 rm -rf /var/cache/apk/* && \
 rm -rf /root/.cache && \
 rm -rf /tmp/*
