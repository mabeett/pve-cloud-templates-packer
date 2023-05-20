# locals for systemrescueCD boot


local "iso_boot_command" {
  expression = ["<tab> nofirewall rootpass=${var.ssh_password} <wait1><enter>"]
  sensitive  = true
}


