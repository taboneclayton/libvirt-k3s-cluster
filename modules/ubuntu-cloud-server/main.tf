# Define Storage Pool
resource "libvirt_pool" "ubuntu-pool" {
  name = var.storage_pool_name
  type = "dir"
  path = "${var.storage_pool_base_path}${var.storage_pool_name}"
}

# Define VM Volume
resource "libvirt_volume" "ubuntu-qcow2" {
  name   = "ubuntu-qcow2"
  pool   = libvirt_pool.ubuntu-pool.name
  source = var.disk_image_name
  format = "qcow2"

  # The size of an existing image cannot be resized via the provider. Consult the "Resize the Volume" section in the README.
  # size   = NOT POSSIBLE!
}

# Use CloudInit to configure the VM
resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "commoninit.iso"
  pool      = libvirt_pool.ubuntu-pool.name
  user_data = data.template_file.user_data.rendered
  meta_data = data.template_file.meta_data.rendered
}

# Get user data info
data "template_file" "user_data" {
  template = file("${path.module}/cloud-init/user-data.yaml")
  vars = {
    hashed_password = var.hashed_password
    ssh_public_key = var.ssh_public_key
  }
}

# Get metadata info
data "template_file" "meta_data" {
  template = file("${path.module}/cloud-init/meta-data.yaml")
  vars = {
    hostname = var.hostname
  }
}

# Define KVM domain to create
resource "libvirt_domain" "ubuntu" {
  name = var.domain_name
  vcpu = var.vcpu_count
  memory = var.memory_amount

  disk {
    volume_id = "${libvirt_volume.ubuntu-qcow2.id}"
  }

  network_interface {
    network_id     = var.k3s_network_id
    hostname       = var.hostname
    wait_for_lease = true
  }

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  autostart = true

  qemu_agent = true
}
