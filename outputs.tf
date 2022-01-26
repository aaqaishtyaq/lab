output "k3s-api-ip" {
  value = module.oci-lab-k3s.k3s-api-ip
}

output "loadbalaner-ip" {
  value = "http://${module.oci-lab-k3s.loadbalacer_ip}"
}
