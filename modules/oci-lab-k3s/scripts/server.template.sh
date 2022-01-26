#!/bin/bash
set -x

apt-get update && apt-get -y install netcat-openbsd

iptables -w 60 -I INPUT -i ens3 -p tcp -s 10.0.0.0/8  --dport 6443 -j ACCEPT
iptables -w 60 -I INPUT -i ens3 -p tcp -s 10.0.0.0/8  --dport 8472 -j ACCEPT
iptables -w 60 -I INPUT -i ens3 -p tcp -s 10.0.0.0/8  --dport 10250 -j ACCEPT

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--no-deploy traefik" K3S_CLUSTER_SECRET='${cluster_token}' sh -s - server --tls-san="k3s.local" --node-taint node-role.kubernetes.io/master=true:NoSchedule

while ! nc -z localhost 6443; do
  sleep 1
done

mkdir /home/ubuntu/.kube
cp /etc/rancher/k3s/k3s.yaml /home/ubuntu/.kube/config
sed -i "s/127.0.0.1/$(curl -s ifconfig.co)/g" /home/ubuntu/.kube/config
chown ubuntu:ubuntu /home/ubuntu/.kube/ -R

iptables -w 60 -I INPUT -i ens3 -p tcp --dport 6443 -j ACCEPT

# Persist the rules

sed -i -e '/^-A INPUT -j REJECT.*/i -A INPUT -i ens3 -p tcp --dport 6443 -j ACCEPT' /etc/iptables/rules.v4
sed -i -e '/^-A INPUT -j REJECT.*/i -A INPUT -i ens3 -p tcp -s 10.0.0.0/8  --dport 8472 -j ACCEPT' /etc/iptables/rules.v4
sed -i -e '/^-A INPUT -j REJECT.*/i -A INPUT -i ens3 -p tcp -s 10.0.0.0/8  --dport 10250 -j ACCEPT' /etc/iptables/rules.v4
