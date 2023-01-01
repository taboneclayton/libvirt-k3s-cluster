output "ips" {
  value = flatten("${libvirt_domain.ubuntu.*.network_interface.0.addresses}")
}
