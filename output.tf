output "k3s-server-ips" {
  value = module.k3s-server-nodes[*].ips[0]
}

output "k3s-agent-ips" {
  value = module.k3s-agent-nodes[*].ips[0]
}
