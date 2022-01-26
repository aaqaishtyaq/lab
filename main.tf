module "oci-lab-k3s" {
  source = "./modules/oci-lab-k3s"

  # General
  project_name   = "ailab"
  region         = var.region
  compartment_id = "ocid1.compartment.oc1..aaaaaaaa4msc2cl35phbjsuvh4wh2xql3m3x232corg6zrpop7hl6mlwwzka"
  ssh_public_key = file("~/.ssh/id_rsa.pub")

  # Network
  whitelist_subnets = [
    "0.0.0.0/0",
    "10.0.0.0/8"
  ]

  vcn_subnet     = "10.0.0.0/16"
  public_subnet  = "10.0.0.0/23"

  freetier_server_ad_list = 1
  freetier_worker_ad_list = [ 1 ]
}
