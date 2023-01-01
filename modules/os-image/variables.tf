variable "storage_size" {
  description = "The size of the storage volume assigned to the Virtual Machine. See README for more details."
  type        = string
  default     = "6G"
}

variable "disk_image_name" {
  description = "Name of disk image under the images folder."
  type        = string
  default     = "disk.img"
}

variable "disk_image_source" {
  description = "Source for the Ubuntu Cloud Server Image."
  type        = string
  default     = "https://cloud-images.ubuntu.com/releases/22.10/release/ubuntu-22.10-server-cloudimg-amd64.img"
}
