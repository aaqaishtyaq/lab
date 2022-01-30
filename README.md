# Lab

Create a k3s cluster on Oracle Cloud's free for life tier.

This was initially based on this [Medium article](https://chris-graham.medium.com/create-a-free-k3s-cluster-in-oracle-cloud-using-the-always-free-tier-7c4bc50072cc)

Trying to make the setup more stable and tailored to my needs which are:

* No separate "DB" machine; databases can run on the cluster too
* One x86 master and an aarch64 worker node
* Make the loadbalancer and ingress use 443 and 80, and have a cert-manager for letsencrypt certificates
* Be able to use any ports? -> eg for a jamulus server
* Try and use longhorn or something so we have a distributed persistent storage

## Features

### Infrastructure

Oracle Cloud was chosen due to their very generous free tier.

| Provider        | Service                           | Usage             | Pricing                        |
| :--             | :--                               | :--               | :--                            |
| Oracle Cloud    | Virtual Cloud Network             | 1                 | Free                           |
| Oracle Cloud    | `VM.Standard.E2.1.Micro` (AMD64)  | 1 core, 1GB mem   | Free                           |
| Oracle Cloud    | `VM.Standard.A1.Flex` (ARM)       | 4 cores, 24GB mem | Free                           |
| Oracle Cloud    | Block Storage                     | 200GB             | Free                           |

### Applications

* [ ] Web analytics
* [ ] Tailscale VPN
* [ ] Cgit
* [ ] TBD

## TODO

* [x] fix iptables so metrics etc work
  * [x] Set in cloud-init does not survive reboot - make it permanent
* [ ] Fix nginx-controller
  * [ ] resource requests so HPA can work
  * [x] Make sure that the controller pod(s) do(es) not start on server
* [x] Try out loadbalancer
* [ ] Make a network loadbalancer for non-http traffic
* [ ] Try out trafik instead of nginx as ingress
* [ ] Long goal - longhorn?
