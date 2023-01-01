variable "k3s_server_node_instances" {
  description = "Number of K3s Server Nodes."
  type        = number
  default     = 3
}

variable "k3s_agent_node_instances" {
  description = "Number of K3s Agent Nodes."
  type        = number
  default     = 2
}

variable "hashed_password" {
  description = "Hashed password to be set in the user-data portion of the cloud-init configuration. See README for more details."
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key to be set in the user-data portion of the cloud-init configuration."
  type        = string
}

variable "ansible_user" {
  description = "The user which will run the Ansible playbook"
  type        = string
}

variable "ansible_playbook_path" {
  description = "The absolute root path of the Ansible playbook to be triggered by Terraform. See README for more details."
  type        = string
}
