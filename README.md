# libvirt-k3s-cluster
HA K3s cluster configured with the Terraform libvirt provider and provisioned using Ansible

The [libvirt terraform provider](https://registry.terraform.io/providers/dmacvicar/libvirt/latest) is used to configure Virtual Machines for multiple master/server nodes and multiple worker/agent nodes.


## Configure Variables
The [terraform.tfvars.example](./terraform.tfvars.example) includes some default values that you might want to change. Create a copy of this file in the same folder and name this copy `terraform.tfvars`.

The number of server nodes can be configured by changing the `k3s_server_node_instances`. If an HA cluster is required, a minimum of 3 server nodes are needed. For larger cluster sizes, it is recommended to always use an odd number of server nodes.

The number of worker nodes can be configured by changing the `k3s_agent_node_instances`. This value can be set to any number of nodes.

The `hashed_password` is omitted on purpose. This can be generated with the following command:

 ```mkpasswd --method=SHA-512 --rounds=4096```
 
For more details refer to the cloud-init docs [here](https://cloudinit.readthedocs.io/en/0.7.8/topics/examples.html)
This password is not needed for SSH access to the nodes, however it might be needed to access these via the Hypervisor console window.


## Resize Storage Volume
The Terraform configuration will change the volume size of the image provided. The default Ubuntu Server image size is  around 3.2 GB. This default size is enough to install K3s and the Qemu Guest Agent, but any meaningful deployments to Kubernetes will quickly fill the disk space.

The libvirt Terraform provider contains a `size` argument as documented [here](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/volume#size). Unfortunately the `size` argument cannot be used when an existing image is specified by the `source` argument. These two arguments are mutually exclusive and the `size` argument can only be used to create an empty volume of a given size. The image needs to be downloaded locally and resized. The image file can be downloaded manually and named as per `var.disk_image_name`. Should this file be missing from the [images](./images/) folder, Terraform will download this file from the URL provided in `var.disk_image_source` and place it in the [images](./images/) folder with the correct name. As a performance improvement Terraform will avoid downloading the same image all-over again if it's already present locally.

The resize will be done using the `qemu-img resize` command. Terraform only triggers this if a file with the name `var.disk_image_name` is missing from the [images](./images/) folder. The size can be modified by setting the `var.storage_size`. For more details about the format for this size, refer to the `qemu-img` documentation [here](https://qemu.readthedocs.io/en/latest/tools/qemu-img.html#cmdoption-qemu-img-common-opts-s).


## Provision with Ansible (Optional)
Terraform will create a `hosts.ini` under [modules/ansible-provisioner/inventory/](./modules/ansible-provisioner/inventory/). This inventory file can be passed to any Ansible playbook which you might want to trigger manually. Alternatively, the Ansible provisioner will also check if the path specified by `var.ansible_playbook_path` exists. If it exists, Terraform will run this playbook as `var.ansible_user` and pass the `hosts.ini` inventory file. Should your Ansible playbook require an inventory file with a different format, the [hosts.ini.tftpl](modules/ansible-provisioner/templates/hosts.ini.tftpl) file can be modified. For an example Ansible playbook you can refer to [https://github.com/taboneclayton/k3s-ansible](https://github.com/taboneclayton/k3s-ansible)
