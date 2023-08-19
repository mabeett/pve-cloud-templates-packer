# locals for systemrescueCD boot

variable "iso_boot_command_suffix" {
  type    = string
  default = "console=tty0 console=ttyS0,115200n8"
}

variable "iso_boot_command_prefix" {
  type    = string
  default = ""
}

local "iso_boot_command" {
  expression = ["<tab> ${var.iso_boot_command_prefix} nofirewall rootpass=${var.ssh_password} ${var.iso_boot_command_suffix} <wait1><enter>"]
  sensitive  = true
}


