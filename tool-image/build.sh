#!/bin/bash

set -e

go_version="1.13.5"
docker_version="19.03.5"
#download link https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
go_download_link="https://dl.google.com/go/go$go_version.linux-amd64.tar.gz"
#docker binary package
docker_download_link="https://download.docker.com/linux/static/stable/x86_64/docker-$docker_version.tgz"
#package name
go_package_name="go$go_version.linux-amd64.tar.gz"
docker_package_name="docker-$docker_version.tgz"
#untar dir name
go_dir_name="go"
docker_dir_name="docker"

#ensure golang package has been downloaded
if [ ! -f "$go_package_name" ]; then
  wget $go_download_link
fi
if [ ! -d "$go_dir_name" ]; then
  tar zxf $go_package_name
fi

if [ ! -f "$docker_package_name" ]; then
  wget $docker_download_link
fi
if [ ! -d "$docker_dir_name" ]; then
  tar zxf $docker_package_name
fi

#copy files to context
rm -rf context
mkdir context
cp proxy.txt context/
cp Dockerfile context/
cp -r $go_dir_name context/
cp -r $docker_dir_name/docker context/

#build image
docker build -t tool-image-amd64:`cat Version` context
rm -rf context