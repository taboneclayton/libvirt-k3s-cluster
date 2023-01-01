locals {
  inventory_file = "${abspath(path.module)}/inventory/hosts.ini"
}

resource "local_file" "hosts_ini" {
  content = templatefile(
    "${path.module}/templates/hosts.ini.tftpl",
    {
      master_ips = var.master_ips,
      node_ips = var.node_ips
    }
  )

  filename = local.inventory_file
}

resource "null_resource" "run_playbook" {
  count = fileexists("${var.ansible_playbook_path}/site.yml") ? 1 : 0
  depends_on = [local_file.hosts_ini]

  provisioner "local-exec" {
    command = "su ${var.ansible_user} -c 'ansible-playbook site.yml -i ${local.inventory_file}'"

    working_dir = var.ansible_playbook_path

    environment = {
      LC_ALL = "mt_MT.UTF-8",
      ANSIBLE_K3S_LOG_DIR = var.ansible_k3s_log_path
    }
  }
}
