#!/bin/bash
free -h

##关闭swap分区
swapoff -a  
sed -ri 's/.*swap.*/#&/' /etc/fstab 

## 把SELinux 设置为 permissive 模式（相当于禁用）
setenforce 0 
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config 

## 允许 iptables 检查桥接流量 
cat <<EOF | tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

free -h
