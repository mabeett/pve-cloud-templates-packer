# locals for systemrescueCD boot


local "iso_boot_command" {
  expression = ["<tab> nofirewall rootpass=${var.ssh_password} <wait1><enter>"]
  sensitive  = true
}

# extra routes for wireguard client
local "wireguard_client_extra_routes" {
  expression = jsonencode({ "wireguard_client_extra_routes" = var.wireguard_client_extra_routes })
  sensitive  = true
}
