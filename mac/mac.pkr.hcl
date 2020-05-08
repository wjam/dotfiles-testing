source "virtualbox-vm" "mac" {
  vm_name = "macOS Catalina"
  attach_snapshot = "with-ssh-server"
  ssh_username = "${var.username}"
  ssh_password = "${var.password}"
  communicator = "ssh"
  shutdown_command = "echo '${var.password}'|sudo -S shutdown -h now"
  guest_additions_mode = "disable"

  target_snapshot = "for-testing"
  skip_export = true
  keep_registered = true
  force_delete_snapshot = true
}

build {
  sources = [
    "source.virtualbox-vm.mac"
  ]

  provisioner "file" {
    source = "${var.dotfiles}"
    destination = "/Users/${var.username}/.dotfiles"
  }
}

variable "username" {
  default = "wjam"
}
variable "password" {
  default = "password"
}
variable "dotfiles" {
  default = "/Users/wjam/.dotfiles"
}
