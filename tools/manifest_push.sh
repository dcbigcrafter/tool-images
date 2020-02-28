#!/bin/bash

#定义镜像来源与所要推送的目标镜像名称版本号
sourceAmd=""    #amd镜像地址
sourceArm=""    #arm镜像地址
TargetDomain="" #target registry domain
targetRepo=""   #target repo
targetTag=""    #target image tag

#预定义好目标镜像的全称
targetFull=$TargetDomain$targetRepo:$targetTag
targetFullAmd=$TargetDomain$targetRepo-amd64:$targetTag
targetFullArm=$TargetDomain$targetRepo-arm64:$targetTag

#tag
docker tag $sourceAmd $targetFullAmd
docker tag $sourceArm $targetFullArm

#推送镜像
docker push $targetFullAmd
docker push $targetFullArm

#制作manifest并推送
docker manifest create --insecure --amend $targetFull $targetFullAmd $targetFullArm
docker manifest annotate $targetFull $targetFullAmd --arch=amd64
docker manifest annotate $targetFull $targetFullArm --arch=arm64
docker manifest push --purge --insecure $targetFull
