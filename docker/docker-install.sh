#!/bin/bash

#查看系统是否已安装docker
rpm -qa|grep docker

#卸载旧版本docker
yum remove docker*

#安装yum工具
yum install -y yum-utils  device-mapper-persistent-data  lvm2

#配置docker的yum下载地址
yum-config-manager \
--add-repo \
http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

#生成缓存
yum makecache 

#查看docker版本
yum list docker-ce --showduplicates | sort -r

#安装docker的指定版本
yum install -y docker-ce-19.03.9-3.el7 docker-ce-cli-19.03.9-3.el7 containerd.io
