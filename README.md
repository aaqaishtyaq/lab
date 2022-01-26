# Lab

Create a k3s cluster on Oracle Cloud's free for life tier.

This is based on [Medium article](https://chris-graham.medium.com/create-a-free-k3s-cluster-in-oracle-cloud-using-the-always-free-tier-7c4bc50072cc)

Trying to make the setup more stable and tailored to my needs which are:

* No separate "DB" machine; databases can run on the cluster too
* Keep the ARM machines up since they are difficult to obtain at the moment
* Make the loadbalancer and ingress use 443 and 80, and have a cert-manager for letsencrypt certificates
* Be able to use any ports? -> eg for a jamulus server
* Try and use longhorn or something so we have a distributed persistent storage

## TODO

* [x] fix iptables so metrics etc work
  * [x] Set in cloud-init does not survive reboot - make it permanent
* [ ] Put the kubernetes/helm part in a different tf module
* [ ] Fix nginx-controller
  * [ ] resource requests so HPA can work
  * [x] Make sure that the controller pod(s) do(es) not start on server
  * [ ] Figure out how to serve all the workers - do i need a controller pod per worker?
* [x] Try out loadbalancer
* [ ] Make a network loadbalancer for non-http traffic
* [ ] Try out trafik instead of nginx as ingress
* [ ] Figure out arm workers!
  * [x] Make arm worker group
  * [ ] Figure a way that the arm workers stay up through tf destroy
    * May need two seperate terraform projects?
    * Figure out how to use the data from one in the other
* [ ] Long goal - longhorn?
