# Download image if it does not exist already
resource "null_resource" "download_image" {
  count = fileexists("${path.root}/images/${var.disk_image_name}") ? 0 : 1
  provisioner "local-exec" {
    command = "wget '${var.disk_image_source}' -o ${var.disk_image_name}"

    working_dir = "${path.root}/images/"
  }
}

# Resize image
resource "null_resource" "resize_image" {
  depends_on = [null_resource.download_image]

  provisioner "local-exec" {
    command = "qemu-img resize ${var.disk_image_name} ${var.storage_size}"

    working_dir = "${path.root}/images/"
  }
}
