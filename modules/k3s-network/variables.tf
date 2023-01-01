variable "k3s_network_name" {
  description = "Network name used by libvirt for the K3s Network."
  type        = string
  default     = "k3snet"
}

variable "domain" {
  description = "Domain used by the DNS server in this network"
  type        = string
  default     = "k3s.local"
}

variable "subnet_addresses" {
  description = "List of subnets allowed for any domains connected. Also derived to define the host addresses and the addresses served by the DHCP server."
  type        = list
  default     = ["10.0.99.0/24"]
}
