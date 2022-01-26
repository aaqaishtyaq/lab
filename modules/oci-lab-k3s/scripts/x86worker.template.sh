#!/bin/bash
set -x

iptables -w 60 -I INPUT -i ens3 -p tcp -s 10.0.0.0/8  --dport 8472 -j ACCEPT
iptables -w 60 -I INPUT -i ens3 -p tcp -s 10.0.0.0/8  --dport 10250 -j ACCEPT

curl -sfL https://get.k3s.io | K3S_URL=https://server.public.main.oraclevcn.com:6443 K3S_CLUSTER_SECRET='${cluster_token}' sh -

# Persist the rules

sed -i -e '/^-A INPUT -j REJECT.*/i -A INPUT -i ens3 -p tcp -s 10.0.0.0/8  --dport 8472 -j ACCEPT' /etc/iptables/rules.v4
sed -i -e '/^-A INPUT -j REJECT.*/i -A INPUT -i ens3 -p tcp -s 10.0.0.0/8  --dport 10250 -j ACCEPT' /etc/iptables/rules.v4
