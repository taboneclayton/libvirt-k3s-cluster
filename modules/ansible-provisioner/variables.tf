variable "master_ips" {
  description = "List of Master/Server IPs to be part of the Ansible inventory."
  type        = list(string)
}

variable "node_ips" {
  description = "List of Node/Agent IPs to be part of the Ansible inventory."
  type        = list(string)
}

variable "ansible_playbook_path" {
  description = "The root path of the Ansible playbook to be triggered by Terraform. See README for more details."
  type        = string
}

variable "ansible_user" {
  description = "The user which will run the Ansible playbook"
  type        = string
}

variable "ansible_k3s_log_path" {
  description = "The local path where the remote logs from each master node will be copied"
  type        = string
  default     = "/tmp/k3s-ansible/logs"
}
