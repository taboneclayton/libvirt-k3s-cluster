variable "storage_pool_name" {
  description = "Storage pool name for the Ubuntu Cloud Server."
  type        = string
  default     = "ubuntu-cloud-pool"
}

variable "hostname" {
  description = "Hostname for the Ubuntu Cloud Server."
  type        = string
  default     = "ubuntu-cloud-server"
}

variable "storage_pool_base_path" {
  description = "Base path for the Ubuntu Cloud Server Storage Pool."
  type        = string
  default     = "/var/lib/libvirt/filesystems/terraform-provider-libvirt-pool-ubuntu/"
}

variable "domain_name" {
  description = "Server name used by libvirt for the Virtual Machine."
  type        = string
  default     = "Ubuntu Cloud Server"
}

variable "vcpu_count" {
  description = "Number of VCPUs assigned to the Virtual Machine"
  type        = number
  default     = 2
}

variable "memory_amount" {
  description = "Amount of memory (RAM) assigned to the Virtual Machine"
  type        = string
  default     = "4096"
}

variable "disk_image_name" {
  description = "Name of disk image under the images folder."
  type        = string
}

variable "k3s_network_id" {
  description = "Network id. This is the id generated by libvirt_network."
  type        = string
}

variable "hashed_password" {
  description = "Encoded password to be set in the user-data portion of the cloud-init configuration."
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key to be set in the user-data portion of the cloud-init configuration."
  type        = string
}
