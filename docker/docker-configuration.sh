#!/bin/bash

#配置开机启动且立即启动docker容器
systemctl enable docker --now 

#创建docker配置
mkdir -p /etc/docker 

#配置docker的镜像加速
tee /etc/docker/daemon.json <<-EOF
{
  "registry-mirrors": ["https://3iln6kd8.mirror.aliyuncs.com"],
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

#加载配置
systemctl daemon-reload 
#重启docker
systemctl restart docker

docker version