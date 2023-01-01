# Images

This folder will be used by the Terraform configuration to download an OS image. If you want to manually copy an image here, make sure that the name matches the value specified in `var.disk_image_name`. Terraform will skip the download if it finds an image with the given name in this folder. Also make sure that the size specified in `var.storage_size` matches your desired storage size. The `qemu-img` is not being called with the `--shrink` option to avoid data loss should the default image size exceed the value configured in `var.storage_size`. Refer to the [main README](../README.md) for considerations related to the image size.

The [download-and-resize.sh](./download-and-resize.sh) is offered as a convenience script to help with the manual download and resize of an OS image. You do not need to call this script if you want Terraform to download the image automatically.

Usage:

```download-and-resize.sh -u 'https://cloud-images.ubuntu.com/releases/22.10/release/ubuntu-22.10-server-cloudimg-amd64.img' -f disk.img -s 6G```
