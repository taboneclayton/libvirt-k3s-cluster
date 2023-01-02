provider "libvirt" {
  # Connect to the local Qemu instance. See https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs#the-connection-uri
  uri = "qemu:///system"
}

# Network for the k3s nodes
module "k3s-network" {
  source = "./modules/k3s-network"
}

# Network for the k3s nodes
module "os-image" {
  source = "./modules/os-image"
}

# Server nodes aka master nodes
module "k3s-server-nodes" {
  count = var.k3s_server_node_instances
  source = "./modules/ubuntu-cloud-server"

  domain_name = "K3s Server Node ${count.index}"
  storage_pool_name = "k3s-server-${count.index}-pool"
  disk_image_name = "images/${module.os-image.disk_image_name}"
  hostname = "k3s-server-${count.index}"
  hashed_password = var.hashed_password
  ssh_public_key = var.ssh_public_key
  k3s_network_id = module.k3s-network.network_id

  depends_on = [module.os-image]
}

# Agent nodes aka worker nodes
module "k3s-agent-nodes" {
  count = var.k3s_agent_node_instances
  source = "./modules/ubuntu-cloud-server"

  domain_name = "K3s Agent Node ${count.index}"
  storage_pool_name = "k3s-agent-${count.index}-pool"
  disk_image_name = "images/${module.os-image.disk_image_name}"
  hostname = "k3s-agent-${count.index}"
  hashed_password = var.hashed_password
  ssh_public_key = var.ssh_public_key
  k3s_network_id = module.k3s-network.network_id

  depends_on = [module.os-image]
}

# Ansible provisioner which populates the inventory file and calls Ansible at the path specified
module "ansible-provisioner" {
  source = "./modules/ansible-provisioner"

  ansible_playbook_path = var.ansible_playbook_path
  ansible_user = var.ansible_user
  master_ips = module.k3s-server-nodes[*].ips[0]
  node_ips = module.k3s-agent-nodes[*].ips[0]
}
